/**************
class PinCodeFile extends StatelessWidget {
  final Function(String) onCodeCompleted;

  const PinCodeFile({super.key, required this.onCodeCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: (context),
      length: 6,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60.h,
        fieldWidth: 47.w,
        activeColor: AppColors.kLighterGrey,
        inactiveColor: AppColors.kLighterGrey,
        selectedFillColor: AppColors.kWhite,
        activeFillColor: AppColors.kWhite,
        selectedColor: AppColors.kPink,
      ),
      animationDuration: const Duration(milliseconds: 200),
      keyboardType: TextInputType.phone,
      enabled: true,
      onCompleted: (value) {
        if (value.length == 6) {
          onCodeCompleted(value);
        }
      },
    );
  }
}
*/
