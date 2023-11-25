import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:provider/provider.dart';

class ConclusionBarMainPage extends StatelessWidget {
  const ConclusionBarMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Stater>(builder: (context, data, child) {
      bool isDayAvailable = data.isSelectDayAvailable(context);
      if (!isDayAvailable) {
        return const SizedBox();
      }
      return ConclusionBar(
        incomeamt: data.incomeAmount(),
        expensamt: data.expensAmount(),
        key: UniqueKey(),
      );
    });
  }
}
