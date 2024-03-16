import 'package:fedserv_task/utils/color_constant/color_constant.dart';
import 'package:fedserv_task/view/edit_screen/edit_screen.dart';
import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key});

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
              Icons.arrow_back,
              size: 30,
              color: ColorConstant.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(),
                    ));
              },
              icon: Icon(
                Icons.edit,
                size: 30,
                color: ColorConstant.black,
              )),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_outline,
                color: ColorConstant.black,
                size: 30,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: ColorConstant.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Name",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 230, 224, 224)),
              child: Column(),
            )
          ],
        ),
      ),
    );
  }
}
