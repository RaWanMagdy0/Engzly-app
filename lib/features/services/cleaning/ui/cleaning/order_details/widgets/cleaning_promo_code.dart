import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleaningPromoCode extends StatefulWidget {
  final String? appliedPromoCode;
  final VoidCallback? onRemove;
  final Function(String)? onApply;

  const CleaningPromoCode({
    super.key,
    this.appliedPromoCode,
    this.onRemove,
    this.onApply,
  });

  @override
  State<CleaningPromoCode> createState() => _CleaningPromoCode();
}

class _CleaningPromoCode extends State<CleaningPromoCode> {
  final TextEditingController _controller = TextEditingController();
  bool showInput = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promo Code',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              if (widget.appliedPromoCode != null)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.appliedPromoCode!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.green,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: widget.onRemove,
                        child: Icon(
                          Icons.close,
                          size: 16.sp,
                          color: ColorsManager.green,
                        ),
                      ),
                    ],
                  ),
                )
              else
                GestureDetector(
                  onTap: () => setState(() => showInput = !showInput),
                  child: Text(
                    showInput ? 'Cancel' : 'Add Code',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.green,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorsManager.green,
                    ),
                  ),
                ),
            ],
          ),
          if (showInput && widget.appliedPromoCode == null) ...[
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter promo code",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1.2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                    ),
                  ),
                ),
                8.horizontalSpace,
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;
                    widget.onApply?.call(_controller.text.trim());
                    setState(() => showInput = false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
