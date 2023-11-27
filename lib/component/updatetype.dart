import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/stater.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';

class UpdateTypePage extends StatefulWidget {
  final Note data;
  final Note json;
  final String date;
  final int index;
  const UpdateTypePage(
      {Key? key,
      required this.data,
      required this.json,
      required this.date,
      required this.index})
      : super(key: key);

  @override
  State<UpdateTypePage> createState() => _UpdateTypePageState();
}

class _UpdateTypePageState extends State<UpdateTypePage> {
  bool notChange = true;
  @override
  Widget build(BuildContext context) {
    Note data = widget.data;
    Note json = widget.json;
    return AlertDialog(
        title: const Center(child: Text('แก้ไขข้อมูล')),
        scrollable: true,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.type != 'income' ? 'รายรับ' : 'รายจ่าย'),
            Switch(
              focusNode: FocusNode(canRequestFocus: true),
              // This bool value toggles the switch.
              autofocus: true,
              value: notChange,
              inactiveTrackColor:
                  data.type == 'income' ? Colors.red : Colors.blueAccent,
              activeColor:
                  data.type != 'income' ? Colors.red : Colors.blueAccent,
              onChanged: (bool value) {
                // FocusScope.of(context).unfocus();
                // This is called when the user toggles the switch.
                setState(() {
                  notChange = value;
                });
              },
            ),
            Text(data.type == 'income' ? 'รายรับ' : 'รายจ่าย')
          ],
        )),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (!notChange) {
                  json.type = data.type == 'income' ? 'expens' : 'income';
                }
                if (data.toJson().toString() != json.toJson().toString()) {
                  Provider.of<Stater>(context, listen: false)
                      .updateDataInDate(widget.date, json, widget.index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Update Data')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Not change')));
                }
                Navigator.of(context).pop();

                debugPrint(Provider.of<Stater>(context, listen: false)
                    .data
                    .toString());
              }),
        ]);
  }
}
