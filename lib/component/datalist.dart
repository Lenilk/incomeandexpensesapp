import 'package:flutter/material.dart';
import './databox.dart';

class Datalist extends StatelessWidget {
  final List data;
  const Datalist({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DataBox(
                          type: data[index]["type"],
                          data: data[index],
                          index: index);
                    }),
              ),
            ])));
  }
}
