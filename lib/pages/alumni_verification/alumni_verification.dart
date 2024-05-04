import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/widgets/alumni_verification_widget.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
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
  void initState() {
    super.initState();
    context.read<AlumniVerificationBloc>().add(AlumniVerificationResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/alumniInformation");
      },
      child: BlocBuilder<AlumniVerificationBloc, AlumniVerificationState>(
          builder: (context, state) {
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
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Text(
                            "BẮT ĐẦU",
                            style: TextStyle(
                              fontFamily: AppFonts.Header0,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        )),
                        Center(
                            child: Container(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            "Hãy thiết lập hồ sơ của bạn. Những thông tin này sẽ giúp chúng tôi xét duyệt tài khoản của bạn.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppFonts.Header3,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField("Mã số sinh viên", "studentId", "user",
                            (value) {
                          context
                              .read<AlumniVerificationBloc>()
                              .add(StudentIdEvent(value));
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextFieldStartYear(
                            "Năm nhập học", "startYear", "user", (value) {
                          context
                              .read<AlumniVerificationBloc>()
                              .add(StartYearEvent(value));
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField("Trang cá nhân Facebook/ Linkedin",
                            "socialMediaLink", "user", (value) {
                          context
                              .read<AlumniVerificationBloc>()
                              .add(SocialMediaLinkEvent(value));
                        }),
                      ],
                    ),
                  ),
                  buildLogInAndRegButton("XÁC THỰC", "verify", () {
                    AlumniVerificationController(context: context)
                        .hanldeAlumniVerification();
                  }),
                  buildLogInAndRegButton("BỎ QUA", "skip", () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/applicationPage", (route) => false);
                  }),
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
