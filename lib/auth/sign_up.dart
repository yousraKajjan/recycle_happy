import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_happy_custom/auth/cubit/cubit.dart';
import 'package:recycle_happy_custom/auth/cubit/state.dart';
import 'package:recycle_happy_custom/constant/constants.dart';
import 'package:recycle_happy_custom/widgets/my_button_widget.dart';
import 'package:recycle_happy_custom/widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    print("Email -----------------------");
    print(args);
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          context.read<UserCubit>().emailController.text = (args as String);
          return Scaffold(
            // appBar: AppBar(
            //   title: const Text("إنشاء حساب "),
            // ),
            backgroundColor: backgroundColor,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/a220a26d2c05db92552aa9d4cbd79627.png'),
                    // image: Image.asset(
                    //     'assets/images/a220a26d2c05db92552aa9d4cbd79627.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: context.read<UserCubit>().form,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "إنشاء حساب",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Stack(
                              children: [
                                context.read<UserCubit>().image != null
                                    ? SizedBox(
                                        width: 130,
                                        height: 130,
                                        child: Image.memory(
                                          context.read<UserCubit>().image!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : CircleAvatar(
                                        // minRadius: 25,
                                        radius: 70,
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: const AssetImage(
                                            "assets/images/avatar.png"),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () async {},
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade400,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<UserCubit>()
                                                          .selectImage(context);
                                                    },
                                                    child: const Icon(
                                                      Icons.camera_alt_sharp,
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 130,
                          //   height: 130,
                          //   child: context.read<UserCubit>().profilePic == null
                          //       ? c
                          //       : CircleAvatar(
                          //           backgroundImage: FileImage(File(context
                          //               .read<UserCubit>()
                          //               .profilePic!
                          //               .path)),
                          //         ),
                          // ),
                          const SizedBox(height: 30),
                          TextFormFieldWidget(
                              suffixIcon: const Icon(Icons.email),
                              keyboardType: TextInputType.emailAddress,
                              yourController:
                                  context.read<UserCubit>().emailController,
                              hintText: 'أدخل بريدك الالكتروني',
                              validator: (value) {
                                //     return (!value.contains('@')) ? 'Use the @ char.' : null;
                              }),
                          const SizedBox(height: 20),
                          TextFormFieldWidget(
                              suffixIcon: const Icon(Icons.abc),
                              keyboardType: TextInputType.name,
                              yourController:
                                  context.read<UserCubit>().nameController,
                              hintText: ' أدخل  اسمك الكامل',
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'قصير جدا';
                                }
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(height: 0.3),
                            keyboardType: TextInputType.phone,
                            controller:
                                context.read<UserCubit>().numberPhoneController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.numbers),
                                hintText: 'أدخل رقمك'),
                            validator: (value) {
                              if (value!.length < 10) {
                                return 'قصير جدا ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormFieldWidget(
                              keyboardType: TextInputType.emailAddress,
                              obscureText:
                                  context.read<UserCubit>().obscureText,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    context.read<UserCubit>().obscureText =
                                        !context.read<UserCubit>().obscureText;
                                  });
                                },
                                icon: context.read<UserCubit>().obscureText
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              yourController:
                                  context.read<UserCubit>().passwordController,
                              hintText: 'أدخل كلمة السر ',
                              validator: (value) {
                                return (value.length < 2) ? 'قصير جدا ' : null;
                              }),
                          const SizedBox(height: 20),
                          state is SignUpLoading
                              ? const CircularProgressIndicator()
                              : ButtonWidget(
                                  side: const BorderSide(
                                    color: Colors.green,
                                  ),
                                  child: 'أنشئ الحساب',
                                  onPressed: () {
                                    context.read<UserCubit>().sinup(context);
                                  }),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "لديك حساب ؟ سجل دخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
