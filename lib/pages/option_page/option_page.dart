import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/values/colors.dart';
import 'bloc/option_page_blocs.dart';
import 'bloc/option_page_states.dart';
import 'bloc/option_page_events.dart';
import 'widgets/option_page_widget.dart';
import '../../../global.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    context
        .read<OptionPageBloc>()
        .add(LocaleEvent(Global.storageService.getDeviceLanguage()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionPageBloc, OptionPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body:  optionPage(context),
          );
        });
  }
}
