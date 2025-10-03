import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

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
              "MORE",
              style: AppFonts.font14BOrangeWeight400.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.phone_in_talk, color: Colors.black54),
                title: Text(
                  "Contact Us",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("For More Information"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.contactUs,
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.login_outlined, color: Colors.black54),
                title: Text(
                  "Locations",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ),
              10.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
