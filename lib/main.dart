import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './function/function.dart';
import './function/extension.dart';
import 'component/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Stater()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MediaQuery(
        data: MediaQueryData(textScaleFactor: 1.0),
        child: MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool onStart =true;
   List<Map<String,dynamic>> dataS =[];
  void getData(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString("Data2");
    List<dynamic>dataL=(jsonString!=null)?json.decode(jsonString):[];
    debugPrint(dataL.toString());
    if(dataL!=[]){
      List<Map<String,dynamic>> data=dataL.map((e) => {"Date":e["Date"],"data":e["data"]}
      ).toList();
      debugPrint(data.toString());
      setState(() {
        dataS=data;
      });
      Provider.of<Stater>(context,listen:false).initSetData(dataS);
    }
    // pref.setString("Data1", json.encode([{"meaw":1234}]));
    // String? testS = pref.getString("Data1");
    // debugPrint(testS.toString());
    // debugPrint(json.decode(testS!)[0]["meaw"].toString());
  }

  @override
  void initState() {
    super.initState();
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    // if(onStart){
    // Provider.of<Stater>(context,listen: false).initSetData(dataS);
    // setState(() {
    //   onStart=false;
    // });
    // }
    List<Map<String, dynamic>> data = context.watch<Stater>().data;
    String selectDateINData =
        Provider.of<Stater>(context, listen: true).selectDateString();
    int whereday = whereDateInData(selectDateINData, context);
    bool isDayAvailable = isSelectDayAvailablefn(selectDateINData, context);
    List datalist = isDayAvailable ? data[whereday]["data"] : [];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            Provider.of<Stater>(context).selectDateTitle(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Column(children: [
        const Calender(),
        Datalist(
          data: datalist,
          isAvailable: isDayAvailable,
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ChoicePage(),
          );
          debugPrint(whereDateInData(selectDateINData, context).toString());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
