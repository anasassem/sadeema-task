import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationHeader extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;
  final bool canGoBack;

  const NavigationHeader({
    super.key,
    required this.currentStep,
    required this.onBack,
    required this.canGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          if (canGoBack)
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.sp,
            )
          else
            SizedBox(width: 48.w),

          Expanded(
            child: Text(
              'Step ${currentStep + 1}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),

          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}
