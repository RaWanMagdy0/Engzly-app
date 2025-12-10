import 'dart:io';
import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<ImagePickerWidget> {
  File? vehicleImage;
  final ImagePicker picker = ImagePicker();

  Future pickImage(bool fromCamera) async {
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        vehicleImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.photo, color: ColorsManager.green),
                    title: Text("Choose from Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt, color: ColorsManager.green),
                    title: Text("Take a Photo"),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(true);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: vehicleImage == null
                ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: SizedBox(
                      width: double.infinity,
                                  height: 300,

                      child: Image.file(
                        vehicleImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )));
  }
}
