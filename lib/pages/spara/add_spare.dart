// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:esperk/components/crud.dart';
import 'package:esperk/components/customtextform.dart';
import 'package:esperk/components/valid.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:esperk/main.dart';
import 'package:image_picker/image_picker.dart';

class AddSpara extends StatefulWidget {
  AddSpara({Key? key}) : super(key: key);

  @override
  State<AddSpara> createState() => _AddSparaState();
}

class _AddSparaState extends State<AddSpara> with Crud {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController spara_name = TextEditingController();
  TextEditingController spara_price = TextEditingController();
  TextEditingController spara_version = TextEditingController();

  bool isLoading = false;

  addSpara() async {
    if (myfile == null)
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("الرجاء اضافة الصورة الخاصة بالاسبير"))
        ..show();
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddSpara,
          {
            "spara_name": spara_name.text,
            "spara_price": spara_price.text,
            "spara_version": spara_version.text,
            "id": sharedPref.getString("id")
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("Home");
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "إضافة اسبير",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustTextFormSign(
                        hint: "اسم الاسبير",
                        mycontroller: spara_name,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    CustTextFormSign(
                        hint: "سعر الاسبير",
                        mycontroller: spara_price,
                        valid: (val) {
                          return validInput(val!, 1, 10);
                        }),
                    CustTextFormSign(
                        hint: "إصدار الاسبير",
                        mycontroller: spara_version,
                        valid: (val) {
                          return validInput(val!, 1, 10);
                        }),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                            "الرجاء إضافة الصورة الخاصة بالاسبير",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        myfile = File(xfile!.path);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "من المعرض",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();

                                        myfile = File(xfile!.path);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "من الكاميرا",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  ],
                                )));
                      },
                      child: Text("اختر الصورة"),
                      textColor: Colors.white,
                      color: myfile == null ? Colors.blue : Colors.green,
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addSpara();
                      },
                      child: Text("إضافة"),
                      textColor: Colors.white,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
