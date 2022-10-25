// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:esperk/components/cardspara.dart';
import 'package:esperk/components/crud.dart';
import 'package:esperk/constant/linkapi.dart';
import 'package:esperk/main.dart';
import 'package:esperk/model/sparamodel.dart';
import 'package:esperk/pages/spara/edit_spara.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  bool isLoading = false;

  getNotes() async {
    var response =
        await postRequest(linkViewSpar, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "صفحة المدير",
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
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("admin", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddSpara");
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  FutureBuilder(
                      future: getNotes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data['status'] == 'fail')
                            return Center(
                                child: Text(
                              "لا يوجد اسبيرات",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ));
                          return ListView.builder(
                              itemCount: snapshot.data['data'].length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return CardSpara(
                                    onDelete: () async {
                                      var response =
                                          await postRequest(linkDeleteSpara, {
                                        "id": snapshot.data['data'][i]
                                                ['spara_id']
                                            .toString(),
                                        "imagename": snapshot.data['data'][i]
                                                ['spara_image']
                                            .toString()
                                      });
                                      if (response['status'] == "success") {
                                        Navigator.of(context)
                                            .pushReplacementNamed("home");
                                      }
                                    },
                                    ontap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditSpar(
                                                  spar: snapshot.data['data']
                                                      [i])));
                                    },
                                    sparamodel: SparaModel.fromJson(
                                        snapshot.data['data'][i]));
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("Loading ..."));
                        }
                        return Center(child: Text("Loading ..."));
                      })
                ],
              ),
            ),
    );
  }
}
