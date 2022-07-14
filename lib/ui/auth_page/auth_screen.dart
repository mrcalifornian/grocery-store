import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/models/http_exception.dart';
import 'package:grocery_store/providers/auth_provider.dart';
import 'package:grocery_store/ui/widgets/app_button.dart';
import 'package:provider/provider.dart';

enum AuthState {
  signUp,
  logIn,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  AuthState authMode = AuthState.logIn;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void showErrorDialog(message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("An error occurred"),
          content: Text(message),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ),
          ]),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      if (authMode == AuthState.logIn) {
        await Provider.of<AuthProvider>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed!';

      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = 'Email already exists!';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address!';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'User with this email not found!';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Wrong password!';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Your password is weak!';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate! Try again later.';
      showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        height: deviceSize.height,
        width: deviceSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authMode == AuthState.logIn ? 'Sign In' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      textInputAction: authMode == AuthState.logIn
                          ? TextInputAction.done
                          : TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                    if (authMode == AuthState.signUp)
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm password  ',
                          labelStyle: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        validator: authMode == AuthState.signUp
                            ? (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              }
                            : null,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? Container(
                alignment: Alignment.center,
                padding: const  EdgeInsets.symmetric(
                  vertical: 10,
                ),
                      child: const  CircularProgressIndicator(),
                    )
                  : AppButton(
                      name: authMode == AuthState.logIn ? 'Sign In' : 'Sign Up',
                      onTap: submit,
                      horPadding: 0,
                    ),
              const SizedBox(height: 20,),
              authMode == AuthState.logIn
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do not have an account?  ',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              authMode = AuthState.signUp;
                            });
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.mainGreen,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?  ',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              authMode = AuthState.logIn;
                            });
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.mainGreen,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
