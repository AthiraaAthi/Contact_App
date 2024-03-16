import 'dart:ffi';

import 'package:fedserv_task/controller/my_controller.dart';
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
  EditingController obj = EditingController();
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await obj.getAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Sort myList by first names
    //myList.sort();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        elevation: 0,
        title: Text(
          "My Contacts",
          style: TextStyle(color: ColorConstant.black),
        ),
      ),
      body: obj.data.isEmpty
          ? Center(child: Text("No contacts found , Add some"))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: obj.data.length,
                //myList.length ~/ 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetailScreen(
                              OnPressEdit: () async {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      height: 400,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: FirstNameController,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.person),
                                                  hintText: "First Name",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              controller: SecondNameController,
                                              decoration: InputDecoration(
                                                  hintText: "Last Name",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              controller: PhoneController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.call),
                                                  hintText: "Phone",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              controller: EmailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.mail),
                                                  hintText: "Email",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorConstant
                                                                .defaultBlue)),
                                                onPressed: () async {
                                                  await obj.EditScreen(
                                                      FirstNameController.text,
                                                      SecondNameController.text,
                                                      PhoneController.text,
                                                      EmailController.text,
                                                      obj.data[index]["id"]);
                                                  Navigator.pop(context);
                                                  fetchData();

                                                  FirstNameController.clear();
                                                  SecondNameController.clear();
                                                  PhoneController.clear();
                                                  EmailController.clear();

                                                  //setState(() {});
                                                },
                                                child: Text("Save"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              Name: obj.data[index]["name"],
                              // myList[index * 4],
                              phone: obj.data[index]["phone"],

                              ///myList[index * 4 + 2],
                              Email: obj.data[index]["email"],
                              //myList[index * 4 + 3],
                              OnPressDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Are You Sure?"),
                                    content: Text(
                                        "Delete ${obj.data[index]["name"]} ?"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                await obj.DeleteScreen(
                                                    obj.data[index]["id"]);
                                                fetchData();

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen(),
                                                    ));
                                              },
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                                // myList.removeAt(index);
                                // setState(() {});
                              },
                            ),
                          ));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: Mycolor[index % Mycolor.length],
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: ColorConstant.white,
                        ),
                      ),
                      title: Text(
                        "${obj.data[index]["name"]} ${obj.data[index]["name2"] ?? ""}",
                        //myList[index * 4 + 0] + myList[index * 4 + 1]
                      ),
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
                          onPressed: () async {
                            await obj.AddScreen(
                              name: FirstNameController.text.toString(),
                              name2: SecondNameController.text.toString(),
                              phone: PhoneController.text.toString(),
                              email: EmailController.text.toString(),
                            );
                            Navigator.pop(context);
                            fetchData();

                            // myList.add(FirstNameController.text);
                            // myList.add(SecondNameController.text);
                            // myList.add(PhoneController.text);
                            // myList.add(EmailController.text);

                            //myList.sort();
                            //myList.sort((a, b) => a.compareTo(b));

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
