import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/screen_width_button.dart';
import '../bloc/user_bloc.dart';
import '../../../../widgets/form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  String? errorEmailValue;
  final GlobalKey<FormState> emailKey = GlobalKey();

  String? errorPasswordValue;
  final GlobalKey<FormState> passwordKey = GlobalKey();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;

  bool userLoading = false;

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // if (state is UserLoading) {
        //   userLoading = true;
        // } else if (state is UserLoaded) {
        //   userLoading = false;
        //   GoRouter.of(context)
        //       .goNamed(CascaRoutesNames.dashboard, pathParameters: {'user': jsonEncode(state.user.toJson())});
        // } else if (state is UserError) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message)),
        //   );
        // }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset("assets/images/logo.png"),
                Text("Uhl Link", style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text("Login to your Account",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                FormFieldWidget(
                  focusNode: emailFocusNode,
                  fieldKey: emailKey,
                  controller: emailTextEditingController,
                  obscureText: false,
                  validator: (value) {
                    final bool emailPatternValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (!emailPatternValid) {
                      return "Please enter a valid email address.";
                    } else if (!_isEmailValid) {
                      return "Invalid email address.";
                    }
                    return null;
                  },
                  onChanged: (String? value) async {
                    // final List<User> users = await UhlUsersDB.(
                    //     emailTextEditingController.text);
                    // if (users.length == 1) {
                    //   _isEmailValid = true;
                    // }
                  },
                  keyboardType: TextInputType.emailAddress,
                  errorText: errorEmailValue,
                  prefixIcon: Icons.mail_rounded,
                  showSuffixIcon: false,
                  hintText: "Email",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                FormFieldWidget(
                  focusNode: passwordFocusNode,
                  fieldKey: passwordKey,
                  controller: passwordTextEditingController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password.";
                    } else if (!_isPasswordValid) {
                      return "Password or Email is incorrect.";
                    }
                    return null;
                  },
                  onChanged: (String? value) async {
                    // final List<User> users =
                    //     await CascaUsersDB.getUserByEmail(
                    //         emailTextEditingController.text);
                    // if (users.length == 1) {
                    //   if (users.first.password == value) {
                    _isPasswordValid = true;
                    //   }
                    // }
                  },
                  keyboardType: TextInputType.text,
                  errorText: errorPasswordValue,
                  prefixIcon: Icons.lock_outline_rounded,
                  showSuffixIcon: true,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                ScreenWidthButton(
                  text: "Sign in",
                  buttonFunc: () {
                    // final bool isValidEmail = emailKey.currentState!.validate();
                    // final bool isValidPassword =
                    //     passwordKey.currentState!.validate();
                    // if (isValidEmail && isValidPassword) {
                    //   BlocProvider.of<AuthenticationBloc>(context).add(
                    //       LoginEvent(
                    //           email: emailTextEditingController.text,
                    //           password: passwordTextEditingController.text,
                    //           rememberMeCheckbox: loginPasswordRememberMe));
                    // }
                  },
                  isLoading: userLoading,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom * 0.5)),
              ]),
        ),
      ),
    );
  }
}
