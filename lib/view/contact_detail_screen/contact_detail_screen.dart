import 'package:fedserv_task/view/edit_screen/edit_screen.dart';
import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
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
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_outline,
                color: Colors.grey,
                size: 30,
              )),
        ],
      ),
    );
  }
}
