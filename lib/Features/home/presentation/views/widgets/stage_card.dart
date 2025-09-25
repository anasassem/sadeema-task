import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/stage_entity.dart';

class StageCard extends StatelessWidget {
  final StageEntity stage;

  const StageCard({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getStageIcon(stage.img),
              size: 32.sp,
              color: Colors.green,
            ),
            SizedBox(height: 8.h),
            Text(
              stage.name ?? 'غير محدد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStageIcon(String? level) {
    switch (level?.toLowerCase()) {
      case 'primary':
        return Icons.child_care;
      case 'middle':
        return Icons.school;
      case 'secondary':
        return Icons.grade;
      default:
        return Icons.menu_book;
    }
  }
}
