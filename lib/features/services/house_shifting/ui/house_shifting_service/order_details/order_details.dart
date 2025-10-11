import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_states.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_card_map.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_item_card.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_summry.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/payment_method_selector.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/promo_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
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
    // ignore: deprecated_member_use
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
    return CustomScaffoldScreen(
      title: Text(
        "Order Details",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      showNotificationDot: true,
      child: BlocConsumer<HouseShiftingBookingCubit, HouseShiftingBookingState>(
        listener: (context, state) async {
          if (state is CheckPromoCodeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

          if (state is CheckOutOrderSuccess) {
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
                  RouteName.orderConfirmation,
                  (route) => false,
                );
              }
            }
          }

          if (state is CheckOutOrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<HouseShiftingBookingCubit>();
          final double subtotal = cubit.totalPrice;
          final double discount = (cubit.discountPercentage ?? 0) > 0
              ? subtotal * (cubit.discountPercentage! / 100)
              : 0;
          final double totalAfterDiscount = cubit.totalPriceAfterDiscount;

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OrderCardMap(location: cubit.address ?? ''),
                      10.verticalSpace,
                      OrderItemCard(
                        icon: '🏠',
                        title: cubit.selectedHouseSize?.name ?? "House Size",
                        subtitle: '+ 1st for baby room',
                        price: cubit.selectedHouseSizePrice != null
                            ? cubit.selectedHouseSizePrice!.toStringAsFixed(0)
                            : '\$0',
                        backgroundColor: const Color(0xFFFFE0B2),
                      ),
                      OrderItemCard(
                        icon: '🛋️',
                        title: cubit.totalItemsCount > 0 || cubit.boxesCount > 0
                            ? 'Furniture x${cubit.totalItemsCount}, Boxes x${cubit.boxesCount}'
                            : "Furniture & Boxes",
                        subtitle: '+ \$5 for additional box',
                        price: cubit.totalFurniturePrice.toStringAsFixed(2),
                        backgroundColor: const Color(0xFFE1BEE7),
                      ),
                      Divider(color: Colors.grey.shade300),
                      5.verticalSpace,
                      OrderSummaryRow(
                        label: cubit.selectedVehicleName != null
                            ? 'Vehicle : (${cubit.selectedVehicleName})'
                            : 'Vehicle',
                        value: cubit.selectedVehiclePrice != null
                            ? '\$${cubit.selectedVehiclePrice!.toStringAsFixed(2)}'
                            : '\$0',
                      ),
                      OrderSummaryRow(
                        label: 'Service Charge',
                        value: '\$50.00',
                      ),
                      PromoCodeInput(
                        appliedPromoCode: cubit.appliedPromoCode,
                        onApply: (code) => cubit.checkPromoCode(code),
                        onRemove: () => cubit.removePromoCode(),
                      ),
                      if (state is CheckPromoCodeLoading)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: ColorsManager.orange,
                          ),
                        ),
                      10.verticalSpace,
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      5.verticalSpace,
                      OrderSummaryRow(
                        label: 'Subtotal',
                        value: '\$${subtotal.toStringAsFixed(2)}',
                      ),
                      if (discount > 0)
                        OrderSummaryRow(
                          label: 'Discount',
                          value: '-\$${discount.toStringAsFixed(2)}',
                        ),
                      Divider(color: Colors.grey.shade300),
                      OrderSummaryRow(
                        label: 'Total',
                        value: '\$${totalAfterDiscount.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      20.verticalSpace,
                      PaymentMethodSelector(
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
                    borderRadius: 15.r,
                    height: 50.h,
                    onPressed: state is CheckOutOrderLoading
                        ? null
                        : () {
                            if (cubit.selectedHouseSize == null ||
                                cubit.selectedVehicleId == null ||
                                cubit.address == null ||
                                cubit.selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please complete all required fields')),
                              );
                              return;
                            }
                            cubit.checkOut(
                              schedule: cubit.selectedDate ?? DateTime.now(),
                              serviceId: cubit.selectedHouseSize?.id ?? 1,
                              location: cubit.address ?? '',
                              promoCodes: cubit.appliedPromoCode ?? '',
                              paymentMethodId:
                                  selectedPaymentMethod == 'online' ? 1 : 2,
                              houseSizeId: cubit.selectedHouseSize?.id ?? 1,
                              vehiclesId: cubit.selectedVehicleId ?? 1,
                              packedBoxes: cubit.boxesCount,
                              furnitures: cubit.selectedFurnitureCounts
                                  .map((k, v) => MapEntry(k.id.toString(), v)),
                              totalPrice: totalAfterDiscount,
                            );
                          },
                    text: state is CheckOutOrderLoading
                        ? "Processing..."
                        : "Proceed",
                    color: state is CheckOutOrderLoading
                        ? Colors.grey
                        : ColorsManager.orange,
                    textStyle: AppFonts.font14BWhiteWeight700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
          RouteName.orderConfirmation,
          (route) => false,
        );
      }
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Payment failed: ${e.error.localizedMessage}'),
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
