import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import './databox.dart';

class Datalist extends StatelessWidget {
  final List<Note> data;
  final bool isAvailable;
  const Datalist({Key? key, required this.data, required this.isAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: (canScroll) ? null : const NeverScrollableScrollPhysics(),
        // shrinkWrap: shrinkwrap,
        key: UniqueKey(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return DataBox(
              key: UniqueKey(),
              isAvailable: isAvailable,
              type: data[index].type,
              data: data[index],
              index: index);
        });
  }
}
