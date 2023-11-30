import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  Widget headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget detailText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black87, fontSize: 18),
    );
  }

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
              constraints: const BoxConstraints(
                  maxWidth: 400, minWidth: 200, maxHeight: 500),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 100,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [headerText('ชื่อผู้ใช้')],
                          ),
                          Column(
                            children: [detailText(username)],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
