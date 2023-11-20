import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/component.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';

import '../../function/extension.dart';
import '../../function/function.dart';

class MainPortraitPage extends StatefulWidget {
  const MainPortraitPage({super.key});

  @override
  State<MainPortraitPage> createState() => _MainPortraitPageState();
}

class _MainPortraitPageState extends State<MainPortraitPage> {
  @override
  Widget build(BuildContext context) {
    List<Data> data = context.watch<Stater>().data;
    String selectDateINData =
        Provider.of<Stater>(context, listen: true).selectDateString();
    int whereday = whereDateInData(selectDateINData, context);
    bool isDayAvailable = isSelectDayAvailablefn(selectDateINData, context);
    List<Note> datalist = isDayAvailable ? data[whereday].data : [];
    int incomeamt = context.watch<Stater>().incomeAmount();
    int expensamt = context.watch<Stater>().expensAmount();
    bool isSelectMonthAvailable =
        context.watch<Stater>().isSelectMonthAvailable();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            Provider.of<Stater>(context).selectDateTitle(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Column(children: [
        const Calender(),
        if (isDayAvailable)
          ConclusionBar(
            incomeamt: incomeamt,
            expensamt: expensamt,
            key: UniqueKey(),
          ),
        if (isDayAvailable)
          Expanded(
            child: Datalist(
              key: UniqueKey(),
              data: datalist,
              isAvailable: true,
            ),
          )
        else
          const Expanded(
            child: Center(
              child: Text('ไม่มีรายการ'),
            ),
          ),
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isSelectMonthAvailable)
            FloatingActionButton(
              key: UniqueKey(),
              heroTag: 'dashboard',
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              tooltip: 'DashBoard',
              child: const Icon(Icons.assessment_outlined),
            ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ChoicePage(
                  key: UniqueKey(),
                ),
              );
              debugPrint(whereDateInData(selectDateINData, context).toString());
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
