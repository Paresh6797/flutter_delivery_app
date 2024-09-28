import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';

class LineIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  LineIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
              (index) {
            return Flexible(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 70, // Dynamic size
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: currentIndex == index ? black101010Color : greys9E9E9EColor.withOpacity(0.2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}