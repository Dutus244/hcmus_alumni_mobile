import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page_controller.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/widgets/hof_page_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/hof_page_blocs.dart';
import 'bloc/hof_page_events.dart';
import 'bloc/hof_page_states.dart';

class HofPage extends StatefulWidget {
  const HofPage({super.key});

  @override
  State<HofPage> createState() => _HofPageState();
}

class _HofPageState extends State<HofPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HofPageBloc, HofPageState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.primaryBackground,
        body: Container(
          child: ListView(scrollDirection: Axis.vertical, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    "Gương thành công",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                )),
                Center(
                    child: buildTextField(
                        'Tìm gương thành công', 'search', 'search', (value) {
                  context.read<HofPageBloc>().add(NameEvent(value));
                }, () {HofPageController(context: context).handleSearch();})),
                Row(
                  children: [
                    buttonClearFilter(() {context.read<HofPageBloc>().add(ClearFilterEvent());}),
                    dropdownButtonFaculty(['Công nghệ thông tin', 'Khoa học & Công nghệ Vật liệu'], context,
                        (value) {
                      context.read<HofPageBloc>().add(FacultyEvent(value));
                    }),
                    dropdownButtonGraduationYear(['2020', '2021'], context,
                        (value) {
                      context
                          .read<HofPageBloc>()
                          .add(GraduationYearEvent(value));
                    })
                  ],
                ),
                Container(
                  height: 10.h,
                ),
                listHof(),
              ],
            ),
          ]),
        ),
      );
    });
  }
}
