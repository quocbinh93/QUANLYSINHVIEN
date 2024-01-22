import 'package:flutter/material.dart';
import 'package:flutter_login/custom/custom_button_submit.dart';
import 'package:flutter_login/custom/custom_form_input.dart';
import 'package:flutter_login/custom/custom_spiner.dart';
import 'package:flutter_login/custom/style.dart';
import 'package:flutter_login/providers/forgot_viewmodel.dart';
import 'package:flutter_login/screen/login_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageForgot extends StatefulWidget {
  const PageForgot({super.key});
  static const routername = "/forgot";

  @override
  State<PageForgot> createState() => _PageForgotState();
}

class _PageForgotState extends State<PageForgot> {
  final TextEditingController _emailController = TextEditingController();

  String emailError = '';

  bool isValidEmail = false;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/CV.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.6),
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: viewmodel.status == 3
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Color.fromARGB(
                                                255, 212, 121, 151)),
                                        child: const Image(
                                          image: AssetImage(
                                              'lib/assets/confirm_password.png'),
                                        ),
                                      ),
                                      const Text(
                                        'Successful',
                                        style: TextStyle(
                                            fontSize: 34,
                                            color: StyleGlobal.color,
                                            fontWeight: StyleGlobal.fontWeight),
                                      ),
                                      const Text(
                                        'Hệ thống đã xác nhận ! \nBạn kiểm tra Email để tiến hành đổi và đăng nhập lại.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: StyleGlobal.fontWeight),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 40,
                                        ),
                                        child: InkWell(
                                          onTap: () =>
                                              Navigator.popAndPushNamed(context,
                                                  PageLogin.routername),
                                          child: CusTom_ButtonSubmit(
                                            textButton: 'Login',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                            fontSize: 34,
                                            color: StyleGlobal.color,
                                            fontWeight: StyleGlobal.fontWeight),
                                      ),
                                      const Text(
                                        'Đồ ngu đồ ăn hại ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: StyleGlobal.fontWeight),
                                      ),
                                      const Text(
                                        ' Có cái mật khẩu cũng quên :)) ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: StyleGlobal.fontWeight,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 60,
                                        ),
                                        child: const Image(
                                          image: AssetImage(
                                            'lib/assets/forgot.png',
                                          ),
                                        ),
                                      ),
                                      CusTom_Form_Input(
                                        labelForm: 'Email khôi phục',
                                        textController: _emailController,
                                        textError: emailError,
                                        isValid: isValidEmail,
                                      ),
                                      viewmodel.status == 2
                                          ? Text(
                                              viewmodel.errorMessage,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            String email =
                                                _emailController.text.trim();
                                            final bool emailValid = RegExp(
                                                    r"^\b[A-Za-z0-9._%+-]+@gmail\.com\b")
                                                .hasMatch(email);
                                            if (email.isEmpty) {
                                              isValidEmail = true;
                                              emailError =
                                                  "Không được bỏ trống !";
                                            } else if (!emailValid) {
                                              isValidEmail = true;
                                              emailError =
                                                  "Email không hợp lệ !";
                                            } else {
                                              isValidEmail = false;
                                              viewmodel.forgot(email);
                                            }
                                          });
                                        },
                                        child: CusTom_ButtonSubmit(
                                          textButton: "Reset Password",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.popAndPushNamed(
                                            context, PageLogin.routername),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue.shade400,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            viewmodel.status == 1 ? const Spiner() : Container(),
          ],
        ),
      ),
    );
  }
}
