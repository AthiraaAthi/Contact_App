import 'package:flutter/material.dart';

import '../../utils/color_constant/color_constant.dart';

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget(
      {super.key,
      required this.Name,
      required this.phone,
      required this.Email});
  final String Name;
  final String phone;
  final String Email;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            Name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 240,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstant.defaultGrey),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Contact info",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 160,
                    width: 380,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            size: 30,
                          ),
                          title: Text(phone),
                          subtitle: Text("Phone"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            size: 30,
                          ),
                          title: Text(Email),
                          subtitle: Text("Phone"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
