import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sadeematask/Features/login/presentation/views/widgets/login_footer.dart';
import 'package:sadeematask/Features/login/presentation/views/widgets/login_form.dart';
import 'package:sadeematask/Features/login/presentation/views/widgets/login_header.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_background.dart';
import '../manager/login_cubit/login_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          return CustomBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // يخلي العمود ياخد حجم المحتوى
                  children: [
                    SizedBox(height: 60.h),
                    const LoginHeader(),
                    SizedBox(height: 50.h),
                    LoginForm(isLoading: state is LoginLoading),
                    SizedBox(height: 30.h), // بدل الـ Spacer
                    const LoginFooter(),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      GoRouter.of(context).replace(AppRouter.kHomeView);
    } else if (state is LoginFailure) {
      _showErrorSnackBar(context, state.message);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
