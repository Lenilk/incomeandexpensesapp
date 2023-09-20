import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '.././function/function.dart';

class AddPage extends StatefulWidget {
  final bool isincome;
  const AddPage({Key? key, required this.isincome}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final infoEditer = TextEditingController();
  final amountEditer = TextEditingController();
  final noteEditer = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  void dispose() {
    infoEditer.dispose();
    amountEditer.dispose();
    noteEditer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isincome = widget.isincome;
    int maxLine = 2;
    return AlertDialog(
      title: Center(child: Text(isincome ? "รายรับ" : "รายจ่าย")),
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: SizedBox(
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  controller: infoEditer,
                  decoration: const InputDecoration(hintText: "อะไร"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: amountEditer,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "กี่บาท"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: noteEditer,
                  decoration: const InputDecoration(hintText: "หมายเหตุ"),
                  maxLines: 3,
                ),
              ],
            )),
      ),
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
            if (_form.currentState!.validate()) {
              String info = infoEditer.value.text;
              String amount = amountEditer.value.text;
              String? note =
                  noteEditer.value.text.isEmpty ? null : noteEditer.value.text;
              Map<String, String> json = {
                "info": info,
                "amount": amount,
                "note": note ?? "",
                "type": isincome ? "income" : "expaens",
              };
              String date = Provider.of<Stater>(context, listen: false)
                  .selectDateString();
              if (!Provider.of<Stater>(context, listen: false)
                  .data
                  .where((element) => element["Date"] == date)
                  .isNotEmpty) {
                Provider.of<Stater>(context, listen: false)
                    .addDateAndData(date, json);
              } else {
                Provider.of<Stater>(context, listen: false)
                    .addDataInDate(date, json);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              Navigator.of(context).pop();
            }

            debugPrint(
                Provider.of<Stater>(context, listen: false).data.toString());
          },
        ),
      ],
    );
  }
}
