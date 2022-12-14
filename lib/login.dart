import 'package:flutter/material.dart';
import 'package:flutter_application_home_work_final/keyboard.dart';
import 'package:flutter_application_home_work_final/register_page.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          labelText: "S??? ??i???n tho???i",
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
                            labelText: "M???t kh???u",
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
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             const RegisterPage()));
                                },
                                child: const Text(
                                  "????ng K??",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
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
                                    "????ng nh???p",
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
