// ignore_for_file: sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'package:esperk/components/crud.dart';
import 'package:esperk/components/valid.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esperk/common/theme_helper.dart';
import 'package:esperk/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../homepage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  final Crud _crud = Crud();

  bool isLoading = false;

  TextEditingController user_name = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_phone = TextEditingController();
  TextEditingController user_password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "user_name": user_name.text,
        "user_email": user_email.text,
        "user_phone": user_phone.text,
        "user_password": user_password.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil("Success", (route) => false);
      } else {
        // ignore: avoid_print
        print("SignUp Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    child: HeaderWidget(
                        150, false, Icons.person_add_alt_1_rounded),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Form(
                          key: formstate,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        color: Colors.white,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20,
                                            offset: const Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(80, 80, 0, 0),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Colors.grey.shade700,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                // ignore: sort_child_properties_last
                                child: TextFormField(
                                  validator: (val) {
                                    return validInput(val!, 3, 20);
                                  },
                                  controller: user_name,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'أسم المستخدم', 'أدخل أسم المستخدم'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                // ignore: sort_child_properties_last
                                child: TextFormField(
                                  controller: user_email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "البريد الالكتروني",
                                      "أدخل البريد الالكتروني"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (!(val!.isEmpty) &&
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                                      return "أدخل عنوان بريد إلكتروني صالح";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(height: 20.0),
                              Container(
                                // ignore: sort_child_properties_last
                                child: TextFormField(
                                  controller: user_phone,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "رقم الهاتف", "أدخل رقم هاتفك المحمول"),
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    // ignore: prefer_is_not_empty
                                    if (!(val!.isEmpty) &&
                                        !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                      return "أدخل رقم هاتف صالح";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  controller: user_password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "كلمة المرور", "ادخل رقمك السري"),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "من فضلك أدخل رقمك السري";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(height: 15.0),
                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: <Widget>[
                                          // Checkbox(
                                          //     value: checkboxValue,
                                          //     onChanged: (value) {
                                          //       setState(() {
                                          //         checkboxValue = value!;
                                          //         state.didChange(value);
                                          //       });
                                          //     }),
                                          Text(
                                            "أوافق على جميع الشروط والأحكام",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                // validator: (value) {
                                //   if (!checkboxValue) {
                                //     return 'تحتاج إلى قبول الشروط والأحكام';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "سجل الان".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await signUp();
                                  },
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                "أو إنشاء حساب باستخدام وسائل التواصل الاجتماعي",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 25.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.googlePlus,
                                      size: 35,
                                      color: HexColor("#EC2D2F"),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Google Plus",
                                                "You tap on GooglePlus social icon.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5,
                                            color: HexColor("#40ABF0")),
                                        color: HexColor("#40ABF0"),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.twitter,
                                        size: 23,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Twitter",
                                                "You tap on Twitter social icon.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 35,
                                      color: HexColor("#3E529C"),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Facebook",
                                                "You tap on Facebook social icon.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
