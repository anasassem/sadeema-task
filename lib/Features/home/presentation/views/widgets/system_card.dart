import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/system_entity.dart';

class SystemCard extends StatelessWidget {
  final SystemEntity system;

  const SystemCard({super.key, required this.system});

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

            SizedBox(height: 8.h),
            Text(
              system.name ?? 'غير محدد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (system.name != null) ...[
              SizedBox(height: 4.h),
              Text(
                system.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getSystemIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'public':
        return Icons.school;
      case 'private':
        return Icons.business;
      case 'international':
        return Icons.public;
      default:
        return Icons.book;
    }
  }
}
