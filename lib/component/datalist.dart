import 'package:flutter/material.dart';
class Datalist extends StatelessWidget {
  final bool isAvailable;
  final List data;
  const Datalist({Key? key, required this.isAvailable, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: isAvailable
          ? Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                          "${data[index]["info"]}:${data[index]["amount"]}");
                    }),
              ),
            ])
          : const Center(
              child: Text("No data"),
            ),
    ));
  }
}
