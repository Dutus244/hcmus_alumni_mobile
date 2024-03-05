import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/sign_in_controller.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/widgets/sign_in_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/sign_in_blocs.dart';
import 'bloc/sign_in_events.dart';
import 'bloc/sign_in_states.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Container(
        color: AppColors.primaryBackground,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 230.w,
                          height: 230.w,
                          child: Image.asset(
                            "assets/images/logos/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                          child: Container(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                      )),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Email", "email", "email", (value) {
                        context.read<SignInBloc>().add(EmailEvent(value));
                      }),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Mật khẩu", "password", "lock", (value) {
                        context.read<SignInBloc>().add(PasswordEvent(value));
                      }),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                  height: 24.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rememberLogin(context, (value) {
                        context
                            .read<SignInBloc>()
                            .add(RememberLoginEvent(value));
                      }),
                      forgotPassword(),
                    ],
                  ),
                ),
                buildLogInAndRegButton("ĐĂNG NHẬP", "login", () {
                  SignInController(context: context).handleSignIn();
                }),
                buildLogInAndRegButton("ĐĂNG KÝ", "register", () {
                  Navigator.of(context).pushNamed("register");
                }),
              ],
            ),
          ),
        )),
      );
    });
  }
}
