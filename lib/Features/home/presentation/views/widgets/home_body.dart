import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import 'home_imports.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NavigationComplete) {
          GoRouter.of(context).go(
            AppRouter.kSubjectView,
            extra: {
              "termId": state.selectedTerm.id,
              "childId": 9929,
              "pathId":state.selectedClassroom.path?.firstOrNull?.id,
            },
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            NavigationHeader(
              currentStep: _getCurrentStep(state),
              onBack: () => context.read<HomeCubit>().goBack(),
              canGoBack: _canGoBack(state),
            ),

            // Hierarchy Stepper
            HierarchyStepper(
              currentStep: _getCurrentStep(state),
              steps: _getStepLabels(state, context),
            ),

            SizedBox(height: 16.h),

            // Main Content
            Expanded(child: _buildContent(context, state)),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const CustomLoading();
    }

    if (state is HomeError) {
      return CustomError(
        message: state.message,
        onRetry: () => context.read<HomeCubit>().retry(),
      );
    }

    if (state is SystemsLoaded) {
      return SelectionGrid<SystemEntity>(
        title: 'Select Education System',
        items: state.systems,
        onItemTap: (system) => context.read<HomeCubit>().selectSystem(system),
        itemBuilder: (system) => SystemCard(system: system),
      );
    }

    if (state is StagesLoaded) {
      return SelectionGrid<StageEntity>(
        title: 'Select Education Stage',
        items: state.stages,
        onItemTap: (stage) => context.read<HomeCubit>().selectStage(stage),
        itemBuilder: (stage) => StageCard(stage: stage),
      );
    }

    if (state is ClassroomsLoaded) {
      return SelectionGrid<ClassroomEntity>(
        title: 'Select Education Classroom',
        items: state.classrooms,
        onItemTap: (classroom) =>
            context.read<HomeCubit>().selectClassroom(classroom),
        itemBuilder: (classroom) => ClassroomCard(classroom: classroom),
      );
    }

    if (state is TermsLoaded) {
      return SelectionGrid<TermEntity>(
        title: 'Select Education Term',
        items: state.terms,
        onItemTap: (term) => context.read<HomeCubit>().selectTerm(term),
        itemBuilder: (term) => TermCard(term: term),
      );
    }

    if (state is TracksLoaded) {
      return SelectionGrid<TrackEntity>(
        title: 'Select Education Track',
        items: state.tracks,
        onItemTap: (track) => context.read<HomeCubit>().selectTrack(track),
        itemBuilder: (track) => TrackCard(track: track),
      );
    }

    return const Center(child: Text('Welcome to the Education System'));
  }

  int _getCurrentStep(HomeState state) {
    if (state is SystemsLoaded) return 0;
    if (state is StagesLoaded) return 1;
    if (state is ClassroomsLoaded) return 2;
    if (state is TermsLoaded) return 3;
    if (state is TracksLoaded) return 4;
    return 0;
  }

  bool _canGoBack(HomeState state) {
    return _getCurrentStep(state) > 0;
  }

  List<String> _getStepLabels(HomeState state, BuildContext context) {
    List<String> labels = [
      'Educational System',
      'Educational Stage',
      'Classroom',
      'Semester',
    ];

    // Add track step only for secondary education
    if (state is TracksLoaded || _shouldShowTrackStep(state, context)) {
      labels.add('Educational Track');
    }

    return labels;
  }

  bool _shouldShowTrackStep(HomeState state, BuildContext context) {
    // Check if current stage is secondary education
    return context.read<HomeCubit>().isSecondaryEducation();
  }
}
