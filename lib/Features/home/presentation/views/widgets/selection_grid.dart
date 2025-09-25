
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionGrid<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Function(T) onItemTap;
  final Widget Function(T) itemBuilder;

  const SelectionGrid({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onItemTap(items[index]),
                child: itemBuilder(items[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) return 3;
    if (screenWidth > 400) return 2;
    return 1;
  }
}
