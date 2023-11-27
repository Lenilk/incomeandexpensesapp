import 'package:flutter/material.dart';

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
  @override
  void dispose() {
    super.dispose();
    usernameEditor.dispose();
    passwordEditor.dispose();
    secondpasswordEditor.dispose();
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
                    TextFormField(
                      controller: secondpasswordEditor,
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
                              Navigator.popAndPushNamed(context, 'login'),
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
                            String username = usernameEditor.value.text;
                            String password = passwordEditor.value.text;
                            String secondPassword =
                                secondpasswordEditor.value.text;
                            if (password != secondPassword) {
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
                              _form.currentState!.reset();
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
