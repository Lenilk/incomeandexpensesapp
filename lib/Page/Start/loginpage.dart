import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final usernameEditor = TextEditingController();
  final passwordEditor = TextEditingController();
  Future<http.Response> login() async {
    return await http.get(Uri.parse('http://192.168.1.229:3000/users'));
  }

  @override
  void initState() {
    super.initState();
  }

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
                              Navigator.popAndPushNamed(context, 'register'),
                          child: const Text('ลงชื่อเข้าใช้!',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1,
                                  decorationColor: Colors.blue)),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _form.currentState!.reset();
                          }
                        },
                        child: const Text('เข้าสู้ระบบ'))
                  ],
                )),
          ),
        ));
  }
}
