import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/Features/subject/presentation/views/widgets/subject_card.dart';

import '../../../domain/entities/subject_entity.dart';

class SubjectsGrid extends StatelessWidget {
  final List<SubjectEntity> subjects;
  final bool isGrid;
  final Function(SubjectEntity) onSubjectTap;

  const SubjectsGrid({
    super.key,
    required this.subjects,
    required this.onSubjectTap, required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.w),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => SubjectCard(
                isGrid: isGrid,
                subject: subjects[index],
                onTap: () => onSubjectTap(subjects[index]),
              ),
              childCount: subjects.length,
            ),
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
