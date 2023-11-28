import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final _form = GlobalKey<FormState>();
  final usernameEditor = TextEditingController();
  final passwordEditor = TextEditingController();
  Future<http.Response> login() async {
    return await http.get(Uri.parse('http://192.168.1.229:3000/users'));
  }

  Map<String, dynamic> user = {'username': 'Meaw', 'password': '1234'};

  @override
  void dispose() {
    usernameEditor.dispose();
    passwordEditor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text(
            'เช้าสู่ระบบ',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameEditor,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดใส่ชื่อผู้ใช้';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordEditor,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดใส่รหัสผ่าน';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text('ไม่มีบัญชี'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/register'),
                          child: const Text('ลงชื่อเข้าใช้!',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1,
                                  decorationColor: Colors.blue)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            String username = usernameEditor.value.text;
                            String password = passwordEditor.value.text;
                            debugPrint(username);
                            debugPrint(password);
                            debugPrint(user['username']);
                            debugPrint(user['password']);
                            showDialog(
                              context: context,
                              builder: (_) => const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                            if (username == user['username'] &&
                                password == user['password']) {
                              Provider.of<User>(context, listen: false)
                                  .setUser(username);
                              _form.currentState!.reset();
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text(
                                            'ชื่อผู้ใช้หรือรหัสไม่ถูกต้อง'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('ตกลง'))
                                        ],
                                      ));
                            }
                          }
                        },
                        child: const Text('เข้าสู้ระบบ'))
                  ],
                )),
          ),
        ));
  }
}
