import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPriceListWidget extends StatelessWidget {
  const ShimmerPriceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _ShimmerChip(),
        ),
        const Expanded(child: _ShimmerCardList()),
      ],
    );
  }
}

class _ShimmerChip extends StatelessWidget {
  const _ShimmerChip();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Center(
        child: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _ShimmerCardList extends StatelessWidget {
  const _ShimmerCardList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const _ShimmerCard();
      },
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
          ),
          title: Container(
            height: 16,
            width: 100,
            margin: const EdgeInsets.only(bottom: 8),
          ),
          subtitle: SizedBox(height: 14, width: 60),
        ),
      ),
    );
  }
}
