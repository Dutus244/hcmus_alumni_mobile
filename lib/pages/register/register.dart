import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/register/register_controller.dart';

import '../../common/values/colors.dart';
import 'bloc/register_blocs.dart';
import 'bloc/register_events.dart';
import 'bloc/register_states.dart';
import 'widgets/register_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
                          "ĐĂNG KÝ",
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
                        context.read<RegisterBloc>().add(EmailEvent(value));
                      }),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Mật khẩu", "password", "lock", (value) {
                        context.read<RegisterBloc>().add(PasswordEvent(value));
                      }),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField("Nhập lại mật khẩu", "rePassword", "lock",
                          (value) {
                        context
                            .read<RegisterBloc>()
                            .add(RePasswordEvent(value));
                      }),
                    ],
                  ),
                ),
                buildLogInAndRegButton("ĐĂNG KÝ", "register", () {
                  RegisterController(context: context).handleRegister();
                }),
                buildLogInAndRegButton("ĐĂNG NHẬP", "login", () {
                  context.read<RegisterBloc>().add(RegisterResetEvent());
                  Navigator.of(context).pushNamed("/signIn");
                }),
              ],
            ),
          ),
        )),
      );
    });
  }
}
