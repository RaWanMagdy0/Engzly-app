import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_states.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/widgets/vehicle_order_item.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/widgets/vehicle_order_map.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/widgets/vehicle_order_summry.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/widgets/vehicle_payment_method.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/widgets/vehicle_promo_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VehicleOrderDetails extends StatefulWidget {
  const VehicleOrderDetails({super.key});

  @override
  State<VehicleOrderDetails> createState() => _VehicleOrderDetails();
}

class _VehicleOrderDetails extends State<VehicleOrderDetails>
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
    return BlocConsumer<VehicleCubit, VehicleStates>(
      listener: (context, state) async {
        if (state is VehicleCheckOutOrderSuccess) {
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
                RouteName.vehicleOrderConfirmation,
                (route) => false,
              );
            }
          }
        }

        if (state is VehicleCheckOutOrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.watch<VehicleCubit>();
        double basePrice = cubit.selectedVehcilePrice?.toDouble() ?? 0;
        double personCost = cubit.requiredPersons * 5;
        double hourlyRate = basePrice + personCost;
        double totalHourCost = cubit.workingHours * hourlyRate;
        double serviceCharge = 50;
        double subtotal = totalHourCost + serviceCharge;

        double discount = 0;
        if ((cubit.discountPercentage ?? 0) > 0) {
          discount = subtotal * (cubit.discountPercentage! / 100);
        }

        double totalAfterDiscount = subtotal - discount;

        return CustomScaffoldScreen(
          title: Text(
            "Order Details",
          ),
          leadingIcon:
              SvgPicture.asset(AppImages.backArrow, width: 22.w, height: 22.h,color: ColorsManager.black),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h,color: ColorsManager.black),
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
                      VehicleOrderMap(location: cubit.address ?? ''),
                      10.verticalSpace,
                      VehicleOrderItem(
                        icon: cubit.selectedIcon ?? "",
                        title:
                            cubit.selectedVehcile?.name ?? "No house selected",
                        subtitle: '~ ${cubit.selectedCapacity} Ton',
                        price: cubit.selectedVehcilePrice != null
                            ? "${cubit.selectedVehcilePrice}/hr"
                            : "—",
                      ),
                      VehicleOrderSummry(
                        label: 'Service Charge',
                        value: '\$${serviceCharge.toStringAsFixed(0)}',
                      ),
                      VehiclePromoCode(
                        appliedPromoCode: cubit.appliedPromoCode,
                        onApply: (code) => cubit.checkPromoCode(code),
                        onRemove: () => cubit.removePromoCode(),
                      ),
                      if (state is VehicleCheckOutOrderLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: ColorsManager.orange,
                          ),
                        ),
                      Divider(color: Colors.grey.shade300),
                      VehicleOrderSummry(
                        label: 'Subtotal',
                        value: '\$${subtotal.toStringAsFixed(2)}',
                      ),
                      if (discount > 0)
                        VehicleOrderSummry(
                          label: 'Discount',
                          value: '-\$${discount.toStringAsFixed(2)}',
                        ),
                      Divider(color: Colors.grey.shade300),
                      VehicleOrderSummry(
                        label: 'Total',
                        value: '\$${totalAfterDiscount.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      20.verticalSpace,
                      VehiclePaymentMethod(
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
                    text: state is VehicleCheckOutOrderLoading
                        ? "Processing..."
                        : "Proceed (\$${totalAfterDiscount.toStringAsFixed(0)})",
                    color: state is VehicleCheckOutOrderLoading
                        ? Colors.grey
                        : ColorsManager.orange,
                    onPressed: state is VehicleCheckOutOrderLoading
                        ? null
                        : () {
                            if (cubit.selectedVehcile == null ||
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
                              schedule: cubit.selectedDate!,
                              totalPrice: totalAfterDiscount,
                              serviceId: 3,
                              location: cubit.address!,
                              promoCodes: cubit.appliedPromoCode ?? '',
                              paymentMethodId:
                                  selectedPaymentMethod == 'online' ? 1 : 2,
                              vehicleId: cubit.selectedVehcile!.id,
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
          RouteName.vehicleOrderConfirmation,
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
        SnackBar(content: Text('⚠️ Unexpected error: $e')),
      );
    }
  }
}
