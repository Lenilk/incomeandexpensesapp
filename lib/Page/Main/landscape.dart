import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/component.dart';
import 'package:incomeandexpensesapp/component/datalistmain.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MainLandScapePage extends StatefulWidget {
  const MainLandScapePage({super.key});

  @override
  State<MainLandScapePage> createState() => _MainLandScapePageState();
}

class _MainLandScapePageState extends State<MainLandScapePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.of(context).size.height.toString());
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 60,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Consumer<Stater>(builder: (context, data, child) {
              return Text(
                data.selectDateTitle(),
                style: const TextStyle(fontSize: 20),
              );
            }),
          ),
        ),
      ),
      body: Row(children: [
        Expanded(
          flex: 1,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            debugPrint(constraints.maxHeight.toString());
            return Column(
              children: [
                const Calender(),
                (constraints.maxHeight > 420)
                    ? Expanded(
                        child:
                            Consumer<Stater>(builder: (context, data, child) {
                          return PieChart(
                            key: UniqueKey(),
                            dataMap: {
                              'รายจ่าย': data.expensAmount().toDouble(),
                              'รายรับ': data.incomeAmount().toDouble()
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
                          );
                        }),
                      )
                    : Expanded(
                        key: UniqueKey(),
                        child: const SizedBox(),
                      ),
                if (constraints.maxHeight > 270) const ConclusionBarMainPage()
              ],
            );
          }),
        ),
        const DataListMainPage(
          isAvailable: false,
        )
      ]),
      floatingActionButton: LayoutBuilder(builder: (context, consconstrains) {
        return Column(
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
                debugPrint(MediaQuery.of(context).size.height.toString());
                if (consconstrains.maxHeight > 500) {
                  showDialog(
                    context: context,
                    builder: (_) => ChoicePage(
                      key: UniqueKey(),
                    ),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('โปรดหมุนหน้าจอเป็นแนวตั้ง'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('ตกลง'))
                            ],
                          ));
                }
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ],
        );
      }),
    );
  }
}
