import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/component.dart';
import 'package:incomeandexpensesapp/component/datalistmain.dart';
import 'package:provider/provider.dart';
import '../../function/function.dart';

class MainPortraitPage extends StatefulWidget {
  const MainPortraitPage({super.key});

  @override
  State<MainPortraitPage> createState() => _MainPortraitPageState();
}

class _MainPortraitPageState extends State<MainPortraitPage> {
  @override
  Widget build(BuildContext context) {
    // String selectDateINData =
    //     Provider.of<Stater>(context, listen: true).selectDateString();
    // int whereday = whereDateInData(selectDateINData, context);
    // bool isDayAvailable = isSelectDayAvailablefn(selectDateINData, context);
    // List<Note> datalist = isDayAvailable ? data[whereday].data : [];
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Consumer<Stater>(builder: (context, data, child) {
            return Text(
              data.selectDateTitle(),
              style: const TextStyle(fontSize: 20),
            );
          }),
        ),
      ),
      body: const Column(children: [
        Calender(),
        ConclusionBarMainPage(),
        DataListMainPage(isAvailable: true)
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<Stater>(builder: (context, data, child) {
            if (!data.isSelectMonthAvailable()) {
              return const SizedBox();
            }
            return FloatingActionButton(
              key: UniqueKey(),
              heroTag: 'dashboard',
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              tooltip: 'DashBoard',
              child: const Icon(Icons.assessment_outlined),
            );
          }),
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
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
