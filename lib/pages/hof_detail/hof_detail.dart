import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/bloc/hof_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/bloc/hof_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/widgets/hof_detail_widget.dart';

import '../../common/values/colors.dart';
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
    if (args != null) {
      id = args["id"];
      HofDetailController(context: context).handleGetHof(id);
    }

    return BlocBuilder<HofDetailBloc, HofDetailState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: hofDetail(context),
      );
    });
  }
}
