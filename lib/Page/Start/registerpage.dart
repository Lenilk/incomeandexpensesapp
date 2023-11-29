import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final usernameEditor = TextEditingController();
  final passwordEditor = TextEditingController();
  final secondpasswordEditor = TextEditingController();
  bool onNotSummit = true;
  bool haveError = false;
  bool userHaveBeenCreated = false;
  Future<bool> createUser(Map<String, dynamic> body) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    http.Response response = await http.post(
        Uri.parse('http://192.168.1.229:3000/createUser'),
        body: json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> resBody = jsonDecode(response.body);
      bool isSuccess = resBody['success'];
      if (isSuccess) {
        return true;
      } else {
        setState(() {
          userHaveBeenCreated = true;
        });
        return false;
      }
    } else {
      setState(() {
        haveError = true;
      });
      return false;
    }
  }

  @override
  void dispose() {
    usernameEditor.dispose();
    passwordEditor.dispose();
    secondpasswordEditor.dispose();
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
            'ลงชื่อเข้าใช้',
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
                      enabled: onNotSummit,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อผู้ใช้',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดใส่ชื่อผู้ใช้';
                        } else if (value.length < 6) {
                          return 'โปรดใส่ชื่อผู้ใช้มากกว่า 5 ตัว';
                        } else if (userHaveBeenCreated) {
                          return 'มีชื่อผู้ใช้อยู่แล้ว';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordEditor,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      enabled: onNotSummit,
                      decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดใส่รหัสผ่าน';
                        } else if (value.length < 5) {
                          return 'โปรดใส่รหัสผ่านมากกว่า 4 ตัว';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: secondpasswordEditor,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      enabled: onNotSummit,
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดใส่รหัสผ่าน';
                        } else if (value.length < 5) {
                          return 'โปรดใส่รหัสผ่านมากกว่า 4 ตัว';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text('มีบัญชีอยู่แล้ว'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text('เข้าสู่ระบบ!',
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
                            setState(() {
                              haveError = false;
                              userHaveBeenCreated = false;
                            });
                            FocusScope.of(context).unfocus();
                            String username = usernameEditor.value.text;
                            String password = passwordEditor.value.text;
                            String secondPassword =
                                secondpasswordEditor.value.text;
                            showDialog(
                              context: context,
                              builder: (_) => const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                            if (password != secondPassword) {
                              // Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text('รหัสไม่ตรงกัน'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('ตกลง'))
                                        ],
                                      ));
                            } else {
                              Map<String, dynamic> body = {
                                'username': username,
                                'password': password
                              };
                              setState(() {
                                onNotSummit = false;
                              });
                              createUser(body).then((isSuccess) {
                                Navigator.of(context).pop();
                                if (isSuccess) {
                                  Provider.of<User>(context, listen: false)
                                      .setUser(username);

                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(
                                                'ลงชื่อเข้าใช้สำเร็จ'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('ตกลง'))
                                            ],
                                          ));
                                  _form.currentState!.reset();
                                } else if (!isSuccess && haveError) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title:
                                                const Text('มีบางอย่าผิดพลาด'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      onNotSummit = true;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('ตกลง'))
                                            ],
                                          ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text(
                                                'มีชื่อผู้ใช้อยู่แล้ว'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      onNotSummit = true;
                                                    });
                                                  },
                                                  child: const Text('ตกลง'))
                                            ],
                                          ));
                                }
                              });
                            }
                          }
                        },
                        child: const Text('ลงชื่อเข้าใช้'))
                  ],
                )),
          ),
        ));
  }
}
