import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/Account/accountpage.dart';
import 'package:incomeandexpensesapp/Page/Dashboard/landscape.dart';
import 'package:incomeandexpensesapp/Page/Main/landscape.dart';
import 'package:incomeandexpensesapp/function/stater.dart';
import 'package:provider/provider.dart';

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
                      child: const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home),
                          Text('หน้า'),
                          Text('หลัก')
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
                      child: const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assessment_outlined),
                          Text('แดช'),
                          Text('บอร์ด')
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
                        onItemTapped(2);
                      },
                      child: const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.account_circle), Text('ผู้ใช้')],
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
