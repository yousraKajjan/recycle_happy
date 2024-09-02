import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_happy_custom/auth/sign_up.dart';
import 'package:recycle_happy_custom/widgets/my_button_widget.dart';
import 'package:recycle_happy_custom/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailValue = "";
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      // AssetImage('assets/images/photo_٢٠٢٤-٠٤-١٩_١١-٠٦-٤١.jpg'),
                      AssetImage(
                          'assets/images/f8045c0a2a4adf89789da725659ee17d.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            color: const Color.fromARGB(68, 211, 211, 211).withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: form,
              autovalidateMode: AutovalidateMode.always,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Row(
                        children: [
                          Text(
                            "تسجيل الدخول ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextFormFieldWidget(
                          suffixIcon: const Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          yourController: emailController,
                          hintText: 'أدخل بريدك الالكتروني',
                          onChanged: (value) {
                            emailValue = value;
                          },
                          validator: (value) {
                            return (!value.contains('@')) ? 'استخدم @.' : null;
                          }),
                      const SizedBox(height: 20),
                      TextFormFieldWidget(
                          keyboardType: TextInputType.visiblePassword,
                          yourController: passwordController,
                          hintText: 'أدخل كلمة السر',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  obscureText = !obscureText;
                                },
                              );
                            },
                            icon: obscureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          onChanged: (value) {
                            print(value);
                          },
                          obscureText: obscureText,
                          validator: (value) {
                            return (value.length < 2) ? 'قصير جدا ' : null;
                          }),
                      ButtonWidget(
                          side: const BorderSide(
                            color: Colors.green,
                          ),
                          child: 'تسجيل الدخول ',
                          colorText: Colors.green,
                          onPressed: () async {
                            try {
                              if (form.currentState?.validate() ?? false) {
                                // sent emailValue to server
                                String email = emailController.text;
                                String password = passwordController.text;
                                UserCredential result = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                print(result);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", ModalRoute.withName('/'));
                              }
                            } catch (e) {
                              if (e is FirebaseException) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message ?? "")));
                              }
                            }
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            ///1
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                settings: RouteSettings(
                                    arguments: emailController.text),
                                builder: (context) {
                                  return const SignUpScreen();
                                },
                              ),
                            );
                            print("result -----------------");
                            print(result);
                          },
                          child: const Text(
                            "لا تمتلك حساب ؟؟  أنشئ حساب جديد ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
