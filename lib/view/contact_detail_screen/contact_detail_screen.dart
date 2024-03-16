import 'package:fedserv_task/controller/my_controller.dart';
import 'package:fedserv_task/utils/color_constant/color_constant.dart';
import 'package:fedserv_task/view/edit_screen/edit_screen.dart';
import 'package:flutter/material.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen(
      {super.key,
      required this.Name,
      required this.phone,
      required this.Email,
      this.OnPressDelete,
      this.OnPressEdit});
  final String Name;
  final String phone;
  final String Email;
  final void Function()? OnPressDelete;
  final void Function()? OnPressEdit;

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  EditingController obj = EditingController();

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
              onPressed: widget.OnPressEdit,
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
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: widget.OnPressDelete,
              icon: Icon(
                Icons.delete,
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
              widget.Name,
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
                            title: Text(widget.phone),
                            subtitle: Text("Phone"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.mail,
                              size: 30,
                            ),
                            title: Text(widget.Email),
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
      ),
    );
  }
}
