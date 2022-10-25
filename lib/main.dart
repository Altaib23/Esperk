// ignore_for_file: prefer_const_constructors

import 'package:esperk/pages/auth/admin.dart';
import 'package:esperk/pages/auth/login_page.dart';
import 'package:esperk/pages/auth/success.dart';
import 'package:esperk/pages/homepage.dart';
import 'package:esperk/pages/spara/add_spare.dart';
import 'package:esperk/pages/spara/edit_spara.dart';
import 'package:esperk/pages/spara/home.dart';
import 'package:esperk/pages/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(esperk());
}

class esperk extends StatelessWidget {
  final Color _primaryColor = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إسبيرك علينا',
      theme: ThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: _accentColor),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(title: 'إسبيرك علينا'),
      // initialRoute:
      //     sharedPref.getString("id") == null ? "LoginPage" : "HomePage",
      routes: {
        // ignore: prefer_const_constructors
        "WelcomePage": (context) => WelcomePage(),
        "LoginPage": (context) => LoginPage(),
        "Adminlogin": (context) => Adminlogin(),
        "Success": (context) => Success(),
        "Home": (context) => Home(),
        "HomePage": (context) => HomePage(),
        "AddSpara": (context) => AddSpara(),
        "EditSpar": (context) => EditSpar(),
      },
    );
  }
}
