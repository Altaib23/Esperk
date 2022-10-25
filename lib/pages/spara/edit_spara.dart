// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:esperk/components/crud.dart';
import 'package:esperk/components/customtextform.dart';
import 'package:esperk/components/valid.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditSpar extends StatefulWidget {
  final spar;
  EditSpar({Key? key, this.spar}) : super(key: key);

  @override
  State<EditSpar> createState() => _EditSparState();
}

class _EditSparState extends State<EditSpar> with Crud {
  File? myfile;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController spara_name = TextEditingController();
  TextEditingController spara_price = TextEditingController();
  TextEditingController spara_version = TextEditingController();

  bool isLoading = false;

  EditSpar() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;

      if (myfile == null) {
        response = await postRequest(linkEditSpara, {
          "spara_name": spara_name.text,
          "spara_price": spara_price.text,
          "spara_version": spara_version.text,
          "id": widget.spar['spara_id'].toString(),
          "imagename": widget.spar['spar_image'].toString(),
        });
      } else {
        response = await postRequestWithFile(
            linkEditSpara,
            {
              "spara_name": spara_name.text,
              "spara_price": spara_price.text,
              "spara_version": spara_version.text,
              "imagename": widget.spar['spara_image'].toString(),
              "id": widget.spar['spara_id'].toString()
            },
            myfile!);
      }

      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  @override
  void initState() {
    spara_name.text = widget.spar['spara_name'];
    spara_price.text = widget.spar['spara_price'];
    spara_version.text = widget.spar['spara_version'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة اسبير"),
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
                    Container(height: 20),
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
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "الرجاء إضافة الصورة الخاصة بالاسبير",
                                          style: TextStyle(fontSize: 12)),
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
                      child: Text("اختر صورة"),
                      textColor: Colors.white,
                      color: myfile == null ? Colors.blue : Colors.green,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await EditSpar();
                      },
                      child: Text("حفظ"),
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
