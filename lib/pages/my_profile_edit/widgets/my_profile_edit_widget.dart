import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/model/achievement.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/job.dart';
import 'package:hcmus_alumni_mobile/pages/my_profile_edit/bloc/my_profile_edit_blocs.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../bloc/my_profile_edit_events.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          'Chỉnh sửa thông tin cá nhân',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header0,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget myProfileEdit(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          editAvatar(context, (value) {
            context.read<MyProfileEditBloc>().add(AvatarEvent(value));
          }),
          editCover(context, (value) {
            context.read<MyProfileEditBloc>().add(CoverEvent(value));
          }),
          editProfile(context),
          editContact(context),
          editAboutMe(context),
          editAlumni(context),
          editJob(context),
          editEducation(context),
          editAchievement(context),
        ],
      )),
    ],
  );
}

Widget editAvatar(BuildContext context, void Function(File value)? func) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ảnh đại diện',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            GestureDetector(
              onTap: () {
                _showPickOptionsDialog(context, func);
                context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
              },
              child: Text(
                'Chỉnh sửa',
                style: TextStyle(
                  fontFamily: AppFonts.Header0,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: AppColors.primaryElement,
                ),
              ),
            )
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkAvatar != "")
        GestureDetector(
          onTap: () {
            _showPickOptionsDialog(context, func);
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: NetworkImage(
                    BlocProvider.of<MyProfileEditBloc>(context)
                        .state
                        .networkAvatar), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.avatar != null)
        GestureDetector(
          onTap: () {
            _showPickOptionsDialog(context, func);
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: FileImage(
                    BlocProvider.of<MyProfileEditBloc>(context).state.avatar ??
                        File('')), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkAvatar ==
              "" &&
          BlocProvider.of<MyProfileEditBloc>(context).state.avatar == null)
        GestureDetector(
          onTap: () {
            _showPickOptionsDialog(context, func);
            context.read<MyProfileEditBloc>().add(NetworkAvatarEvent(""));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Center(
              child: CircleAvatar(
                radius: 65.w, // Đặt bán kính của CircleAvatar
                backgroundImage: AssetImage(
                    "assets/images/none_avatar.png"), // URL hình ảnh của CircleAvatar
              ),
            ),
          ),
        )
    ],
  );
}

Future<void> _loadPicker(BuildContext context, ImageSource source,
    void Function(File value)? func) async {
  final picked = await ImagePicker().pickImage(source: source);
  if (picked != null) {
    File pickedFile = File(picked.path);
    _cropImage(context, pickedFile,
        func); // Pass the context and picked file to _cropImage
  }
  Navigator.pop(context); // Close the dialog after picking an image
}

Future<void> _cropImage(
    BuildContext context, File picked, void Function(File value)? func) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: picked.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  if (croppedFile != null) {
    // Convert CroppedFile to File if it has a path property
    File croppedFileAsFile = File(croppedFile.path);

    // Dispatch event with the cropped file
    func!(croppedFileAsFile);
  }
}

void _showPickOptionsDialog(
    BuildContext context, void Function(File value)? func) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("Chọn từ thư viện"),
            onTap: () {
              _loadPicker(context, ImageSource.gallery,
                  func); // Pass context to _loadPicker
            },
          ),
          ListTile(
            title: Text("Chụp ảnh"),
            onTap: () {
              _loadPicker(context, ImageSource.camera,
                  func); // Pass context to _loadPicker
            },
          )
        ],
      ),
    ),
  );
}

