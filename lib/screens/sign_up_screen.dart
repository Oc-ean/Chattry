import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/provider/providers.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/screens/sign_in_screen.dart';
import 'package:simple_messaging_app/service/authentication_service.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/text_input%20decoration.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  AuthService authService = AuthService();
  final formKey1 = GlobalKey<FormState>();
  // TextEditingController signUpEmailController = TextEditingController();
  // TextEditingController signUpPasswordController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();

  // String fullName = '';
  // String password = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF8E7EC5),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Form(
                key: formKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Chattry',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Create your account to chat and explore',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Image.asset(
                      'assets/group.png',
                      height: 300,
                    ),
                    TextFormField(
                      controller: dataProvider.fullNameController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Full name',
                        prefixIcon: const Icon(
                          Icons.person_rounded,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Name can not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dataProvider.signUpEmailController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                      ),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : 'Please enter a valid email';
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dataProvider.signUpPasswordController,
                      obscureText: _obscureText,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'password',
                        suffixIcon: _obscureText == true
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = false;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  size: 20,
                                ))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                ),
                              ),
                        prefixIcon: const Icon(
                          Icons.lock_rounded,
                        ),
                      ),
                      validator: (val) {
                        if (val!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          dataProvider.signUp(context, formKey1);
                          showSnackBar(
                              context, Colors.black, 'Processing data');
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: dataProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account?  ",
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                nextScreen(context, const SignInScreen());
                              },
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // signUp() async {
  //   if (formKey1.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .signUpWithEmailAndPassword(
  //             fullNameController.text.trim(),
  //             signUpEmailController.text.trim(),
  //             signUpPasswordController.text.trim())
  //         .then((value) async {
  //       if (value == true) {
  //         /// saving the shared preferences state
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSf(
  //             signUpEmailController.text.trim());
  //         await HelperFunctions.saveUserNameSf(fullNameController.text.trim());
  //         await showDialog(
  //             context: context,
  //             builder: (_) => AlertDialog(
  //                   title: const Text('Sign up succeeded'),
  //                   content: const Text(
  //                       'Your account was created, you can now log in'),
  //                   actions: [
  //                     TextButton(
  //                         onPressed: () {
  //                           nextScreen(
  //                             context,
  //                             const HomeScreen(),
  //                           );
  //                         },
  //                         child: const Text('Okay'))
  //                   ],
  //                 ));
  //       } else {
  //         showSnackBar(context, Colors.red, value);
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
}
