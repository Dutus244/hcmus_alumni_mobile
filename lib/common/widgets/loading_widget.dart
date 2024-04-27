import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingWidget() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(4.0),
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}