import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_events.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../common/values/colors.dart';

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset("assets/icons/$iconName.png"),
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
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
              maxLength: textType == 'studentId' ? 8 : 100,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 20.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "verify"
            ? AppColors.primaryElement
            : AppColors.primarySecondaryElement,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "verify"
              ? Colors.transparent
              : AppColors.primaryFourthElementText,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: buttonType == "verify"
                  ? AppColors.primaryBackground
                  : AppColors.primaryElement),
        ),
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
            : AssetImage("assets/images/none_avatar.png")
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
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,),
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
            title: Text("Pick from Gallery"),
            onTap: () {
              _loadPicker(context, ImageSource.gallery,
                  func); // Pass context to _loadPicker
            },
          ),
          ListTile(
            title: Text("Take a picture"),
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
