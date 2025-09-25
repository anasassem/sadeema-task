import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/track_entity.dart';

class TrackCard extends StatelessWidget {
  final TrackEntity track;

  const TrackCard({super.key, required this.track});

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
              _getTrackIcon(track.type),
              size: 32.sp,
              color: Colors.red,
            ),
            SizedBox(height: 8.h),
            Text(
              track.name ?? 'غير محدد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (track.description != null) ...[
              SizedBox(height: 4.h),
              Text(
                track.description!,
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

  IconData _getTrackIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'scientific':
        return Icons.science;
      case 'literary':
        return Icons.book;
      case 'administrative':
        return Icons.business_center;
      default:
        return Icons.school;
    }
  }
}