import 'package:engzly/features/history/ui/widgets/card_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/theming/fonts.dart';
import '../../../core/theming/images.dart';

import 'package:engzly/features/history/logic/cubit.dart';
import 'package:engzly/features/history/logic/state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<HistoryCubit>();
    viewModel.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return CustomScaffoldScreen(
          title: Text(
            "History",
            style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
          ),
          leadingIcon: SvgPicture.asset(AppImages.categoryIcon,
              width: 22.w, height: 22.h),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h),
          onLeadingTap: () {},
          onNotificationTap: () {},
          showNotificationDot: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (_) {
                if (state is HistoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HistorySuccess) {
                  final historyList = state.history;

                  if (historyList.isEmpty) {
                    return const Center(child: Text("No history available"));
                  }

                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final item = historyList[index];
                      return ServiceCardMap(
                        status: item.status,
                        title: item.title,
                        date: item.date,
                        address: item.address,
                        location: LatLng(
                          item.lat,
                          item.lng,
                        ),
                      );
                    },
                  );
                } else if (state is HistoryError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
