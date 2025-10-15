import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehiclePaymentMethod extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodChanged;

  const VehiclePaymentMethod({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PaymentMethodOption(
            icon: Icons.credit_card,
            label: 'Online Payment',
            isSelected: selectedMethod == 'online',
            onTap: () => onMethodChanged('online'),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _PaymentMethodOption(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Cash',
            isSelected: selectedMethod == 'cash',
            onTap: () => onMethodChanged('cash'),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.transparent,
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
            ]),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 36.sp,
                    color: isSelected
                        ? Colors.black
                        : Colors.grey.withValues(alpha: 0.5),
                  ),
                  10.verticalSpace,
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.black : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 5.h,
                right: 12.w,
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
