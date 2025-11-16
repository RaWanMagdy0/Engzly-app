import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/features/home/ui/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceRow extends StatelessWidget {
  const ServiceRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ServiceCard(
            icon: Icons.home,
            backgroundColor: ColorsManager.babyBink,
            iconBackgroundColor: ColorsManager.ovalBinkColor,
            iconColor: Colors.red,
            title: "House\nShifting",
            onTab: () {
              Navigator.pushNamed(context, RouteName.houseShifting);
            },
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: ServiceCard(
            icon: Icons.apartment,
            backgroundColor: ColorsManager.babyOrange,
            iconBackgroundColor: ColorsManager.ovalOrangeColor,
            iconColor: Colors.orange,
            title: "Office\nShifting",
            onTab: () {
              AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: "This service is coming soon");
            },
          ),
        ),
        12.horizontalSpace,
        
        Expanded(
          child: ServiceCard(
            icon: Icons.business,
            backgroundColor: ColorsManager.babyBlue,
            iconBackgroundColor: ColorsManager.ovalBlueColor,
            iconColor: Colors.blue,
            onTab: () {
              AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: "This service is coming soon");
            },
            title: "Commercial\nShifting",
          ),
        ),
      ],
    );
  }
}
