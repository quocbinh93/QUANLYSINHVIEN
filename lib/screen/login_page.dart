import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_login/custom/custom_button_submit.dart";
import "package:flutter_login/custom/custom_form_input.dart";
import "package:flutter_login/custom/custom_spiner.dart";
import 'package:flutter_login/providers/login_viewmodel.dart';
import "package:flutter_login/screen/dashboard_page.dart";
import "package:flutter_login/screen/forgot_page.dart";
import 'package:flutter_login/screen/register_page.dart';
import "package:provider/provider.dart";

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});
  static const routername = "/login";
  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _usernameError = '';
  String _passwordError = '';
  bool _isValidUsername = false;
  bool _isValidPassword = false;

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    // ignore: non_constant_identifier_names
    // ignore: non_constant_identifier_names
    void ValidatorForm(context) {
      setState(() {
        String username = _usernameController.text.trim();
        String password = _passwordController.text.trim();

        if (username.isEmpty) {
          _isValidUsername = true;
          _usernameError = "Không được bỏ trống !";
        } else {
          _isValidUsername = false;
        }

        if (password.isEmpty) {
          _isValidPassword = true;
          _passwordError = "Không được bỏ trống !";
        } else {
          _isValidPassword = false;
        }

        if (username.isNotEmpty && password.isNotEmpty) {
          viewmodel.login(username, password);
        }
      });
    }

    if (viewmodel.status == 3) {
      viewmodel.status = 0;
      Future.delayed(Duration.zero, () {
        Navigator.popAndPushNamed(context, PageDashBoard.routername);
      });
    }
    // ignore: non_constant_identifier_names

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/CV.jpg'),
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  ' Welcome ',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(255, 189, 87, 192),
                                  ),
                                ),
                                const Text(
                                  'Login Page',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Image(
                                  width: 150,
                                  height: 150,
                                  image:
                                      AssetImage('lib/assets/logo_login.jpg'),
                                ),
                                CusTom_Form_Input(
                                    labelForm: 'Username',
                                    textController: _usernameController,
                                    textError: _usernameError,
                                    isValid: _isValidUsername),
                                const SizedBox(
                                  height: 20,
                                ),
                                CusTom_Form_Input(
                                  labelForm: 'Password',
                                  textController: _passwordController,
                                  textError: _passwordError,
                                  isValid: _isValidPassword,
                                  obs: true,
                                  isObs: true,
                                ),
                                viewmodel.status == 2
                                    ? Container(
                                        height: 20,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          viewmodel.errorMessage,
                                          style: TextStyle(
                                              color: Colors.red.shade700,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : const Text(''),
                                InkWell(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, PageForgot.routername);
                                  },
                                  child: const Text(
                                    'Forgot your password ?',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () => ValidatorForm(context),
                                  child: CusTom_ButtonSubmit(
                                    textButton: 'Login',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Don’t have an account ?',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' Register',
                                        style: TextStyle(
                                            color: Colors.blue.shade400,
                                            fontSize: 16),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              Navigator.popAndPushNamed(context,
                                                  PageRegister.routername),
                                      ),
                                    ],
                                  ),
                                ),
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
            viewmodel.status == 1 ? const Spiner() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
