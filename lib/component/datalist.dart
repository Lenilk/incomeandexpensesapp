import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '.././function/function.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    Map<String, List> data = context.watch<Stater>().data;
    DateTime selectDate = context.watch<Stater>().selectDate;
    String selectDateINData = DateFormat.yMEd().format(selectDate);
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: data[DateFormat.yMEd().format(selectDate)] != null
          ? ListView.builder(
              itemCount: data[selectDateINData]?.length,
              itemBuilder: (BuildContext context, int index) {
                return Text("${data[selectDateINData]?[index]}");
              })
          : const Center(
              child: Text("No data"),
            ),
    ));
  }
}
