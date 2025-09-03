import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralDataWidget extends StatelessWidget {
  const GeneralDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "G E N E R A L ",
              style: AppFonts.font14BOrangeWeight400.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            children: const [
              ListTile(
                leading: Icon(Icons.payment, color: Colors.black54),
                title: Text(
                  "Payment Methods",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Add your credit & debit cards"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              Divider(),

              ListTile(
                leading: Icon(Icons.location_on, color: Colors.black54),
                title: Text(
                  "Locations",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Add your home & work locations"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              Divider(),

              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.black54),
                title: Text(
                  "Add Social Account",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Add Facebook, Instagram, Twitter etc"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              Divider(),

              ListTile(
                leading: Icon(Icons.share, color: Colors.black54),
                title: Text(
                  "Refer to Friends",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Get \$10 for referring friends"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
