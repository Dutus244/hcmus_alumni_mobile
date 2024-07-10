import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/values/colors.dart';
import 'bloc/other_profile_detail_blocs.dart';
import 'bloc/other_profile_detail_states.dart';
import 'other_profile_detail_controller.dart';
import 'widgets/other_profile_detail_widget.dart';

class OtherProfileDetail extends StatefulWidget {
  const OtherProfileDetail({super.key});

  @override
  State<OtherProfileDetail> createState() => _OtherProfileDetailState();
}

class _OtherProfileDetailState extends State<OtherProfileDetail> {
  String id = "";
  
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      OtherProfileDetailController(context: context).handleGetProfile(id);
      OtherProfileDetailController(context: context).handleGetJob(id);
      OtherProfileDetailController(context: context).handleGetEducation(id);
      OtherProfileDetailController(context: context).handleGetAchievement(id);
    }

    return BlocBuilder<OtherProfileDetailBloc, OtherProfileDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body:  otherProfileDetail(context),
          );
        });
  }
}
