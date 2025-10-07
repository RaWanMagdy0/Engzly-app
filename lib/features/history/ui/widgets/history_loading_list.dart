import 'package:engzly/features/history/ui/widgets/history_card_shimmer.dart';
import 'package:flutter/material.dart';

class HistoryLoadingList extends StatelessWidget {
  const HistoryLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => const HistoryCardShimmer(),
    );
  }
}
