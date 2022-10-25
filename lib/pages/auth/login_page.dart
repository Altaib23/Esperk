import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:esperk/components/crud.dart';
import 'package:esperk/components/valid.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:esperk/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:esperk/pages/homepage.dart';
import 'package:esperk/common/theme_helper.dart';
import '../forgot_password_page.dart';

import 'signup.dart';
import '../widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin,
          {"user_email": user_email.text, "user_password": user_password.text});
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        // sharedPref.setString("id", response['data']['id'].toString());
        // sharedPref.setString("user_email", response['data']['user_email']);
        // sharedPref.setString(
        //     "user_password", response['data']['user_password']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("HomePage", (route) => false);
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
                            Text(
                              'شاشة دخول المستخدم',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'تسجيل الدخول إلى حسابك',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 30.0),
                            Form(
                                key: formstate,
                                child: Column(
                                  children: [
                                    Container(
                                      // ignore: sort_child_properties_last
                                      child: TextField(
                                        controller: user_email,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                'البريد الالكتروني',
                                                'أدخل بريدك الإلكتروني'),
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(height: 30.0),
                                    Container(
                                      child: TextField(
                                        controller: user_password,
                                        obscureText: true,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('كلمة المرور',
                                                'ادخل رقمك السري'),
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 0, 10, 20),
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordPage()),
                                          );
                                        },
                                        child: Text(
                                          "نسيت رقمك السري؟",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          await login();
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      //child: Text('Don\'t have an account? Create'),
                                      child: Text.rich(TextSpan(children: [
                                        TextSpan(text: "ليس لديك حساب؟"),
                                        TextSpan(
                                          text: 'إنشاء',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationPage()));
                                            },
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ])),
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
