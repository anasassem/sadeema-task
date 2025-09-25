import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeematask/Features/login/presentation/views/widgets/social_login_buttom.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300])),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'or',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300])),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              icon: Icons.g_mobiledata,
              onTap: () {
                // Handle Google login
              },
            ),
            SizedBox(width: 20.w),
            SocialLoginButton(
              icon: Icons.facebook,
              onTap: () {
                // Handle Facebook login
              },
            ),
          ],
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont have an account?',
              style: TextStyle(color: Colors.grey[600], fontSize: 11.sp),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                // Navigate to register
              },
              child: Text(
                'Create an account',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
