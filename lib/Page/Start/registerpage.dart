import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/function/user.dart';
import 'package:provider/provider.dart';

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
                      decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
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
                              Provider.of<User>(context, listen: false)
                                  .setUser(username);
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title:
                                            const Text('ลงชื่อเข้าใช้สำเร็จ'),
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
