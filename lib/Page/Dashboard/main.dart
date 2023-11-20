import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/Dashboard/landscape.dart';
import 'package:incomeandexpensesapp/Page/Dashboard/portrait.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const DashBoardPortraitPage()
          : const DashBoardLandScapePage();
    });
  }
}
