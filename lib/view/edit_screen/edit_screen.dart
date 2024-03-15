import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 30,
            )),
        title: Text("Edit Contact"),
        actions: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 110, 96, 235),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Save",
              style: TextStyle(color: Colors.black),
            )),
          )
        ],
      ),
    );
  }
}
