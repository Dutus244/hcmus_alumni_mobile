import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/widgets/application_page_widget.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_states.dart';

import '../../common/values/colors.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var secondRoute = 0;
    if (args != null) {
      var route = args["route"];
      secondRoute = args["secondRoute"];
      context
          .read<ApplicationPageBloc>()
          .add(TriggerApplicationPageEvent(route));
      // Now you can use the passedValue in your widget
    }

    return BlocBuilder<ApplicationPageBloc, ApplicationPageState>(
        builder: (context, state) {
      return Container(
        color: AppColors.primaryBackground,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index, secondRoute),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h),
                  ),
                  color: AppColors.primarySecondaryElement,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: state.index,
                onTap: (value) {
                  context
                      .read<ApplicationPageBloc>()
                      .add(TriggerApplicationPageEvent(value));
                },
                selectedItemColor: AppColors.primaryElement,
                unselectedItemColor: AppColors.primaryText,
                items: bottomTabs,
              ),
            ),
          ),
        ),
      );
    });
  }
}
