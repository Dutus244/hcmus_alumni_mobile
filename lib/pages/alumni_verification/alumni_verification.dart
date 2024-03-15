import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/widgets/alumni_verification_widget.dart';

import '../../common/values/colors.dart';
import 'alumni_verification_controller.dart';
import 'bloc/alumni_verification_blocs.dart';
import 'bloc/alumni_verification_events.dart';
import 'bloc/alumni_verification_states.dart';

class AlumniVerification extends StatefulWidget {
  const AlumniVerification({super.key});

  @override
  State<AlumniVerification> createState() => _AlumniVerificationState();
}

class _AlumniVerificationState extends State<AlumniVerification> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlumniVerificationBloc, AlumniVerificationState>(builder: (context, state) {
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
                                  "XÁC THỰC CỰU SINH VIÊN",
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
                          buildTextField("Họ và tên", "fullName", "user", (value) {
                            context.read<AlumniVerificationBloc>().add(FullNameEvent(value));
                          }),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextField("MSSV", "studentId", "user", (value) {
                            context.read<AlumniVerificationBloc>().add(StudentIdEvent(value));
                          }),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextFieldStartYear("Năm nhập học", "startYear", "user",
                                  (value) {
                                context
                                    .read<AlumniVerificationBloc>()
                                    .add(StartYearEvent(value));
                              }),
                        ],
                      ),
                    ),
                    buildLogInAndRegButton("XÁC THỰC", "verify", () {
                      AlumniVerificationController(context: context)
                          .hanldeAlumniVerification();
                    }),
                    buildLogInAndRegButton("BỎ QUA", "skip", () {
                      context.read<AlumniVerificationBloc>().add(AlumniVerificationResetEvent());
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
                    }),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
