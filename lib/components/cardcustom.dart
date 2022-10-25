import 'package:esperk/constant/linkapi.dart';
import 'package:esperk/model/sparamodel.dart';
import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final void Function() ontap;
  final SparaModel sparamodel;

  const CardCustom({
    Key? key,
    required this.ontap,
    required this.sparamodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${sparamodel.sparaImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${sparamodel.sparaName}"),
                  subtitle: Text("${sparamodel.sparaPrice}",
                      semanticsLabel: "${sparamodel.sparaVersion}"),
                ))
          ],
        ),
      ),
    );
  }
}
