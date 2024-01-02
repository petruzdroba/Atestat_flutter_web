import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/medium_center_box.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';

import '../Widgets/Style/assets/fonts/weights.dart';
import '../Widgets/button_finish.dart';
import '../Widgets/text_hover_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController inputName = TextEditingController();
  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputRePassword = TextEditingController();

  bool showPassword = true;
  bool showRePassword = true;
  bool alreadyExists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 450, vertical: 180),
            child: MediumCenterBox(
              title: 'Sign Up',
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 40, bottom: 20),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: inputName,
                            validator: MultiValidator([
                              MinLengthValidator(5,
                                  errorText: 'Name too short'),
                              MaxLengthValidator(30, errorText: 'Name too long')
                            ]),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: regular,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              prefixIcon: Icon(
                                Icons.supervised_user_circle,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 1),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: inputUsername,
                            validator: (usernameInput) {
                              if (usernameInput!.isEmpty) {
                                return 'Required field';
                              } else if (usernameInput.contains(' ')) {
                                return 'Username cannot contain spaces';
                              } else if (usernameInput.length < 6) {
                                return 'Username too short';
                              } else if (usernameInput.length > 20) {
                                return 'Username too long';
                              } else if(alreadyExists == true){
                                return 'Username already exists';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: regular,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                gapPadding: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: inputPassword,
                            obscureText: showPassword,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'Required field';
                              } else if (password.length < 8) {
                                return 'Password too short';
                              } else if (password.length > 20) {
                                return 'Password too long';
                              } else if (!password.contains(RegExp(r'[A-Z]'))) {
                                return 'Password must have a capital letter';
                              } else if (!password.contains(RegExp(r'[0-9]'))) {
                                return 'Password must contain a number';
                              } else if (!password.contains(RegExp(r'[a-z]'))) {
                                return 'Password must contain a lowercase letter';
                              } //password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            autocorrect: false,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: regular,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                gapPadding: 1,
                              ),
                              prefixIcon: Icon(
                                Icons.type_specimen,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: showPassword
                                    ? Icon(
                                        Icons.visibility,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: inputRePassword,
                            obscureText: showRePassword,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'Required field';
                              } else if (password != inputPassword.text) {
                                return 'Passwords do no match';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            autocorrect: false,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              hintText: 'Retype password',
                              hintStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: regular,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                gapPadding: 1,
                              ),
                              prefixIcon: Icon(
                                Icons.type_specimen_outlined,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showRePassword = !showRePassword;
                                  });
                                },
                                icon: showRePassword
                                    ? Icon(
                                        Icons.visibility,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      )
                                    : Icon(Icons.visibility_off,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonFinish(
                            text: 'Create account',
                            function: () async {
                              if (_formKey.currentState!.validate()) {
                                Response response = await signUpUser(inputName.text, inputUsername.text, inputPassword.text);
                                if (response.statusCode == 201) {
                                  setState(() {
                                    alreadyExists = false;
                                  });
                                } else {
                                  setState(() {
                                    alreadyExists = true;
                                    _formKey.currentState!.validate();
                                    inputUsername.clear();
                                  });
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextHoverColor(
                            text: "I already have an account !",
                            size: 19,
                            fromColor: Theme.of(context).colorScheme.outline,
                            toColor: Theme.of(context).colorScheme.primary,
                            function: () {
                              context.beamToNamed('/login');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
