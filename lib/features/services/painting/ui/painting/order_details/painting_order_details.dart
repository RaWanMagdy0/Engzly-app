import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/logic/painting_states.dart';
import 'package:engzly/features/services/painting/ui/painting/order_details/widgets/painting_order_item.dart';
import 'package:engzly/features/services/painting/ui/painting/order_details/widgets/painting_order_map.dart';
import 'package:engzly/features/services/painting/ui/painting/order_details/widgets/painting_order_summry.dart';
import 'package:engzly/features/services/painting/ui/painting/order_details/widgets/painting_payment_method.dart';
import 'package:engzly/features/services/painting/ui/painting/order_details/widgets/painting_promo_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaintingOrderDetails extends StatefulWidget {
  const PaintingOrderDetails({super.key});

  @override
  State<PaintingOrderDetails> createState() => _PaintingOrderDetails();
}

class _PaintingOrderDetails extends State<PaintingOrderDetails>
    with WidgetsBindingObserver {
  String selectedPaymentMethod = 'online';
  final ScrollController _scrollController = ScrollController();

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
    final keyboardVisible = bottomInset > 0.0;
    if (keyboardVisible) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaintingCubit, PaintingStates>(
      listener: (context, state) async {
        if (state is PaintingCheckOutOrderSuccess) {
          final response = state.booking.first;
          if (selectedPaymentMethod == 'online') {
            final clientSecret = response.data?.clientSecret;
            if (clientSecret != null) {
              await handleStripePayment(context, clientSecret);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment data not found')),
              );
            }
          } else {
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.paintingOrderConfirmation,
                (route) => false,
              );
            }
          }
        }

        if (state is PaintingCheckOutOrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is PaintingCheckOutOrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.watch<PaintingCubit>();
        double basePrice = cubit.selectedHouseSizePrice?.toDouble() ?? 0;
        double personCost = cubit.requiredPersons * 5;
        double colorCost = 100;
        double hourlyRate = basePrice + personCost + colorCost;
        double serviceCharge = 50;
        double subtotal = hourlyRate + serviceCharge;

        double discount = 0;
        if ((cubit.discountPercentage ?? 0) > 0) {
          discount = subtotal * (cubit.discountPercentage! / 100);
        }

        double totalAfterDiscount = subtotal - discount;

        return CustomScaffoldScreen(
          title: Text(
            "Order Details",
          ),
          leadingIcon: SvgPicture.asset(AppImages.backArrow,
              width: 22.w, height: 22.h, color: ColorsManager.black),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h, color: ColorsManager.black),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PaintingOrderMap(location: cubit.address ?? ''),
                      10.verticalSpace,
                      PaintingOrderItem(
                        icon: '🏠',
                        title: cubit.selectedHouseSize?.name ??
                            "No house selected",
                        subtitle: '1 Kitchen Included',
                        price: cubit.selectedHouseSizePrice != null
                            ? "${cubit.selectedHouseSizePrice}/hr"
                            : "—",
                        backgroundColor: const Color(0xFFFFE0B2),
                      ),
                      PaintingOrderItem(
                        icon: '👷',
                        title: '${cubit.requiredPersons} Person',
                        subtitle: '+\$5 for additional Person',
                        price: "${personCost.toStringAsFixed(0)}/hr",
                        backgroundColor: const Color(0xFFFFE0B2),
                      ),
                      PaintingOrderItem(
                        icon: '🎨',
                        title: '',
                        subtitleWidget: Image.network(
                          cubit.selectedColor?.colorIcon ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
                        ),
                        subtitle: '',
                        price: "100",
                        backgroundColor: const Color(0xFFFFE0B2),
                      ),
                      PaintingOrderSummry(
                        label: 'Service Charge',
                        value: '\$${serviceCharge.toStringAsFixed(0)}',
                      ),
                      PaintingPromoCode(
                        appliedPromoCode: cubit.appliedPromoCode,
                        onApply: (code) => cubit.checkPromoCode(code),
                        onRemove: () => cubit.removePromoCode(),
                      ),
                      if (state is PaintingCheckOutOrderLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: ColorsManager.yellow,
                          ),
                        ),
                      Divider(color: Colors.grey.shade300),
                      PaintingOrderSummry(
                        label: 'Subtotal',
                        value: '\$${subtotal.toStringAsFixed(2)}',
                      ),
                      if (discount > 0)
                        PaintingOrderSummry(
                          label: 'Discount',
                          value: '-\$${discount.toStringAsFixed(2)}',
                        ),
                      Divider(color: Colors.grey.shade300),
                      PaintingOrderSummry(
                        label: 'Total',
                        value: '\$${totalAfterDiscount.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      20.verticalSpace,
                      PaintingPaymentMethod(
                        selectedMethod: selectedPaymentMethod,
                        onMethodChanged: (method) {
                          setState(() => selectedPaymentMethod = method);
                        },
                      ),
                      80.verticalSpace,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 15.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    textStyle: AppFonts.font14BWhiteWeight700,
                    borderRadius: 15.r,
                    height: 50.h,
                    text: state is PaintingCheckOutOrderLoading
                        ? "Processing..."
                        : "Proceed (\$${totalAfterDiscount.toStringAsFixed(0)})",
                    color: state is PaintingCheckOutOrderLoading
                        ? Colors.grey
                        : ColorsManager.yellow,
                    onPressed: state is PaintingCheckOutOrderLoading
                        ? null
                        : () {
                            if (cubit.selectedHouseSize == null ||
                                cubit.address == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please complete all required fields"),
                                ),
                              );
                              return;
                            }

                            cubit.checkOut(
                              colorId: cubit.selectedColor?.id ?? 0,
                              schedule: cubit.selectedDate!,
                              totalPrice: totalAfterDiscount,
                              serviceId: 3,
                              location: cubit.address!,
                              promoCodes: cubit.appliedPromoCode ?? '',
                              paymentMethodId:
                                  selectedPaymentMethod == 'online' ? 1 : 2,
                              houseSizeId: cubit.selectedHouseSize!.id,
                            );
                          },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> handleStripePayment(
      BuildContext context, String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Engzly App',
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: true,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.paintingOrderConfirmation,
          (route) => false,
        );
      }
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: ${e.error.localizedMessage}'),
          backgroundColor: ColorsManager.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }
}
