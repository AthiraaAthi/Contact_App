import 'dart:ffi';

import 'package:fedserv_task/controller/my_controller.dart';
import 'package:fedserv_task/utils/color_constant/color_constant.dart';
import 'package:fedserv_task/view/contact_detail_screen/contact_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeKey = GlobalKey<FormState>();
  List<Color> Mycolor = [
    Color.fromARGB(255, 238, 193, 77),
    Color.fromARGB(255, 136, 241, 140),
    const Color.fromARGB(255, 240, 116, 107),
    Color.fromARGB(255, 101, 178, 240),
    Color.fromARGB(255, 255, 146, 215)
  ];

  TextEditingController firstNameController = TextEditingController();

  TextEditingController secondNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  List myList = [];
  //final obj = EditingController();

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    sort();
    super.initState();
  }

  Future<void> fetchData() async {
    await Provider.of<EditingController>(context, listen: false).getAllData();
    // await obj.getAllData();
    // setState(() {});
  }

  Future<void> sort() async {
    await Provider.of<EditingController>(context, listen: false)
        .fetchSortedContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final obj = Provider.of<EditingController>(context);
    //obj.data.sort();
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
                                ////////////////////////ON EDIT PRESS
                                return showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    firstNameController.text =
                                        obj.data[index]["name"];
                                    secondNameController.text =
                                        obj.data[index]["name2"];
                                    phoneController.text =
                                        obj.data[index]["phone"];
                                    emailController.text =
                                        obj.data[index]["email"];
                                    return Padding(
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
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "please enter a name";
                                                  } else if (value.length <=
                                                      3) {
                                                    return "Name must be longer than 3 characters";
                                                  } else if (value ==
                                                      firstNameController
                                                          .text) {
                                                    return "Name must be different from the previous one";
                                                  }
                                                  return null;
                                                },
                                                controller: firstNameController,
                                                decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.person),
                                                    hintText: "First Name",
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller:
                                                    secondNameController,
                                                decoration: InputDecoration(
                                                    hintText: "Last Name",
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller: phoneController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.call),
                                                    hintText: "Phone",
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                controller: emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.mail),
                                                    hintText: "Email",
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
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
                                                        firstNameController
                                                            .text,
                                                        secondNameController
                                                            .text,
                                                        phoneController.text,
                                                        emailController.text,
                                                        obj.data[index]["id"]);
                                                    Navigator.pop(context);
                                                    firstNameController.clear();
                                                    secondNameController
                                                        .clear();
                                                    phoneController.clear();
                                                    emailController.clear();

                                                    fetchData();

                                                    //setState(() {});
                                                  },
                                                  child: Text("Save"))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                // showbottomsheet(
                                //   context: context,
                                //   index: index,
                                //   firstname: obj.data[index]["name"],
                                //   lastName: obj.data[index]["name2"],
                                //   email: obj.data[index]["email"],
                                //   phone: obj.data[index]["phone"],
                                // );
                              },
                              Name: obj.data[index]["name"],
                              // myList[index * 4],
                              phone: obj.data[index]["phone"],

                              ///myList[index * 4 + 2],
                              Email: obj.data[index]["email"],
                              //myList[index * 4 + 3],
                              color: Mycolor[index % Mycolor.length],
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
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Are You Sure?"),
                                content:
                                    Text("Delete ${obj.data[index]["name"]} ?"),
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
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
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
                height: 430,
                width: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _homeKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "it can't be empty";
                              } else if (value.length <= 3) {
                                return "characters should be atleast 3";
                              } else if (value == secondNameController.text) {
                                return "it shouldn't be the same";
                              } else {
                                return null;
                              }
                            },
                            controller: firstNameController,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "it can't be empty";
                              } else if (value.length <= 3) {
                                return "characters should be atleast 3";
                              } else if (value == firstNameController.text) {
                                return "it shouldn't be the same";
                              } else {
                                return null;
                              }
                            },
                            controller: secondNameController,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "it can't be empty";
                              } else if (value.length < 10) {
                                return "characters must be atleast 10";
                              } else if (!(value.startsWith("6") ||
                                  value.startsWith("7") ||
                                  value.startsWith("8") ||
                                  value.startsWith("9"))) {
                                return "number should start with 6,7,8,9";
                              } else {
                                return null;
                              }
                            },
                            controller: phoneController,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "it can't be empty";
                              } else if (!value.contains("@")) {
                                return "enter a valid email!";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorConstant.defaultBlue)),
                              onPressed: () async {
                                if (_homeKey.currentState!.validate()) {
                                  await obj.AddScreen(
                                    name: firstNameController.text.toString(),
                                    name2: secondNameController.text.toString(),
                                    phone: phoneController.text.toString(),
                                    email: emailController.text.toString(),
                                  );

                                  Navigator.pop(context);
                                  firstNameController.clear();
                                  secondNameController.clear();
                                  phoneController.clear();
                                  emailController.clear();

                                  sort();

                                  fetchData();

                                  //setState(() {});
                                }

                                // myList.add(FirstNameController.text);
                                // myList.add(SecondNameController.text);
                                // myList.add(PhoneController.text);
                                // myList.add(EmailController.text);

                                //myList.sort();
                                //myList.sort((a, b) => a.compareTo(b));
                              },
                              child: Text("Save"))
                        ],
                      ),
                    ),
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

  // showbottomsheet({
  //   required BuildContext context,
  //   required int index,
  //   required String firstname,
  //   required String lastName,
  //   required String phone,
  //   required String email,
  // }) {
  //   firstNameController.text = firstname;
  //   secondNameController.text = lastName;
  //   phoneController.text = phone;
  //   emailController.text = email;
  //   final obj = Provider.of<EditingController>(context);

  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: Container(
  //           height: 400,
  //           width: 200,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(10),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextFormField(
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return "please enter a name";
  //                     } else if (value.length <= 3) {
  //                       return "Name must be longer than 3 characters";
  //                     } else if (value == firstNameController.text) {
  //                       return "Name must be different from the previous one";
  //                     }
  //                     return null;
  //                   },
  //                   controller: firstNameController,
  //                   decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.person),
  //                       hintText: "First Name",
  //                       border: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey),
  //                           borderRadius: BorderRadius.circular(20))),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 TextFormField(
  //                   controller: secondNameController,
  //                   decoration: InputDecoration(
  //                       hintText: "Last Name",
  //                       border: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey),
  //                           borderRadius: BorderRadius.circular(20))),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 TextFormField(
  //                   controller: phoneController,
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.call),
  //                       hintText: "Phone",
  //                       border: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey),
  //                           borderRadius: BorderRadius.circular(20))),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 TextFormField(
  //                   controller: emailController,
  //                   keyboardType: TextInputType.emailAddress,
  //                   decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.mail),
  //                       hintText: "Email",
  //                       border: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.grey),
  //                           borderRadius: BorderRadius.circular(20))),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 ElevatedButton(
  //                     style: ButtonStyle(
  //                         backgroundColor: MaterialStatePropertyAll(
  //                             ColorConstant.defaultBlue)),
  //                     onPressed: () async {
  //                       await obj.EditScreen(
  //                           firstNameController.text,
  //                           secondNameController.text,
  //                           phoneController.text,
  //                           emailController.text,
  //                           obj.data[index]["id"]);
  //                       Navigator.pop(context);
  //                       fetchData();

  //                       //setState(() {});
  //                     },
  //                     child: Text("Save"))
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
