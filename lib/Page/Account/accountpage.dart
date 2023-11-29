import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = context.read<User>().username;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          toolbarHeight: 60,
          title: const Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text('บัญชีผู้ใช้'))),
        ),
        body: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800, minWidth: 400),
              padding: const EdgeInsets.all(16),
              child: const Column(
                children: [Icon(Icons.account_circle_rounded)],
              )),
        ));
  }
}
