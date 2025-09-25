import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/term_entity.dart';

class TermCard extends StatelessWidget {
  final TermEntity term;

  const TermCard({super.key, required this.term});

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
              _getTermIcon(term.termNumber),
              size: 32.sp,
              color: Colors.orange,
            ),
            SizedBox(height: 8.h),
            Text(
              term.name ?? 'غير محدد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (term.startDate != null && term.endDate != null) ...[
              SizedBox(height: 4.h),
              Text(
                '${_formatDate(term.startDate!)} - ${_formatDate(term.endDate!)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getTermIcon(int? termNumber) {
    switch (termNumber) {
      case 1:
        return Icons.looks_one;
      case 2:
        return Icons.looks_two;
      case 3:
        return Icons.looks_3;
      default:
        return Icons.calendar_today;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
