import 'package:engzly/core/helper/functions/validators/validators.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/shared_widgets/custom_text_form_field.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/services/car_washer/ui/first_screen/widgets/add_new_vehicle_screen/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({super.key});

  @override
  State<AddNewVehicleScreen> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text("Add New Vehicle", style: AppFonts.font20BlackWeight700),
      onLeadingTap: () => Navigator.pop(context),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.black,
      ),
      leadingIcon: SvgPicture.asset(
        AppImages.backArrow,
        width: 30.w,
        height: 30.h,
        color: ColorsManager.black,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImagePickerWidget(),
              SizedBox(height: 20),

              CustomTextFormField(
                focusedBorderColor: ColorsManager.green,
                hintText: "Vehicle Type ( Kia, Hyundai)",
                labelText: "Vehicle Type",
                controller: typeController,
                keyBordType: TextInputType.text,
                validator: (value) => Validators.validateNotEmpty(
                    title: "Password", value: value),
              ),
              SizedBox(height: 12),
              CustomTextFormField(
                focusedBorderColor: ColorsManager.green,
                hintText: "Car Number",
                labelText: "Car Number",
                controller: numberController,
                keyBordType: TextInputType.text,
                validator: (value) => Validators.validateNotEmpty(
                    title: "Password", value: value),
              ),
              //  customTextField("Vehicle Type ( Kia, Hyundai)", typeController),
              //customTextField("Plate Number", numberController),
              //    customTextField("Color (optional)", colorController),

              SizedBox(height: 20),

              // ---------- SAVE BUTTON ----------
              CustomButton(
                text: "Save Vehicle",
                color: ColorsManager.green,
                textStyle: AppFonts.font14BWhiteWeight700,
                height: 50.h,
                borderRadius: 20.r,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: ColorsManager.green, width: 2),
        ),
      ),
    );
  }
}
