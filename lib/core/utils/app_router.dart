import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sadeematask/core/utils/setup_service_locator.dart';

import '../../Features/Splash/presentation/views/splash_view.dart';
import '../../Features/home/presentation/manager/home_cubit/home_cubit.dart';
import '../../Features/home/presentation/views/home_view.dart';
import '../../Features/login/presentation/manager/login_cubit/login_cubit.dart';
import '../../Features/login/presentation/views/login_view.dart';
import '../../Features/subject/presentation/manager/subject_cubit/subject_cubit.dart';
import '../../Features/subject/presentation/views/subject_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kLoginView = '/loginView';
  static const kSubjectView = '/subjectView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),

      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => sl.get<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => BlocProvider(
          create: (context) => sl.get<HomeCubit>(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: kSubjectView,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final termId = args["termId"] as int;
          final childId = args["childId"] as int;
          final pathId = args["pathId"] as int?;
          return BlocProvider(
          create: (context) =>
              sl.get<SubjectsCubit>()..loadSubjects(termId: termId, childId: childId,pathId: pathId,),
          child:  SubjectsView(),
        );
        },
      ),
    ],
  );
}
