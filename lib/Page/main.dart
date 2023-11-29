import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? PortraitLayout(
              key: UniqueKey(),
            )
          : LandScapeLayout(
              key: UniqueKey(),
            );
    });
  }
}
