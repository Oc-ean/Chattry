import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_messaging_app/provider/providers.dart';
import 'package:simple_messaging_app/screens/forgot_password_screen.dart';

import 'package:simple_messaging_app/screens/sign_up_screen.dart';

import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/text_input%20decoration.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TextEditingController signInEmailController = TextEditingController();
  // TextEditingController signInPasswordController = TextEditingController();
  // // String email = '';
  // // String password = '';
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  // AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFF8E7EC5),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Form(
                key: formKey,
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
                      'Log in now to share your thought!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Image.asset('assets/chatting.png'),
                    TextFormField(
                      controller: dataProvider.signInEmailController,
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
                      // onChanged: (val) {
                      //   setState(() {
                      //     email = val;
                      //     print('This email ===> $email');
                      //   });
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dataProvider.signInPasswordController,
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
                      // onChanged: (val) {
                      //   setState(() {
                      //     password = val;
                      //     print('This email ===> $password');
                      //   });
                      // },
                      validator: (val) {
                        if (val!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            nextScreen(context, const ForgotPasswordScreen());
                          },
                          child: const Text(
                            'Forgot password',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                      width: 340,
                      child: ElevatedButton(
                        onPressed: () {
                          dataProvider.signIn(
                            context,
                            formKey,
                          );
                          showSnackBar(
                              context, Colors.black, 'Sign in processing');
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
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Don't have an account?  ",
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                nextScreen(context, const SignUpScreen());
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

  // signIn() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .logInWithEmailAndPassword(signInEmailController.text.trim(),
  //             signInPasswordController.text.trim())
  //         .then((value) async {
  //       if (value == true) {
  //         /// saving the shared preferences state
  //         QuerySnapshot snapshot =
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .gettingUserData(signInEmailController.text.trim());
  //
  //         /// saving the value to shared preferences....
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSf(
  //             signInEmailController.text.trim());
  //         await HelperFunctions.saveUserNameSf(snapshot.docs[0]['fullName']);
  //         await showDialog(
  //             context: context,
  //             builder: (_) => AlertDialog(
  //                   title: const Text('Welcome Back!'),
  //                   content: const Text('Sign in successful'),
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
  //         // nextScreen(context, const HomeScreen());
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
