import 'package:esperk/constant/linkapi.dart';
import 'package:esperk/model/sparamodel.dart';
import 'package:flutter/material.dart';

class CardSpara extends StatelessWidget {
  final void Function() ontap;
  final SparaModel sparamodel;
  final void Function()? onDelete;
  const CardSpara(
      {Key? key,
      required this.ontap,
      required this.sparamodel,
      required this.onDelete})
      : super(key: key);

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
                  subtitle: Text(
                    "${sparamodel.sparaPrice}",
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
