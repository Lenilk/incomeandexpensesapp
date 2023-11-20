import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:provider/provider.dart';
import './function/function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:incomeandexpensesapp/Page/page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Stater()),
  ], child: const MyApp()));
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
      initialRoute: '/',
      routes: {
        '/': (context) => const MediaQuery(
              data: MediaQueryData(textScaleFactor: 1.0),
              child: MyHomePage(),
            ),
        '/dashboard': (context) => const MediaQuery(
              data: MediaQueryData(textScaleFactor: 1.0),
              child: DashBoardPage(),
            ),
      },
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
  List<Data> dataS = [];
  List<String> dateMark = [];
  Future getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('Data11');
    String? jsonStringDM = pref.getString('Date11Dm');
    List<Data> dataL = (jsonString != null)
        ? (json.decode(jsonString) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((e) => Data.fromJson(e))
            .toList()
        : [];
    List<dynamic> dataLDM =
        (jsonStringDM != null) ? json.decode(jsonStringDM)['datemark'] : [];
    debugPrint(dataL.toString());
    debugPrint(dataLDM.toString());
    if (dataL != []) {
      //type '_Map<String, dynamic>' is not a subtype of type 'Map<String, String>
      // ignore: unnecessary_cast
      debugPrint(dataL.toString());
      setState(() {
        dataS = dataL;
      });
    }
    if (dataLDM != []) {
      //type '_Map<String, dynamic>' is not a subtype of type 'Map<String, String>
      // ignore: unnecessary_cast
      List<String> data = dataLDM.map((e) => e as String).toList();
      debugPrint(data.toString());
      setState(() {
        dateMark = data;
      });
    }
    // pref.setString("Data1", json.encode([{"meaw":1234}]));
    // String? testS = pref.getString("Data1");
    // debugPrint(testS.toString());
    // debugPrint(json.decode(testS!)[0]["meaw"].toString());
  }

  @override
  void initState() {
    super.initState();
    getData().then((e) => Provider.of<Stater>(context, listen: false)
        .initSetData(dataS, dateMark));
  }

  @override
  Widget build(BuildContext context) {
    // if(onStart){
    // Provider.of<Stater>(context,listen: false).initSetData(dataS);
    // setState(() {
    //   onStart=false;
    // });
    // }

    return const MainPage();
  }
}
