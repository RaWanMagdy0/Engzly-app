import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_card_map.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_item_card';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/order_summry.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/payment_method_selector.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/widgets/promo_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String selectedPaymentMethod = 'online';
  String? appliedPromoCode = 'A9CCXJP';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
        title: Text(
          "Order Details",
          style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
        ),
        leadingIcon:
            SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
        notificationIcon:
            Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
        onLeadingTap: () {},
        onNotificationTap: () {},
        showNotificationDot: true,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            OrderCardMap(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OrderItemCard(
                    icon: '🏠',
                    title: '3 Bedrooms, 1 Kitchen',
                    subtitle: '+ 1st for baby room',
                    price: '22',
                    backgroundColor: const Color(0xFFFFE0B2),
                  ),
                  OrderItemCard(
                    icon: '🛋️',
                    title: '8 Furniture, 6 Boxes',
                    subtitle: '+ 1st for additional box',
                    price: '30',
                    backgroundColor: const Color(0xFFE1BEE7),
                  ),
                  OrderItemCard(
                    icon: '👷',
                    title: '3 Worker, 1 Electrician',
                    subtitle: '+ 2st for additional person',
                    price: '15',
                    backgroundColor: const Color(0xFFFFF9C4),
                  ),
                  15.verticalSpace,
                  Divider(color: Colors.grey.shade300),
                  5.verticalSpace,
                  OrderSummaryRow(
                    label: 'Vehicle (Mini Truck)',
                    value: '\$20',
                  ),
                  OrderSummaryRow(
                    label: 'Service Charge',
                    value: '\$2',
                  ),
                  PromoCodeInput(
                    appliedPromoCode: appliedPromoCode,
                    onRemove: () {
                      setState(() {
                        appliedPromoCode = null;
                      });
                    },
                  ),
                  if (appliedPromoCode != null)
                    OrderSummaryRow(
                      label: 'Discount',
                      value: '-\$20',
                      isDiscount: true,
                    ),
                  5.verticalSpace,
                  Divider(color: Colors.grey.shade300, thickness: 2),
                  5.verticalSpace,
                  OrderSummaryRow(
                    label: 'Total',
                    value: '\$56',
                    isTotal: true,
                  ),
                  20.verticalSpace,
                  PaymentMethodSelector(
                    selectedMethod: selectedPaymentMethod,
                    onMethodChanged: (method) {
                      setState(() {
                        selectedPaymentMethod = method;
                      });
                    },
                  ),
                  15.verticalSpace,
                  CustomButton(
                    borderRadius: 15.r,
                    height: 50.h,
                    width: 300.w,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.orderConfirmation);
                    },
                    text: "Proccess",
                    color: ColorsManager.orange,
                    textStyle: AppFonts.font14BWhiteWeight700,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
