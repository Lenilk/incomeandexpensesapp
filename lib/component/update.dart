import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incomeandexpensesapp/component/updatetype.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';
import '.././function/function.dart';

class UpdatePage extends StatefulWidget {
  final Note data;
  final int index;
  final String date;
  const UpdatePage(
      {Key? key, required this.data, required this.index, required this.date})
      : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
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
    Note data = widget.data;
    int index = widget.index;
    infoEditer.text = data.info;
    amountEditer.text = data.amount.toString();
    noteEditer.text = data.note;
    return AlertDialog(
      title: const Center(child: Text('แก้ไขข้อมูล')),
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: SizedBox(
        child: Column(
          children: [
            Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: infoEditer,
                      decoration: const InputDecoration(hintText: 'อะไร'),
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(hintText: 'กี่บาท'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: noteEditer,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'หมายเหตุ'),
                      maxLines: 3,
                    ),
                  ],
                )),
          ],
        ),
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
              FocusScope.of(context).unfocus();
              String info = infoEditer.value.text;
              int amount = int.parse(amountEditer.value.text);
              String note = noteEditer.value.text;
              String type = data.type;
              Note json = Note(info, amount, note, type);
              debugPrint('Update Page');
              debugPrint(json.toString());
              debugPrint(data.toString());
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (_) => UpdateTypePage(
                        data: data,
                        json: json,
                        index: index,
                        date: widget.date,
                        key: UniqueKey(),
                      ),
                  barrierDismissible: false);
            }

            debugPrint(
                Provider.of<Stater>(context, listen: false).data.toString());
          },
        ),
      ],
    );
  }
}
