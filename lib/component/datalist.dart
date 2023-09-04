import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/extension.dart';
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
    String selectDateINData = formatToyMEd(selectDate);
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: context.read<Stater>().isSelectDayAvailable()
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
