import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/widgets/group_page_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import 'bloc/group_page_blocs.dart';
import 'bloc/group_page_events.dart';
import 'bloc/group_page_states.dart';
import 'group_page_controller.dart';

class GroupPage extends StatefulWidget {
  final int page; // Biến page cần được khai báo và truyền vào từ bên ngoài
  const GroupPage({Key? key, required this.page}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    pageController = PageController(initialPage: widget.page);
    context.read<GroupPageBloc>().add(PageEvent(widget.page));
    _scrollController.addListener(_onScroll);
    GroupPageController(context: context).handleLoadGroupDiscoverData(0);
    GroupPageController(context: context).handleLoadGroupJoinedData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      if (BlocProvider.of<GroupPageBloc>(context).state.page == 0) {
        GroupPageController(context: context).handleLoadGroupDiscoverData(
            BlocProvider.of<GroupPageBloc>(context).state.indexGroupDiscover);
      } else {
        GroupPageController(context: context).handleLoadGroupJoinedData(
            BlocProvider.of<GroupPageBloc>(context).state.indexGroupJoined);
      }
    }
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
      child:
          BlocBuilder<GroupPageBloc, GroupPageState>(builder: (context, state) {
        return Container(
          child: Scaffold(
            appBar: buildAppBar(context, 'Nhóm'),
            backgroundColor: AppColors.primaryBackground,
            body: BlocProvider.of<GroupPageBloc>(context).state.page == 0
                ? listGroupDiscover(context, _scrollController)
                : listGroupJoined(context, _scrollController),
          ),
        );
      }),
    );
  }
}
