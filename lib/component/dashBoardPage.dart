import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/jsonserialization/dashboard.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';

class DashBoardPage extends StatefulWidget {
  final DashBoard data;
  const DashBoardPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    DashBoard widgetData = widget.data;
    String title = widgetData.title;
    List<Data> data = widgetData.data;
    int income = widgetData.income;
    int expens = widgetData.expens;
    int total = widgetData.total;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: ListView(
          children: [ConclusionBar(incomeamt: income, expensamt: expens)]),
    );
  }
}
