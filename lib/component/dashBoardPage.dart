import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:incomeandexpensesapp/jsonserialization/dashboard.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    DashBoard widgetData = context.read<Stater>().calDashboard();
    String title = widgetData.title;
    List<Data> data = widgetData.data;
    int income = widgetData.income;
    int expens = widgetData.expens;
    int total = widgetData.total;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: ListView(
          children: [ConclusionBar(incomeamt: income, expensamt: expens)]),
    );
  }
}
