import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_edit_events.dart';
import 'my_profile_edit_states.dart';

class MyProfileEditBloc extends Bloc<MyProfileEditEvent, MyProfileEditState> {
  MyProfileEditBloc() : super(MyProfileEditState()) {
    on<FullNameEvent>(_fullNameEvent);
    on<PhoneEvent>(_phoneEvent);
    on<FacultyIdEvent>(_facultyIdEvent);
    on<SexEvent>(_sexEvent);
    on<DobEvent>(_dobEvent);
    on<SocialLinkEvent>(_socialLinkEvent);
    on<AboutMeEvent>(_aboutMeEvent);
    on<ClasssEvent>(_classsEvent);
    on<StudentIdEvent>(_studentIdEvent);
    on<StartYearEvent>(_startYearEvent);
    on<EndYearEvent>(_endYearEvent);
    on<NetworkAvatarEvent>(_networkAvatarEvent);
    on<NetworkCoverEvent>(_networkCoverEvent);
    on<AvatarEvent>(_avatarEvent);
    on<CoverEvent>(_coverEvent);
    on<JobsEvent>(_jobsEvent);
    on<EducationsEvent>(_educationsEvent);
    on<AchievementsEvent>(_achievementsEvent);
    on<MyProfileEditResetEvent>(_myProfileEditResetEvent);
  }

  void _fullNameEvent(FullNameEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _phoneEvent(PhoneEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _facultyIdEvent(FacultyIdEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(facultyId: event.facultyId));
  }

  void _sexEvent(SexEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(sex: event.sex));
  }

  void _dobEvent(DobEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(dob: event.dob));
  }

  void _socialLinkEvent(SocialLinkEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(socialLink: event.socialLink));
  }

  void _aboutMeEvent(AboutMeEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(aboutMe: event.aboutMe));
  }

  void _classsEvent(ClasssEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(classs: event.classs));
  }

  void _studentIdEvent(StudentIdEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(studentId: event.studentId));
  }

  void _startYearEvent(StartYearEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(startYear: event.startYear));
  }

  void _endYearEvent(EndYearEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(endYear: event.endYear));
  }

  void _networkAvatarEvent(NetworkAvatarEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(networkAvatar: event.networkAvatar));
  }

  void _networkCoverEvent(NetworkCoverEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(networkCover: event.networkCover));
  }

  void _avatarEvent(AvatarEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(avatar: event.avatar));
  }

  void _coverEvent(CoverEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(cover: event.cover));
  }

  void _jobsEvent(JobsEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(jobs: event.jobs));
  }

  void _educationsEvent(EducationsEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(educations: event.educations));
  }

  void _achievementsEvent(AchievementsEvent event, Emitter<MyProfileEditState> emit) {
    emit(state.copyWith(achievements: event.achievements));
  }

  void _myProfileEditResetEvent(MyProfileEditResetEvent event, Emitter<MyProfileEditState> emit) {
    emit(MyProfileEditState());
  }
}