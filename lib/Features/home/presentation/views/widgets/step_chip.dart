import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isCompleted;

  const StepChip({
    super.key,
    required this.label,
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Widget? icon;

    if (isCompleted) {
      backgroundColor = Theme.of(context).primaryColor;
      textColor = Colors.white;
      icon = Icon(Icons.check, size: 14.sp, color: Colors.white);
    } else if (isActive) {
      backgroundColor = Theme.of(context).primaryColor.withOpacity(.5);
      textColor = Theme.of(context).primaryColor.withOpacity(.7);
    } else {
      backgroundColor = Colors.grey.shade200;
      textColor = Colors.grey.shade600;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, SizedBox(width: 4.w)],
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
