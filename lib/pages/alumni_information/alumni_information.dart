import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/alumni_information_controller.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_events.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_states.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/widgets/alumni_information_widget.dart';

import '../../common/values/colors.dart';

class AlumniInformation extends StatefulWidget {
  const AlumniInformation({super.key});

  @override
  State<AlumniInformation> createState() => _AlumniInformationState();
}

class _AlumniInformationState extends State<AlumniInformation> {
  @override
  void initState() {
    super.initState();
    context.read<AlumniInformationBloc>().add(AlumniInformationResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Thoát ứng dụng'),
            content: Text('Bạn có muốn thoát ứng dụng?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Huỷ'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Thoát'),
              ),
            ],
          ),
        );
        if (shouldExit) {
          SystemNavigator.pop();
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<AlumniInformationBloc, AlumniInformationState>(
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
                              fontFamily: 'Roboto',
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
                              fontFamily: 'Roboto',
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 5.h,
                        ),
                        chooseAvatar(context, (value) {
                          context
                              .read<AlumniInformationBloc>()
                              .add(AvatarEvent(value));
                        }),
                        SizedBox(
                          height: 25.h,
                        ),
                        buildTextField("Họ và tên *", "fullName", "user",
                            (value) {
                          context
                              .read<AlumniInformationBloc>()
                              .add(FullNameEvent(value));
                        }),
                      ],
                    ),
                  ),
                  buildLogInAndRegButton("TIẾP TỤC", "verify", () {
                    AlumniInformationController(context: context)
                        .hanldeAlumniInformation();
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
