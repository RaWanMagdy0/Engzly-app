import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_item_list.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_map.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_order_summry.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_payment_method.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/cleaning_promo_code.dart';
import 'package:engzly/features/payment/service_payment_handler.dart';
import 'package:engzly/features/services/cleaning/ui/ui/order_details/widgets/service_charge_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleaningOrderContent extends StatelessWidget {
  final ScrollController scrollController;
  final CleaningCubit cubit;
  final CleaningStates state;
  final double? distanceInMeters;
  final String selectedPaymentMethod;
  final Function(double) onDistanceCalculated;
  final Function(String) onPaymentMethodChanged;

  const CleaningOrderContent({
    super.key,
    required this.scrollController,
    required this.cubit,
    required this.state,
    required this.distanceInMeters,
    required this.selectedPaymentMethod,
    required this.onDistanceCalculated,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final prices = _calculatePrices();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CleaningOrderMap(
                  location: cubit.address ?? '',
                  onDistanceCalculated: onDistanceCalculated,
                ),
                10.verticalSpace,
                CleaningOrderItemsList(
                  cubit: cubit,
                  personCost: prices.personCost,
                  serviceCharge: prices.serviceCharge,
                ),
                CleaningPromoCode(
                  appliedPromoCode: cubit.appliedPromoCode,
                  onApply: (code) => cubit.checkPromoCode(code),
                  onRemove: () => cubit.removePromoCode(),
                ),
                Divider(color: Colors.grey.shade300),
                CleaningOrderSummry(
                  label: 'Subtotal',
                  value: '\$${prices.subtotal.toStringAsFixed(2)}',
                ),
                if (prices.discount > 0)
                  CleaningOrderSummry(
                    label: 'Discount',
                    value: '-\$${prices.discount.toStringAsFixed(2)}',
                    isDiscount: true,
                  ),
                Divider(color: Colors.grey.shade300),
                CleaningOrderSummry(
                  label: 'Total',
                  value: '\$${prices.totalAfterDiscount.toStringAsFixed(2)}',
                  isTotal: true,
                ),
                20.verticalSpace,
                CleaningPaymentMethod(
                  selectedMethod: selectedPaymentMethod,
                  onMethodChanged: onPaymentMethodChanged,
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
              text: state is CleaningCheckOutOrderLoading
                  ? "Processing..."
                  : "Proceed (\$${prices.totalAfterDiscount.toStringAsFixed(0)})",
              color: state is CleaningCheckOutOrderLoading
                  ? Colors.grey
                  : ColorsManager.green,
              onPressed: state is CleaningCheckOutOrderLoading
                  ? null
                  : () => _handleProceed(context, prices.totalAfterDiscount),
            ),
          ),
        ),
      ],
    );
  }

  _PriceBreakdown _calculatePrices() {
    double basePrice = cubit.selectedHouseSizePrice?.toDouble() ?? 0;
    double personCost = cubit.requiredPersons * 5;
    double hourlyRate = basePrice + personCost;
    double totalHourCost = cubit.workingHours * hourlyRate;

    double serviceCharge = distanceInMeters != null
        ? ServiceChargeCalculator.calculateFromMeters(distanceInMeters!)
        : 50.0;

    double subtotal = totalHourCost + serviceCharge;

    double discount = 0;
    if ((cubit.discountPercentage ?? 0) > 0) {
      discount = subtotal * (cubit.discountPercentage! / 100);
    }

    double totalAfterDiscount = subtotal - discount;

    return _PriceBreakdown(
      personCost: personCost,
      serviceCharge: serviceCharge,
      subtotal: subtotal,
      discount: discount,
      totalAfterDiscount: totalAfterDiscount,
    );
  }

  Future<void> _handleProceed(BuildContext context, double total) async {
    if (cubit.selectedHouseSize == null ||
        cubit.address == null ||
        cubit.requiredPersons == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all required fields"),
        ),
      );
      return;
    }

    final paymentData = await PaymentService.selectPaymentMethod(
      context: context,
      selectedPaymentMethod: selectedPaymentMethod,
    );

    if (paymentData == null) return;

    cubit.selectedPaymentType = paymentData.onlinePaymentType;

    int paymentId = PaymentHandler.getPaymentMethodId(
      paymentMethod: selectedPaymentMethod,
      onlinePaymentType: paymentData.onlinePaymentType,
    );

    cubit.checkOut(
      schedule: cubit.selectedDate!,
      totalPrice: total,
      serviceId: cubit.selectedServiceId ?? 1,
      location: cubit.address!,
      promoCodes: cubit.appliedPromoCode ?? '',
      paymentMethodId: paymentId,
      houseSizeId: cubit.selectedHouseSize!.id,
    );
  }
}

class _PriceBreakdown {
  final double personCost;
  final double serviceCharge;
  final double subtotal;
  final double discount;
  final double totalAfterDiscount;

  _PriceBreakdown({
    required this.personCost,
    required this.serviceCharge,
    required this.subtotal,
    required this.discount,
    required this.totalAfterDiscount,
  });
}