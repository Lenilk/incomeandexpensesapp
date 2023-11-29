import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/Page/Account/accountpage.dart';
import 'package:incomeandexpensesapp/Page/Dashboard/portrait.dart';
import 'package:incomeandexpensesapp/Page/Main/portrait.dart';
import 'package:incomeandexpensesapp/function/stater.dart';
import 'package:provider/provider.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({super.key});

  @override
  State<PortraitLayout> createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<Stater>().selectPage;
    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      context.read<Stater>().onSelectPage(index);
    }

    return Scaffold(
      body: <Widget>[
        const MainPortraitPage(),
        const DashBoardPortraitPage(),
        const AccountPage()
      ].elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'แดชบอร์ด',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ผู้ใช้',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
