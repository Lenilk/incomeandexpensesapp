import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/Main/landscape.dart';
import 'package:incomeandexpensesapp/Page/Main/portrait.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const MainPortraitPage()
          : const MainLandScapePage();
    });
  }
}
