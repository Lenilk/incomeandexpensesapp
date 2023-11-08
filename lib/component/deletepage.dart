import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';
import 'package:incomeandexpensesapp/function/function.dart';

class DeletePage extends StatefulWidget {
  final Note data;
  final String date;
  const DeletePage({Key? key, required this.data, required this.date})
      : super(key: key);

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("จะลบจริงๆหรอ")),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      scrollable: true,
      content: Center(
        child: Text("ชื่อรายการ คือ ${widget.data.info}"),
      ),
      actions: [
        TextButton(
          child: const Text(
            'ไม่ลบ',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'ลบ',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Provider.of<Stater>(context, listen: false)
                .deleteDataInDate(widget.date, widget.data);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
