import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/datalist.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:provider/provider.dart';

class DataListMainPage extends StatelessWidget {
  final bool isAvailable;
  const DataListMainPage({Key? key, required this.isAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Stater>(builder: (context, data, child) {
      bool isDayAvailable = data.isSelectDayAvailable(context);
      if (!isDayAvailable) {
        return const Expanded(
          child: Center(
            child: Text('ไม่มีรายการ'),
          ),
        );
      }
      return Expanded(
        child: Datalist(
            key: UniqueKey(),
            data: data.dataListInSelectDay(context),
            isAvailable: isAvailable),
      );
    });
  }
}
