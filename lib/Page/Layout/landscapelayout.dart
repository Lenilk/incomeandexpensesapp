import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/Account/accountpage.dart';
import 'package:incomeandexpensesapp/Page/Dashboard/landscape.dart';
import 'package:incomeandexpensesapp/Page/Main/landscape.dart';
import 'package:incomeandexpensesapp/function/stater.dart';
import 'package:provider/provider.dart';
import 'package:incomeandexpensesapp/env.dart' as env;

class LandScapeLayout extends StatefulWidget {
  const LandScapeLayout({super.key});

  @override
  State<LandScapeLayout> createState() => _LandScapeLayoutState();
}

class _LandScapeLayoutState extends State<LandScapeLayout> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.read<Stater>().selectPage;
    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      context.read<Stater>().onSelectPage(index);
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: <Widget>[
              const MainLandScapePage(),
              const DashBoardLandScapePage(),
              const AccountPage()
            ].elementAt(selectedIndex),
          ),
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        onItemTapped(0);
                      },
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home,
                              color: selectedIndex == 0
                                  ? Colors.amber
                                  : Colors.purple.shade400),
                          const Text('หน้า'),
                          const Text('หลัก')
                        ],
                      ))),
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        onItemTapped(1);
                      },
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assessment_outlined,
                            color: selectedIndex == 1
                                ? Colors.amber
                                : Colors.purple.shade400,
                          ),
                          const Text('แดช'),
                          const Text('บอร์ด')
                        ],
                      ))),
                ),
                if (!env.testTime)
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          onItemTapped(2);
                        },
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle),
                            Text('ผู้ใช้')
                          ],
                        ))),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
