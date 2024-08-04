import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_events.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../common/values/colors.dart';
import '../alumni_information_controller.dart';

Widget buildTextField(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset(iconName),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
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
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              maxLength: textType == 'studentId' ? 8 : 100,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
        left: 25.w, right: 25.w, top: buttonType == "verify" ? 20.h : 20.h),
    child: ElevatedButton(
      onPressed: () {
        AlumniInformationController(context: context).handleAlumniInformation();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            buttonType == "verify" ? AppColors.background : AppColors.element,
        backgroundColor:
            buttonType == "verify" ? AppColors.element : AppColors.elementLight,
        minimumSize: Size(325.w, 50.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
          side: buttonType == "verify"
              ? BorderSide(color: Colors.transparent)
              : BorderSide(color: AppColors.primaryFourthElementText),
        ),
      ),
      child: Text(
        buttonName,
        style: AppTextStyle.medium(context).wSemiBold().withColor(
            buttonType == "verify" ? AppColors.background : AppColors.element),
      ),
    ),
  );
}

Widget chooseAvatar(BuildContext context, void Function(File value)? func) {
  return GestureDetector(
    onTap: () => _showPickOptionsDialog(context, func),
    child: Center(
      child: CircleAvatar(
        radius: 80,
        child: null,
        backgroundImage: BlocProvider.of<AlumniInformationBloc>(context)
                    .state
                    .avatar !=
                null
            ? FileImage(
                BlocProvider.of<AlumniInformationBloc>(context).state.avatar!)
            : AssetImage(AppAssets.noneAvatarImage)
                as ImageProvider, // Explicitly cast to ImageProvider
      ),
    ),
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
        toolbarTitle: translate('cropper'),
        toolbarColor: AppColors.element,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: translate('cropper'),
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
            title: Text(translate('choose_from_library')),
            onTap: () {
              _loadPicker(context, ImageSource.gallery,
                  func); // Pass context to _loadPicker
            },
          ),
          ListTile(
            title: Text(translate('take_photo')),
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

Widget alumniInformation(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 230.w,
                  height: 230.w,
                  child: Image.asset(
                    AppAssets.logoImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  translate('start').toUpperCase(),
                  style: AppTextStyle.medium(context).wSemiBold(),
                ),
              )),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(translate('alumni_information_verify_title'),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.small(context)),
              )),
              SizedBox(
                height: 5.h,
              ),
              chooseAvatar(context, (value) {
                context.read<AlumniInformationBloc>().add(AvatarEvent(value));
              }),
              SizedBox(
                height: 25.h,
              ),
              buildTextField(context, translate('full_name*'), "fullName",
                  AppAssets.userIconP, (value) {
                context.read<AlumniInformationBloc>().add(FullNameEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(
            context, translate('continue').toUpperCase(), "verify"),
      ],
    ),
  );
}
