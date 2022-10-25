// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول",
              style: TextStyle(fontSize: 20),
            ),
          ),
          MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("LoginPage", (route) => false);
              },
              child: Text("تسجيل الدخول"))
        ],
      ),
    );
  }
}
