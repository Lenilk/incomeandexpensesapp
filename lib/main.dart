import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:provider/provider.dart';
import 'function/stater.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:incomeandexpensesapp/Page/page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Stater()),
    ChangeNotifierProvider(create: (_) => User()),
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
        '/': (context) => const MyHomePage(),
        '/dashboard': (context) => const DashBoardPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage()
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
  String user = '';
  Future<List<Map<String, dynamic>>> fetchData(String owner) async {
    Map<String, String> header = {'Content-type': 'application/json'};
    http.Response response = await http.post(
        Uri.parse('http://192.168.1.229:3000/login'),
        headers: header,
        body: {'username': owner});
    if (response.statusCode == 200) {
      Map<String, dynamic> resBody = json.decode(response.body);
      return resBody['data'];
    } else {
      return [];
    }
  }

  Future getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('Data11');
    String? jsonStringDM = pref.getString('Date11Dm');
    String? userSP = pref.getString('user');
    if (userSP != '' && userSP != null) {
      user = userSP;
    }
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
    getData().then((e) {
      Provider.of<Stater>(context, listen: false).initSetData(dataS, dateMark);
      Provider.of<User>(context, listen: false).setUser(user);
    });
    if (user != '') {
      fetchData(user).then((data) {
        List<Map<String, dynamic>> dataInPr =
            Provider.of<Stater>(context, listen: false)
                .data
                .map((Data e) => e.toJson())
                .toList();
                if(data!=dataInPr){
                  //first must create provider for manage data in offline 
                  //check if change in offline mode and update data to internet else nothing to do 
                }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    return (context.watch<User>().username != '')
        ? const MainPage()
        : const LoginPage();
  }
}
