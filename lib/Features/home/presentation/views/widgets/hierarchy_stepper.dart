import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/Features/home/presentation/views/widgets/step_chip.dart';

class HierarchyStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const HierarchyStepper({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Theme.of(context).primaryColor.withOpacity(.2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(steps.length, (index) {
            final isActive = index == currentStep;
            final isCompleted = index < currentStep;

            return Row(
              children: [
                StepChip(
                  label: steps[index],
                  isActive: isActive,
                  isCompleted: isCompleted,
                ),
                if (index < steps.length - 1)
                  Container(
                    width: 20.w,
                    height: 2.h,
                    color: isCompleted
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}