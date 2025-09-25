import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;

  const LoginForm({super.key, required this.isLoading});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _phoneController,
            labelText: 'Phone Number',
            hintText: 'Enter Phone Number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: _validatePhone,
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Enter Password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            validator: _validatePassword,
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                // Handle forgot password
              },
              child: Text(
                'forgot password?',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          CustomElevatedButton(
            onPressed: widget.isLoading ? null : _handleLogin,
            isLoading: widget.isLoading,
            text: 'Login',
          ),
        ],
      ),
    );
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter phone number';
    }
    if (value.length < 10) {
      return 'phone number must be at least 10 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter password';
    }
    if (value.length < 6) {
      return 'password must be at least 6 characters';
    }
    return null;
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "unknown_ios_id";
    }
    return "unknown_device";
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final deviceId = await getDeviceId();

      context.read<LoginCubit>().login(
        mobileId: deviceId,
        mobileType: Platform.isAndroid ? "apk" : "ios",
        notiId: "notification_token_123",
        password:_passwordController.text.trim(),
        phoneOrEmail: _phoneController.text.trim(),
        type: "child",
      );
    }
  }
}
