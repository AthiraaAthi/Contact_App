import 'package:fedserv_task/utils/color_constant/color_constant.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 30,
              color: ColorConstant.black,
            )),
        title: Text(
          "Edit Contact",
          style: TextStyle(color: ColorConstant.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  color: ColorConstant.defaultBlue,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(color: ColorConstant.black),
              )),
            ),
          )
        ],
      ),
    );
  }
}
