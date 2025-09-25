import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/core/api/end_point.dart';

import '../../../domain/entities/subject_entity.dart';

class SubjectCard extends StatelessWidget {
  final SubjectEntity subject;
  final VoidCallback? onTap;
  final bool isGrid;

  const SubjectCard({
    super.key,
    required this.subject,
    this.onTap,
    this.isGrid = true,
  });

  @override
  Widget build(BuildContext context) {
    return isGrid ? _buildGridCard(context) : _buildListCard(context);
  }

  Widget _buildGridCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with Gradient Overlay
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: _buildSubjectImage(),
                  ),

                  // Gradient Overlay
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            subject.lightColor.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Discount Badge
                  if (subject.hasDiscount)
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: _buildDiscountBadge(),
                    ),

                  // Type Badge
                  Positioned(top: 12.h, left: 12.w, child: _buildTypeBadge()),
                ],
              ),
            ),

            // Content Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Name
                    Text(
                      subject.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Price Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPriceSection(),

                        // Arrow Button
                        Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: subject.lightColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16.sp,
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
      ),
    );
  }

  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Subject Image
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: subject.lightColor.withOpacity(0.1),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: _buildSubjectImage(),
                  ),
                  if (subject.hasDiscount)
                    Positioned(
                      top: -2.h,
                      right: -2.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '${subject.discountPercentage.round()}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(width: 16.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Type
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _buildTypeBadge(isSmall: true),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriceSection(isHorizontal: true),

                      // Arrow Icon
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: subject.lightColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: subject.lightColor,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectImage() {
    return subject.img.isNotEmpty
        ? Image.network(
            EndPoints.imgUrl + subject.img,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
                _buildPlaceholderImage(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: subject.lightColor.withOpacity(0.1),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      subject.lightColor,
                    ),
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          )
        : _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            subject.lightColor.withOpacity(0.3),
            subject.lightColor.withOpacity(0.1),
          ],
        ),
      ),
      child: Icon(_getSubjectIcon(), size: 40.sp, color: subject.lightColor),
    );
  }

  IconData _getSubjectIcon() {
    switch (subject.type.toLowerCase()) {
      case 'math':
      case 'mathematics':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'english':
      case 'language':
        return Icons.language;
      case 'history':
        return Icons.history_edu;
      case 'geography':
        return Icons.public;
      case 'physics':
        return Icons.biotech;
      case 'chemistry':
        return Icons.biotech;
      case 'biology':
        return Icons.nature;
      case 'computer':
        return Icons.computer;
      case 'art':
        return Icons.palette;
      case 'music':
        return Icons.music_note;
      default:
        return Icons.book;
    }
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_offer, color: Colors.white, size: 12.sp),
          SizedBox(width: 4.w),
          Text(
            '${subject.discountPercentage.round()}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge({bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6.w : 8.w,
        vertical: isSmall ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(isSmall ? 8.r : 12.r),
        border: Border.all(color: subject.lightColor.withOpacity(0.3)),
      ),
      child: Text(
        subject.type,
        style: TextStyle(
          color: subject.lightColor,
          fontSize: isSmall ? 9.sp : 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriceSection({bool isHorizontal = false}) {
    return isHorizontal
        ? Row(
            children: [
              Text(
                '${subject.price} ر.س',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: subject.lightColor,
                ),
              ),
              if (subject.hasDiscount) ...[
                SizedBox(width: 8.w),
                Text(
                  '${subject.oldPrice} ر.س',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${subject.price} ر.س',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: subject.lightColor,
                ),
              ),
              if (subject.hasDiscount)
                Text(
                  '${subject.oldPrice} ر.س',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          );
  }
}