Widget editCover(BuildContext context, void Function(List<File> value)? func) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ảnh bìa',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final pickedFiles = await ImagePicker().pickMultiImage();
                if (pickedFiles.length > 1) {
                  toastInfo(msg: "Chỉ được chọn tối đa 1 tấm ảnh");
                  return;
                }
                context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
                func!(pickedFiles
                    .map((pickedFile) => File(pickedFile.path))
                    .toList());
              },
              child: Text(
                'Chỉnh sửa',
                style: TextStyle(
                  fontFamily: AppFonts.Header0,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: AppColors.primaryElement,
                ),
              ),
            )
          ],
        ),
      ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkCover != '')
        GestureDetector(
          onTap: () async {
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: "Chỉ được chọn tối đa 1 tấm ảnh");
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(BlocProvider.of<MyProfileEditBloc>(context)
                    .state
                    .networkCover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.cover.length > 0)
        GestureDetector(
          onTap: () async {
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: "Chỉ được chọn tối đa 1 tấm ảnh");
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                    BlocProvider.of<MyProfileEditBloc>(context).state.cover[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
          ),
        ),
      if (BlocProvider.of<MyProfileEditBloc>(context).state.networkCover ==
              '' &&
          BlocProvider.of<MyProfileEditBloc>(context).state.cover.length == 0)
        GestureDetector(
          onTap: () async {
            final pickedFiles = await ImagePicker().pickMultiImage();
            if (pickedFiles.length > 1) {
              toastInfo(msg: "Chỉ được chọn tối đa 1 tấm ảnh");
              return;
            }
            context.read<MyProfileEditBloc>().add(NetworkCoverEvent(""));
            func!(pickedFiles
                .map((pickedFile) => File(pickedFile.path))
                .toList());
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.w),
            ),
            height: 180.h,
            width: double.infinity,
            child: Center(
              child: Text(
                'Thêm ảnh bìa',
                style: TextStyle(
                  fontFamily: AppFonts.Header0,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: AppColors.primaryBackground,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget editProfile(BuildContext context) {
  String faculty = "Chọn khoa";
  switch (BlocProvider.of<MyProfileEditBloc>(context).state.facultyId) {
    case "1":
      faculty = "Công nghệ thông tin";
    case "2":
      faculty = "Vật lý – Vật lý kỹ thuật";
    case "3":
      faculty = "Địa chất";
    case "4":
      faculty = "Toán – Tin học";
    case "5":
      faculty = "Điện tử - Viễn thông";
    case "6":
      faculty = "Khoa học & Công nghệ Vật liệu";
    case "7":
      faculty = "Hóa học";
    case "8":
      faculty = "Sinh học – Công nghệ Sinh học";
    case "9":
      faculty = "Môi trường";
  }

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thông tin cơ bản',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/user.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldFullName(context, 'Họ tên', '', '', (value) {
                  context.read<MyProfileEditBloc>().add(FullNameEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Họ tên',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseFaculty(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h, bottom: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/study.svg",
                width: 25.w,
                height: 25.h,
                color: Colors.black,
              ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: 232.w,
                    child: Text(
                      faculty,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: AppFonts.Header2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      'Khoa',
                      style: TextStyle(
                        fontFamily: AppFonts.Header0,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color: AppColors.primarySecondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseSex(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              BlocProvider.of<MyProfileEditBloc>(context).state.sex == "Nam"
                  ? SvgPicture.asset(
                      "assets/icons/men.svg",
                      width: 25.w,
                      height: 25.h,
                      color: Colors.black,
                    )
                  : SvgPicture.asset(
                      "assets/icons/women.svg",
                      width: 25.w,
                      height: 25.h,
                      color: Colors.black,
                    ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: 232.w,
                    child: Text(
                      BlocProvider.of<MyProfileEditBloc>(context).state.sex,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: AppFonts.Header2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      'Giới tính',
                      style: TextStyle(
                        fontFamily: AppFonts.Header0,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color: AppColors.primarySecondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => chooseBirthday(context),
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/calendar.svg",
                width: 25.w,
                height: 25.h,
                color: Colors.black,
              ),
              Container(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 232.w,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      BlocProvider.of<MyProfileEditBloc>(context).state.dob !=
                              ""
                          ? BlocProvider.of<MyProfileEditBloc>(context)
                              .state
                              .dob
                          : 'Chọn ngày sinh',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: AppFonts.Header2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Text(
                      'Ngày sinh',
                      style: TextStyle(
                        fontFamily: AppFonts.Header0,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color: AppColors.primarySecondaryElementText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/social_network.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldSocialLink(context, 'Mạng xã hội', '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(SocialLinkEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Mạng xã hội',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldStartYear(context, 'Lớp', '', '', (value) {
                  context.read<MyProfileEditBloc>().add(ClasssEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Lớp',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldStartYear(context, 'Năm tốt nghiệp', '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(EndYearEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Năm tốt nghiệp',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget editContact(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thông tin liên hệ',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/email.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    'test@gmail.com',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: AppFonts.Header2,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/phone.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldPhoneNumber(context, 'Số điện thoại', '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(PhoneEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Số điện thoại',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget editAboutMe(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tiểu sử',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      buildTextFieldAboutMe(context, 'Mô tả bản thân', '', '', (value) {
        context.read<MyProfileEditBloc>().add(AboutMeEvent(value));
      })
    ],
  );
}

Widget editAlumni(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thông tin chờ duyệt',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
            Text(
              'Đang chờ duyệt',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldStudentId(context, 'Mã số sinh viên', '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(StudentIdEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Mã số sinh viên',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/study.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextFieldStartYear(context, 'Năm nhập học', '', '',
                    (value) {
                  context.read<MyProfileEditBloc>().add(StartYearEvent(value));
                }),
                Container(
                  width: 100.w,
                  child: Text(
                    'Năm nhập học',
                    style: TextStyle(
                      fontFamily: AppFonts.Header0,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          height: 30.h,
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nộp đơn lại',
                  style: TextStyle(
                    fontFamily: AppFonts.Header2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget editJob(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Công việc',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
          i < BlocProvider.of<MyProfileEditBloc>(context).state.jobs.length;
          i += 1)
        job(context, BlocProvider.of<MyProfileEditBloc>(context).state.jobs[i]),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/myProfileAddJob",
            arguments: {
              "option": 0
            },
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.primaryElement,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  'Thêm nơi làm việc',
                  style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColors.primaryElement,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget job(BuildContext context, Job job) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/work.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    job.companyName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: AppFonts.Header1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    job.position,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${job.startTime} - ${job.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => jobOption(context, job),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget jobOption(BuildContext context, Job job) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/myProfileAddJob",
                    arguments: {
                      "option": 1, "job": job
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Chỉnh sửa công việc',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Xoá công việc',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget editEducation(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Học vấn',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
          i <
              BlocProvider.of<MyProfileEditBloc>(context)
                  .state
                  .educations
                  .length;
          i += 1)
        education(
            context,
            BlocProvider.of<MyProfileEditBloc>(context).state.educations[i]),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/myProfileAddEducation",
            arguments: {
              "option": 0
            },
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.primaryElement,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  'Thêm học vấn',
                  style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColors.primaryElement,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget education(BuildContext context, Education education) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/work.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    education.schoolName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: AppFonts.Header1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    education.degree,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    '${education.startTime} - ${education.endTime}',
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => educationOption(context, education),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget educationOption(BuildContext context, Education education) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/myProfileAddEducation",
                    arguments: {
                      "option": 1,
                      "education": education
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Chỉnh sửa học vấn',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Xoá học vấn',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget editAchievement(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thành tựu nổi bật',
              style: TextStyle(
                fontFamily: AppFonts.Header0,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.secondaryHeader,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 5.h,
      ),
      for (int i = 0;
      i <
          BlocProvider.of<MyProfileEditBloc>(context)
              .state
              .achievements
              .length;
      i += 1)
        achievement(
            context,
            BlocProvider.of<MyProfileEditBloc>(context).state.achievements[i]),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/myProfileAddAchievement",
            arguments: {
              "option": 0
            },
          );
        },
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/add.svg",
                width: 25.w,
                height: 25.h,
                color: AppColors.primaryElement,
              ),
              Container(
                width: 10.w,
              ),
              Container(
                child: Text(
                  'Thêm thành tựu nổi bật',
                  style: TextStyle(
                    fontFamily: AppFonts.Header1,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColors.primaryElement,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget achievement(BuildContext context, Achievement achievement) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/achievement.svg",
              width: 25.w,
              height: 25.h,
              color: Colors.black,
            ),
            Container(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 232.w,
                  child: Text(
                    achievement.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: AppFonts.Header1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Text(
                    achievement.type,
                    style: TextStyle(
                      fontFamily: AppFonts.Header2,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    achievement.time,
                    style: TextStyle(
                      fontFamily: AppFonts.Header3,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => achievementOption(context, achievement),
            );
          },
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 25.w,
            height: 25.h,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget achievementOption(BuildContext context, Achievement achievement) {
  return Container(
    height: 90.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/myProfileAddAchievement",
                    arguments: {
                      "option": 1,
                      "achievement": achievement
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/edit.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Chỉnh sửa thành tựu nổi bật',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/trash.svg",
                        width: 14.w,
                        height: 14.h,
                        color: AppColors.primaryText,
                      ),
                      Container(
                        width: 10.w,
                      ),
                      Text(
                        'Xoá thành tựu nổi bật',
                        style: TextStyle(
                          fontFamily: AppFonts.Header2,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldFullName(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.fullName);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldPhoneNumber(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.phone);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.number,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget chooseFaculty(BuildContext context) {
  return Container(
    height: 450.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'Chọn khoa',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Công nghệ thông tin',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '1',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Vật lý – Vật lý kỹ thuật',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '2',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Địa chất',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '3',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Toán – Tin học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '4',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Điện tử - Viễn thông',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '5',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Khoa học & Công nghệ Vật liệu',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '6',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hóa học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '7',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sinh học – Công nghệ Sinh học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '8',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Môi trường',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: '9',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .facultyId,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(FacultyIdEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget chooseSex(
  BuildContext context,
) {
  return Container(
    height: 150.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'Chọn giới tính',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Nam',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'Nam',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .sex,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(SexEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Nữ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'Nữ',
                        groupValue: BlocProvider.of<MyProfileEditBloc>(context)
                            .state
                            .sex,
                        onChanged: (value) {
                          (context
                              .read<MyProfileEditBloc>()
                              .add(SexEvent(value!)));
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

DateTime convertToDateTime(String dateString) {
  List<String> parts = dateString.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime.utc(year, month, day);
}

String convertDateTimeToString(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  return '$day/$month/$year';
}

Widget chooseBirthday(BuildContext context) {
  late DateTime? _selectedDay;

  if (BlocProvider.of<MyProfileEditBloc>(context).state.dob != "") {
    _selectedDay = convertToDateTime(
        BlocProvider.of<MyProfileEditBloc>(context).state.dob);
  } else {
    _selectedDay = convertToDateTime("01/01/2000");
  }

  return Container(
    height: 210.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'Chọn ngày sinh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header2,
                    ),
                  ),
                ),
              ),
              DatePickerWidget(
                looping: false,
                firstDate: DateTime(1950),
                lastDate: DateTime(2030),
                initialDate: _selectedDay,
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('vi'),
                onChange: (DateTime newDay, _) {
                  context
                      .read<MyProfileEditBloc>()
                      .add(DobEvent(convertDateTimeToString(newDay)));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đặt',
                          style: TextStyle(
                            fontFamily: AppFonts.Header2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldSocialLink(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.socialLink);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldAboutMe(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.aboutMe);

  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w),
    child: TextField(
      onTapOutside: (PointerDownEvent event) {
        func!(_controller.text);
      },
      keyboardType: TextInputType.multiline,
      controller: _controller,
      maxLines: null,
      // Cho phép đa dòng
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        hintStyle: TextStyle(
          color: AppColors.primarySecondaryElementText,
        ),
        counterText: '',
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: AppFonts.Header3,
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
      ),
      autocorrect: false,
    ),
  );
}

Widget buildTextFieldStudentId(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.studentId);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldStartYear(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.startYear);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.number,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldEndYear(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.endYear);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.number,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}

Widget buildTextFieldClass(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  TextEditingController _controller = TextEditingController(
      text: BlocProvider.of<MyProfileEditBloc>(context).state.classs);

  return Container(
      width: 232.w,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 230.w,
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                func!(_controller.text);
              },
              keyboardType: TextInputType.multiline,
              controller: _controller,
              maxLines: 1,
              // Cho phép đa dòng
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppFonts.Header2,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              autocorrect: false,
            ),
          )
        ],
      ));
}
