import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'keyboard.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool canInput = true;
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => hideKeyboardAndUnFocus(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Positioned(
                  bottom: 10,
                  child: Text.rich(
                      TextSpan(text: 'Hotline : ', children: <InlineSpan>[
                    TextSpan(
                      text: '18001186',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w400),
                    )
                  ])),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("login.svg"),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          labelText: "Họ & Tên",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          labelText: "Số điện thoại",
                          errorText: canInput ? null : "Enter Number Only !",
                        ),
                        onSubmitted: (value) => {debugPrint(value)},
                        onChanged: (String value) {
                          final v = int.tryParse(value);
                          if (v == null) {
                            setState(() {
                              canInput = false;
                            });
                          } else {
                            setState(() {
                              canInput = true;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            labelText: "Mật khẩu",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_rounded),
                              color: showPassword ? Colors.blue : Colors.black,
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(
                              height: 48,
                              child: Text(""),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal.shade600),
                                  onPressed: () {},
                                  child: const Text(
                                    "Đăng Ký",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
