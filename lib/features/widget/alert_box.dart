import 'package:data_base/config/app_color.dart';
import 'package:data_base/config/app_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlertBox extends StatelessWidget {
  AlertBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.yesFun,
    required this.noFun,
  });
  String title = "";
  String subTitle = "";
  void Function()? yesFun;
  void Function()? noFun;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Center(
          child: Text(
        title,
        style: AppStyle(context).headingMediumBold.copyWith(fontSize: 18),
      )),
      content: Text(
        subTitle,
        style: const TextStyle(color: AppColor.darkGrey),
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
                backgroundColor:
                    const MaterialStatePropertyAll(AppColor.buttonColor)),
            onPressed: noFun,
            child: const Text(
              "NO",
              style: TextStyle(color: AppColor.white),
            )),
        ElevatedButton(
            style: ButtonStyle(
                overlayColor:
                    const MaterialStatePropertyAll(AppColor.buttonColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )),
                backgroundColor:
                    const MaterialStatePropertyAll(AppColor.greyText)),
            onPressed: yesFun,
            child: const Text(
              "YES",
              style: TextStyle(color: AppColor.black),
            ))
      ],
    );
  }
}
