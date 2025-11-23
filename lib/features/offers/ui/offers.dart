import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/features/home/ui/widgets/home_shimmer_widget.dart';
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/offers/ui/logic/offers_cubit.dart';
import 'package:engzly/features/offers/ui/logic/offers_states.dart';
import 'package:engzly/features/home/ui/widgets/offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theming/images.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late OffersCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<OffersCubit>();
    viewModel.getOffers();
  }

  Widget buildOfferShimmer() {
    return SizedBox(
      height: 160.h,
      child: Row(
        children: List.generate(
          3,
          (_) => Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: HomeShimmerWidgets.shimmerWrapper(
              Container(
                width: 250.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOfferGroupShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeShimmerWidgets.shimmerWrapper(
          Container(
            width: 150.w,
            height: 20.h,
            color: Colors.grey.shade300,
          ),
        ),
        10.verticalSpace,
        buildOfferShimmer(),
        25.verticalSpace,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: const Text("Offers"),
      leadingIcon: SvgPicture.asset(
        AppImages.categoryIcon,
        width: 22.w,
        height: 22.h,
        color: ColorsManager.black,
      ),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            if (state is OffersLoading) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    3,
                    (_) => buildOfferGroupShimmer(),
                  ),
                ),
              );
            } else if (state is OffersError) {
              return Center(child: Text(state.message));
            } else if (state is OffersSuccess) {
              final offers = state.offers;

              if (offers.isEmpty) {
                return const Center(child: Text("No offers available"));
              }

              return ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final OffersResponseModel offerGroup = offers[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offerGroup.type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        10.verticalSpace,
                        SizedBox(
                          height: 150.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: offerGroup.offers.length,
                            itemBuilder: (context, i) {
                              final offer = offerGroup.offers[i];
                              return Container(
                                margin: EdgeInsets.only(right: 12.w),
                                child: OfferCard(
                                  offer: offer,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
