import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/Features/subject/presentation/views/widgets/subjects_grid.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../home/presentation/views/widgets/custom_error.dart';
import '../../../home/presentation/views/widgets/custom_loading.dart';
import '../../domain/entities/subject_entity.dart';
import '../manager/subject_cubit/subject_cubit.dart';

class SubjectsView extends StatefulWidget {
   SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
   bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
            ),

            // Main Content
            Expanded(
              child: BlocConsumer<SubjectsCubit, SubjectsState>(
                listener: (context, state) {
                  // فقط حالات الـ error نعرض سناك
                  if (state is SubjectsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  // Loading state
                  if (state is SubjectsLoading) {
                    return const CustomLoading();
                  }


                  if (state is SubjectsError) {
                    return CustomError(
                      message: state.message,
                      onRetry: () => context.read<SubjectsCubit>().loadSubjects(
                        pathId: 0,
                        childId: 0,
                        termId: 0,
                      ),
                    );
                  }

                  if (state is SubjectsLoaded) {
                    final List<SubjectEntity> subjects = state.subjects;

                    if (subjects.isEmpty) {
                      return const EmptyState(
                        title: 'you dont have any Subject',
                        message: 'no Subject yet',
                        icon: Icons.book_outlined,
                      );
                    }

                    return SubjectsGrid(
                      subjects: subjects,
                      isGrid: isGridView,
                      onSubjectTap: (subject) {

                      },
                    );
                  }

                  // أي حالة أخرى (initial مثلاً)
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
