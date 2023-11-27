import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/function/stater.dart';
import 'package:incomeandexpensesapp/jsonserialization/dashboard.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoardLandScapePage extends StatelessWidget {
  const DashBoardLandScapePage({super.key});
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text(
            'สรุปยอดรายเดือน',
          ),
        ),
      ),
      body: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(255, 110, 207, 139),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PieChart(
                      key: UniqueKey(),
                      dataMap: {
                        'รายจ่าย': expens.toDouble(),
                        'รายรับ': income.toDouble()
                      },
                      chartLegendSpacing: 16,
                      chartRadius: 250,
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
                          chartValueStyle:
                              TextStyle(color: Colors.orangeAccent)),
                    ),
                  ),
                  ConclusionBar(incomeamt: income, expensamt: expens),
                  if (total > 0)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.purpleAccent,
                            child: Text(
                              'เงินคงเหลือ $total บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )),
        Expanded(
            flex: 1,
            child: ListView.builder(
                padding: const EdgeInsets.only(left: 16),
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        date,
                        key: UniqueKey(),
                        textAlign: TextAlign.center,
                      ),
                      if (isIncomeDataNotEmpty) textData('รายรับ'),
                      if (isIncomeDataNotEmpty) listData(incomeData),
                      if (isExpensDataNotEmpty) textData('รายจ่าย'),
                      if (isExpensDataNotEmpty) listData(expensData),
                      if (index == (datathismonth.length - 1))
                        const SizedBox(
                          height: 16,
                        )
                    ],
                  );
                }))
      ]),
    );
  }
}
