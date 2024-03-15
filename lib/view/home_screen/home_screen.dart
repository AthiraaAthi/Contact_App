import 'package:fedserv_task/view/contact_detail_screen/contact_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Contacts"),
      ),
      body: Container(
        child: Center(
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(),
                    ));
              },
              icon: Icon(
                Icons.no_accounts,
                size: 50,
              )),
        ),
      ),
    );
  }
}
