import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/cleaning/ui/ui/cleaning_order_confirmation.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_content.dart';
import 'package:engzly/features/payment/service_payment_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CleaningOrderDetails extends StatefulWidget {
  const CleaningOrderDetails({super.key});

  @override
  State<CleaningOrderDetails> createState() => _CleaningOrderDetails();
}

class _CleaningOrderDetails extends State<CleaningOrderDetails>
    with WidgetsBindingObserver {
  String selectedPaymentMethod = 'online';
  final ScrollController _scrollController = ScrollController();
  double? distanceInMeters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CleaningCubit, CleaningStates>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final cubit = context.watch<CleaningCubit>();

        return CustomScaffoldScreen(
          title: Text("Order Details"),
          leadingIcon: SvgPicture.asset(AppImages.backArrow,
              width: 22.w, height: 22.h, color: ColorsManager.black),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h, color: ColorsManager.black),
          child: CleaningOrderContent(
            scrollController: _scrollController,
            cubit: cubit,
            state: state,
            distanceInMeters: distanceInMeters,
            selectedPaymentMethod: selectedPaymentMethod,
            onDistanceCalculated: (distance) {
              setState(() => distanceInMeters = distance);
            },
            onPaymentMethodChanged: (method) {
              setState(() => selectedPaymentMethod = method);
            },
          ),
        );
      },
    );
  }

  void _handleStateChanges(BuildContext context, CleaningStates state) async {
    final cubit = context.read<CleaningCubit>();

    if (state is CleaningCheckOutOrderSuccess) {
      final data = state.booking.first.data;

      final paymentData = CheckoutPaymentData(
        clientSecret: data?.clientSecret,
        paymentUrl: data?.stripePaymentIntentId,
        paymentMethod: selectedPaymentMethod,
        onlinePaymentType: cubit.selectedPaymentType,
      );

      final paymentSuccess = await PaymentService.processPayment(
        context: context,
        paymentData: paymentData,
        merchantName: 'Engzly App',
      );

      if (paymentSuccess && context.mounted) {
        _navigateToConfirmation(context, cubit);
      }
    }

    if (state is CleaningCheckOutOrderError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  void _navigateToConfirmation(BuildContext context, CleaningCubit cubit) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: CleaningOrderConfirmation(cubit: cubit),
        ),
      ),
      (route) => false,
    );
  }
}
