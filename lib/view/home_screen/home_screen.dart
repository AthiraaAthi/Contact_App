import 'package:fedserv_task/utils/color_constant/color_constant.dart';
import 'package:fedserv_task/view/contact_detail_screen/contact_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> Mycolor = [
    Color.fromARGB(255, 238, 193, 77),
    Color.fromARGB(255, 136, 241, 140),
    const Color.fromARGB(255, 240, 116, 107),
    Color.fromARGB(255, 101, 178, 240),
    Color.fromARGB(255, 255, 146, 215)
  ];

  TextEditingController FirstNameController = TextEditingController();

  TextEditingController SecondNameController = TextEditingController();

  TextEditingController PhoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  List myList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        elevation: 0,
        title: Text(
          "My Contacts",
          style: TextStyle(color: ColorConstant.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: myList.length ~/ 3,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(
                        Name: myList[index * 3],
                        phone: myList[index * 3 + 2],
                        Email: myList[index * 3 + 3],
                      ),
                    ));
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  backgroundColor: Mycolor[index],
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: ColorConstant.white,
                  ),
                ),
                title: Text(myList[index * 3] + myList[index * 3 + 1]),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.defaultBlue,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 400,
                width: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: FirstNameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: SecondNameController,
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: PhoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.call),
                            hintText: "Phone",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorConstant.defaultBlue)),
                          onPressed: () {
                            myList.add(FirstNameController.text);
                            myList.add(SecondNameController.text);
                            myList.add(PhoneController.text);
                            myList.add(EmailController.text);

                            Navigator.pop(context);
                            FirstNameController.clear();
                            SecondNameController.clear();
                            PhoneController.clear();
                            EmailController.clear();
                            setState(() {});
                          },
                          child: Text("Save"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: ColorConstant.black,
          size: 30,
        ),
      ),
    );
  }
}
