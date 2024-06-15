import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/bloc/advise_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page_list_voters/advise_page_list_voters.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page_list_voters/bloc/advise_page_list_voters_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/alumni_information.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/alumni_verification.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/application_page.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/change_password/bloc/change_password_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/bloc/change_password_forgot_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/change_password_forgot.dart';
import 'package:hcmus_alumni_mobile/pages/edit_post_advise/bloc/edit_post_advise_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/email_verification.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/event_detail.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/bloc/forgot_password_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/forgot_password.dart';
import 'package:hcmus_alumni_mobile/pages/friend_list/bloc/friend_list_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/friend_list/friend_list.dart';
import 'package:hcmus_alumni_mobile/pages/friend_page/bloc/friend_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/friend_page/friend_page.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/bloc/group_create_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/group_create.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/bloc/group_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail/group_detail.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail_list_voters/bloc/group_detail_list_voters_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_detail_list_voters/group_detail_list_voters.dart';
import 'package:hcmus_alumni_mobile/pages/group_edit/bloc/group_edit_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_edit/group_edit.dart';
import 'package:hcmus_alumni_mobile/pages/group_info/bloc/group_info_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_info/group_info.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/bloc/group_management_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_management/group_management.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/bloc/group_member_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_member/group_member.dart';
import 'package:hcmus_alumni_mobile/pages/group_member_approve/bloc/group_member_approve_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_member_approve/group_member_approve.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/bloc/group_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_page/group_page.dart';
import 'package:hcmus_alumni_mobile/pages/group_search/bloc/group_search_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_search/group_search.dart';
import 'package:hcmus_alumni_mobile/pages/hof_detail/bloc/hof_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/bloc/home_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';
import 'package:hcmus_alumni_mobile/pages/list_comment_post_group/bloc/list_comment_post_group_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/list_comment_post_group/list_comment_post_group.dart';
import 'package:hcmus_alumni_mobile/pages/list_picture_post_advise/list_picture_post_advise.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/bloc/list_interact_post_advise_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/list_interact_post_advise.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_group/bloc/list_interact_post_group_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_group/list_interact_post_group.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_achievement/bloc/my_profile_add_achievement_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_achievement/my_profile_add_achievement.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_education/bloc/my_profile_add_education_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_education/my_profile_add_education.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_job/bloc/my_profile_add_job_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_add_job/my_profile_add_job.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/bloc/my_profile_edit_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/my_profile_edit.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_page/bloc/my_profile_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_page/my_profile_page.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/news_detail.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_edit_comment/bloc/news_detail_edit_comment_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_edit_comment/news_detail_edit_comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_children_comment/news_detail_write_children_comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/bloc/news_detail_write_comment_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/news_detail_write_comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/news_event_page.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/bloc/notification_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/notification_page/notification_page.dart';
import 'package:hcmus_alumni_mobile/pages/option_page/option_page.dart';
import 'package:hcmus_alumni_mobile/pages/other_profile_detail/other_profile_detail.dart';
import 'package:hcmus_alumni_mobile/pages/other_profile_page/bloc/other_profile_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/other_profile_page/other_profile_page.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/sign_in.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:hcmus_alumni_mobile/pages/terms_of_service/term_of_service.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/bloc/welcome_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/welcome.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/write_post_advise.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_group/bloc/write_post_group_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_group/write_post_group.dart';

