import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectsAppBar extends StatefulWidget implements PreferredSizeWidget {
   SubjectsAppBar({Key? key}) : super(key: key);

  @override
  State<SubjectsAppBar> createState() => _SubjectsAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _SubjectsAppBarState extends State<SubjectsAppBar> {
  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 8.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              'المواد الدراسية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8.h);
}
