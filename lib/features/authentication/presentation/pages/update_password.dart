import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uhl_link/config/routes/routes_consts.dart';
import '../../../../widgets/screen_width_button.dart';
import '../bloc/user_bloc.dart';
import '../../../../widgets/form_field_widget.dart';

class UpdatePasswordPage extends StatefulWidget {
  final Map<String, dynamic> user;
  const UpdatePasswordPage({super.key, required this.user});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  String? errorPasswordValue;
  final GlobalKey<FormState> passwordKey = GlobalKey();

  String? errorConfirmPasswordValue;
  final GlobalKey<FormState> confirmPasswordKey = GlobalKey();

  @override
  void dispose() {
    passwordFocusNode.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordUpdating) {
        } else if (state is PasswordUpdatedSuccessfully) {
          GoRouter.of(context).goNamed(UhlLinkRoutesNames.test);
        } else if (state is PasswordUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
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
                  child: Text("Update your Password",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium),
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
                    }
                    return null;
                  },
                  onChanged: (String? value) {},
                  keyboardType: TextInputType.text,
                  errorText: errorPasswordValue,
                  prefixIcon: Icons.lock_outline_rounded,
                  showSuffixIcon: true,
                  hintText: "Password",
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                FormFieldWidget(
                  focusNode: confirmPasswordFocusNode,
                  fieldKey: confirmPasswordKey,
                  controller: confirmPasswordTextEditingController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password.";
                    } else if (passwordTextEditingController.text != value) {
                      return "Invalid Confirm Password.";
                    }
                    return null;
                  },
                  onChanged: (String? value) {},
                  keyboardType: TextInputType.text,
                  errorText: errorConfirmPasswordValue,
                  prefixIcon: Icons.lock_outline_rounded,
                  showSuffixIcon: true,
                  hintText: "Confirm Password",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '* ',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Theme.of(context).primaryColor)),
                  TextSpan(
                      text:
                          "This will be your new password and updating the password can be done via some logged in device only.",
                      style: Theme.of(context).textTheme.labelSmall)
                ])),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ScreenWidthButton(
                  text: "Update Password",
                  buttonFunc: () {
                    bool? isPasswordValid =
                        passwordKey.currentState?.validate();
                    bool? isConfirmPasswordValid =
                        confirmPasswordKey.currentState?.validate();

                    if (isConfirmPasswordValid! && isPasswordValid!) {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          PasswordUpdateEvent(
                              id: widget.user['id'],
                              newPassword: passwordTextEditingController.text));
                    }
                  },
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
