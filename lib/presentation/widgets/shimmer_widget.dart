import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Reusable shimmer placeholder for loading states
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerWidget({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 12,
  });

  // Quick factory for a circular shimmer (avatars, icons)
  const ShimmerWidget.circular({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = 100;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// Full weather card shimmer for loading state on home screen
class WeatherShimmerCard extends StatelessWidget {
  const WeatherShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget(height: 20, width: 120),
          const SizedBox(height: 8),
          const ShimmerWidget(height: 80, width: 180),
          const SizedBox(height: 16),
          const ShimmerWidget(height: 16, width: 200),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (_) => const Column(
                children: [
                  ShimmerWidget.circular(size: 40),
                  SizedBox(height: 8),
                  ShimmerWidget(height: 12, width: 50),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const ShimmerWidget(height: 160),
          const SizedBox(height: 16),
          const ShimmerWidget(height: 120),
        ],
      ),
    );
  }
}
