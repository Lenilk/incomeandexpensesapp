import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/component.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("เพิ่มข้อมูล"),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          child: const Text('รายจ่าย'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) => const AddPage(isincome: false),
                barrierDismissible: false);
          },
        ),
        TextButton(
          child: const Text('รายรับ'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) => const AddPage(isincome: true),
                barrierDismissible: false);
          },
        ),
      ],
    );
  }
}
