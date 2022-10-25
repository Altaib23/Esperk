// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:esperk/components/crud.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:esperk/main.dart';
import 'package:esperk/pages/spare_parts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:esperk/common/theme_helper.dart';
import '../widgets/header_widget.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminloginState createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  // ignore: prefer_final_fields
  double _headerHeight = 250;

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController admin_email = TextEditingController();
  TextEditingController admin_password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  loginAdmin() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkAdmin, {
        "admin_email": admin_email.text,
        "admin_password": admin_password.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        // sharedPref.setString("id", response['data']['id'].toString());
        // sharedPref.setString("admin_email", response['data']['admin_email']);
        // sharedPref.setString(
        //     "admin_password", response['data']['admin_password']);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
      } else {
        AwesomeDialog(
                context: context,
                title: "تنبيه",
                body: const Text(
                    "البريد الالكتروني او كلمة المرور خطأ او الحساب غير موجود"))
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: _headerHeight,
                    child: HeaderWidget(
                        _headerHeight,
                        true,
                        Icons
                            .login_rounded), //let's create a common header widget
                  ),
                  SafeArea(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(
                            20, 10, 20, 10), // This will be the login form
                        child: Column(
                          children: [
                            const Text(
                              'شاشة المدير',
                              style: TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'الدخول الى لوحة التحكم',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 30.0),
                            Form(
                                key: formstate,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        controller: admin_email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                'البريد الالكتروني',
                                                'أدخل بريدك الإلكتروني'),
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 30.0),
                                    Container(
                                      child: TextField(
                                        obscureText: true,
                                        controller: admin_password,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('كلمة المرور',
                                                'ادخل رقمك السري'),
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'تسجيل الدخول'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await loginAdmin();
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}
