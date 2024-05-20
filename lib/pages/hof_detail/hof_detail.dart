import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/bloc/hof_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/bloc/hof_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/widgets/hof_detail_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'hof_detail_controller.dart';

class HofDetail extends StatefulWidget {
  const HofDetail({super.key});

  @override
  State<HofDetail> createState() => _HofDetailState();
}

class _HofDetailState extends State<HofDetail> {
  late String id;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    if (args != null) {
      route = args["route"];
      id = args["id"];
      HofDetailController(context: context).handleGetHof(id);
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        if (route == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/applicationPage", (route) => false,
              arguments: {"route": route, "secondRoute": 0});
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/hofPage",
            (route) => false,
          );
        }
      },
      child:
          BlocBuilder<HofDetailBloc, HofDetailState>(builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context, 'Gương thành công'),
          backgroundColor: AppColors.primaryBackground,
          body: hofDetail(context, route),
        );
      }),
    );
  }
}
