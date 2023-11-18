import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:incomeandexpensesapp/jsonserialization/dashboard.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Widget textInfo(String data) {
    return Expanded(
      flex: 70,
      child: Text(
        key: UniqueKey(),
        data,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget listData(List<Note?> data) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, dataIndex) {
          int num = dataIndex + 1;
          return Row(
            children: [
              textInfo('$num.${data[dataIndex]!.info}'),
              textAmount('${data[dataIndex]!.amount} บาท')
            ],
          );
        });
  }

  Widget textAmount(String data) {
    return Expanded(
      flex: 30,
      child: Text(
        key: UniqueKey(),
        data,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget textData(String data) {
    return Text(
      key: UniqueKey(),
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    DashBoard widgetData = context.read<Stater>().calDashboard();
    String title = widgetData.title;
    List<Data> datathismonth = widgetData.data;
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
      body: ListView(children: [
        const SizedBox(
          height: 16,
        ),
        PieChart(
          key: UniqueKey(),
          dataMap: {'รายจ่าย': expens.toDouble(), 'รายรับ': income.toDouble()},
          chartLegendSpacing: 16,
          chartRadius: 150,
          colorList: const [
            Colors.redAccent,
            Colors.lightBlue,
          ],
          chartType: ChartType.disc,
          legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              decimalPlaces: 0,
              chartValueStyle: TextStyle(color: Colors.orangeAccent)),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
        const SizedBox(
          height: 8,
        ),
        ConclusionBar(incomeamt: income, expensamt: expens),
        if (total > 0)
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.purpleAccent,
            padding: const EdgeInsets.all(10),
            child: Text(
              'เงินคงเหลือ $total บาท',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: datathismonth.length,
              itemBuilder: (BuildContext context, index) {
                String date = datathismonth[index].Date;
                List<Note> data = datathismonth[index].data;
                List<Note?> incomeData =
                    data.where((Note e) => e.type == 'income').toList();
                List<Note?> expensData =
                    data.where((Note e) => e.type == 'expens').toList();
                debugPrint('incomeData=$incomeData');
                debugPrint('expensData=$expensData');
                bool isIncomeDataNotEmpty = incomeData.isNotEmpty;
                bool isExpensDataNotEmpty = expensData.isNotEmpty;
                debugPrint(isIncomeDataNotEmpty.toString());
                debugPrint(isExpensDataNotEmpty.toString());
                return Column(
                  key: UniqueKey(),
                  children: [
                    Text(
                      date,
                      key: UniqueKey(),
                      textAlign: TextAlign.center,
                    ),
                    if (isIncomeDataNotEmpty) textData('รายรับ'),
                    if (isIncomeDataNotEmpty) listData(incomeData),
                    if (isExpensDataNotEmpty) textData('รายจ่าย'),
                    if (isExpensDataNotEmpty) listData(expensData),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                );
              }),
        )
      ]),
    );
  }
}