import '../../pages/change_password/change_password.dart';
import '../../pages/edit_post_advise/edit_post_advise.dart';
import '../../pages/edit_post_group/bloc/edit_post_group_blocs.dart';
import '../../pages/edit_post_group/edit_post_group.dart';
import '../../pages/event_detail/bloc/event_detail_blocs.dart';
import '../../pages/event_detail_edit_comment/bloc/event_detail_edit_comment_blocs.dart';
import '../../pages/event_detail_edit_comment/event_detail_edit_comment.dart';
import '../../pages/event_detail_write_children_comment/bloc/event_detail_write_children_comment_blocs.dart';
import '../../pages/event_detail_write_children_comment/event_detail_write_children_comment.dart';
import '../../pages/event_detail_write_comment/bloc/event_detail_write_comment_blocs.dart';
import '../../pages/event_detail_write_comment/event_detail_write_comment.dart';
import '../../pages/hof_detail/hof_detail.dart';
import '../../pages/list_comment_post_advise/bloc/list_comment_post_advise_blocs.dart';
import '../../pages/list_comment_post_advise/list_comment_post_advise.dart';
import '../../pages/list_picture_post_group/list_picture_post_group.dart';
import '../../pages/news_detail_write_children_comment/bloc/news_detail_write_children_comment_blocs.dart';
import '../../pages/register/bloc/register_blocs.dart';
import '../../pages/register/register.dart';
import '../../pages/sign_in/bloc/sign_in_blocs.dart';
import '../../pages/write_post_advise/bloc/write_post_advise_blocs.dart';
import 'names.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(route: AppRoutes.SPLASH, page: const Splash()),
      PageEntity(
          route: AppRoutes.WELCOME,
          page: const Welcome(),
          bloc: BlocProvider(
            create: (_) => WelcomeBloc(),
          )),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(),
          )),
      PageEntity(
          route: AppRoutes.EMAIL_VERIFICATION,
          page: const EmailVerification(),
          bloc: BlocProvider(
            create: (_) => EmailVerificationBloc(),
          )),
      PageEntity(
          route: AppRoutes.ALUMNI_VERIFICATION,
          page: const AlumniVerification(),
          bloc: BlocProvider(
            create: (_) => AlumniVerificationBloc(),
          )),
      PageEntity(
          route: AppRoutes.ALUMNI_INFORMATION,
          page: const AlumniInformation(),
          bloc: BlocProvider(
            create: (_) => AlumniInformationBloc(),
          )),
      PageEntity(
          route: AppRoutes.FORGOT_PASSWORD,
          page: const ForgotPassword(),
          bloc: BlocProvider(
            create: (_) => ForgotPasswordBloc(),
          )),
      PageEntity(
          route: AppRoutes.CHANGE_FORGOT_PASSWORD,
          page: const ChangePasswordForgot(),
          bloc: BlocProvider(
            create: (_) => ChangePasswordForgotBloc(),
          )),
      PageEntity(
          route: AppRoutes.APPLICATION_PAGE,
          page: const ApplicationPage(),
          bloc: BlocProvider(
            create: (_) => ApplicationPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(
            create: (_) => HomePageBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_EVENT_PAGE,
          page: NewsEventPage(
            page: 0,
          ),
          bloc: BlocProvider(
            create: (_) => NewsEventPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.ADVISE_PAGE,
          page: const AdvisePage(),
          bloc: BlocProvider(
            create: (_) => AdvisePageBloc(),
          )),
      PageEntity(
          route: AppRoutes.HOF_PAGE,
          page: const HofPage(),
          bloc: BlocProvider(
            create: (_) => HofPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_PAGE,
          page: GroupPage(
            page: 0,
          ),
          bloc: BlocProvider(
            create: (_) => GroupPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.MY_PROFILE_PAGE,
          page: const MyProfilePage(),
          bloc: BlocProvider(
            create: (_) => MyProfilePageBloc(),
          )),
      PageEntity(
          route: AppRoutes.OTHER_PROFILE_PAGE,
          page: const OtherProfilePage(),
          bloc: BlocProvider(
            create: (_) => OtherProfilePageBloc(),
          )),
      PageEntity(
          route: AppRoutes.NOTIFICATION_PAGE,
          page: const NotificationPage(),
          bloc: BlocProvider(
            create: (_) => NotificationPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.FRIEND_PAGE,
          page: const FriendPage(),
          bloc: BlocProvider(
            create: (_) => FriendPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_DETAIL,
          page: const NewsDetail(),
          bloc: BlocProvider(
            create: (_) => NewsDetailBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_DETAIL_WRITE_COMMENT,
          page: const NewsDetailWriteComment(),
          bloc: BlocProvider(
            create: (_) => NewsDetailWriteCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_DETAIL_EDIT_COMMENT,
          page: const NewsDetailEditComment(),
          bloc: BlocProvider(
            create: (_) => NewsDetailEditCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_DETAIL_WRITE_CHILDREN_COMMENT,
          page: const NewsDetailWriteChildrenComment(),
          bloc: BlocProvider(
            create: (_) => NewsDetailWriteChildrenCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.EVENT_DETAIL,
          page: const EventDetail(),
          bloc: BlocProvider(
            create: (_) => EventDetailBloc(),
          )),
      PageEntity(
          route: AppRoutes.EVENT_DETAIL_WRITE_COMMENT,
          page: const EventDetailWriteComment(),
          bloc: BlocProvider(
            create: (_) => EventDetailWriteCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.EVENT_DETAIL_EDIT_COMMENT,
          page: const EventDetailEditComment(),
          bloc: BlocProvider(
            create: (_) => EventDetailEditCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.EVENT_DETAIL_WRITE_CHILDREN_COMMENT,
          page: const EventDetailWriteChildrenComment(),
          bloc: BlocProvider(
            create: (_) => EventDetailWriteChildrenCommentBloc(),
          )),
      PageEntity(
          route: AppRoutes.HOF_DETAIL,
          page: const HofDetail(),
          bloc: BlocProvider(
            create: (_) => HofDetailBloc(),
          )),
      PageEntity(
          route: AppRoutes.WRITE_POST_ADVISE,
          page: const WritePostAdvise(),
          bloc: BlocProvider(
            create: (_) => WritePostAdviseBloc(),
          )),
      PageEntity(
          route: AppRoutes.EDIT_POST_ADVISE,
          page: const EditPostAdvise(),
          bloc: BlocProvider(
            create: (_) => EditPostAdviseBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_INTERACT_POST_ADVISE,
          page: const ListInteractPostAdvise(),
          bloc: BlocProvider(
            create: (_) => ListInteractPostAdviseBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_COMMENT_POST_ADVISE,
          page: const ListCommentPostAdvise(),
          bloc: BlocProvider(
            create: (_) => ListCommentPostAdviseBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_PICTURE_POST_ADVISE,
          page: const ListPicturePostAdvise()),
      PageEntity(
          route: AppRoutes.ADVISE_PAGE_LIST_VOTERS,
          page: const AdvisePageListVoters(),
          bloc: BlocProvider(
            create: (_) => AdvisePageListVotersBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_SEARCH,
          page: const GroupSearch(),
          bloc: BlocProvider(
            create: (_) => GroupSearchBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_CREATE,
          page: const GroupCreate(),
          bloc: BlocProvider(
            create: (_) => GroupCreateBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_EDIT,
          page: const GroupEdit(),
          bloc: BlocProvider(
            create: (_) => GroupEditBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_DETAIL,
          page: const GroupDetail(),
          bloc: BlocProvider(
            create: (_) => GroupDetailBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_INFO,
          page: const GroupInfo(),
          bloc: BlocProvider(
            create: (_) => GroupInfoBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_MEMBER,
          page: const GroupMember(),
          bloc: BlocProvider(
            create: (_) => GroupMemberBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_MANAGEMENT,
          page: const GroupManagement(),
          bloc: BlocProvider(
            create: (_) => GroupManagementBloc(),
          )),
      PageEntity(
          route: AppRoutes.GROUP_MEMBER_APPROVE,
          page: const GroupMemberApprove(),
          bloc: BlocProvider(
            create: (_) => GroupMemberApproveBloc(),
          )),
      PageEntity(
          route: AppRoutes.WRITE_POST_GROUP,
          page: const WritePostGroup(),
          bloc: BlocProvider(
            create: (_) => WritePostGroupBloc(),
          )),
      PageEntity(
          route: AppRoutes.EDIT_POST_GROUP,
          page: const EditPostGroup(),
          bloc: BlocProvider(
            create: (_) => EditPostGroupBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_INTERACT_POST_GROUP,
          page: const ListInteractPostGroup(),
          bloc: BlocProvider(
            create: (_) => ListInteractPostGroupBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_COMMENT_POST_GROUP,
          page: const ListCommentPostGroup(),
          bloc: BlocProvider(
            create: (_) => ListCommentPostGroupBloc(),
          )),
      PageEntity(
          route: AppRoutes.LIST_PICTURE_POST_GROUP,
          page: const ListPicturePostGroup()),
      PageEntity(
          route: AppRoutes.GROUP_DETAIL_LIST_VOTERS,
          page: const GroupDetailListVoters(),
          bloc: BlocProvider(
            create: (_) => GroupDetailListVotersBloc(),
          )),
      PageEntity(
          route: AppRoutes.MY_PROFILE_EDIT,
          page: const MyProfileEdit(),
          bloc: BlocProvider(
            create: (_) => MyProfileEditBloc(),
          )),
      PageEntity(
          route: AppRoutes.MY_PROFILE_ADD_JOB,
          page: const MyProfileAddJob(),
          bloc: BlocProvider(
            create: (_) => MyProfileAddJobBloc(),
          )),
      PageEntity(
          route: AppRoutes.MY_PROFILE_ADD_EDUCATION,
          page: const MyProfileAddEducation(),
          bloc: BlocProvider(
            create: (_) => MyProfileAddEducationBloc(),
          )),
      PageEntity(
          route: AppRoutes.MY_PROFILE_ADD_ACHIEVEMENT,
          page: const MyProfileAddAchievement(),
          bloc: BlocProvider(
            create: (_) => MyProfileAddAchievementBloc(),
          )),
      PageEntity(
          route: AppRoutes.OTHER_PROFILE_DETAIL,
          page: const OtherProfileDetail()),
      PageEntity(
          route: AppRoutes.OPTION_PAGE,
          page: const OptionPage()),
      PageEntity(
          route: AppRoutes.CHANGE_PASSWORD,
          page: const ChangePassword(),
          bloc: BlocProvider(
            create: (_) => ChangePasswordBloc(),
          )),
      PageEntity(
          route: AppRoutes.TERM_OF_SERVICE,
          page: const TermOfService()),
      PageEntity(
          route: AppRoutes.FRIEND_LIST,
          page: const FriendList(),
          bloc: BlocProvider(
            create: (_) => FriendListBloc(),
          )),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
