import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';

class LoadingSearchWidget extends StatelessWidget {
  const LoadingSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.asset(
                  "assets/images/image_placeholder.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
