import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/medium_center_box.dart';
import 'package:http/http.dart';

import '../Class/MenuOption.dart';
import '../Widgets/Style/assets/fonts/weights.dart';
import '../Widgets/button_finish.dart';
import '../Widgets/text_hover_color.dart';

class DeleteCurrentUser extends StatefulWidget {
  const DeleteCurrentUser({super.key});

  @override
  State<DeleteCurrentUser> createState() => _DeleteCurrentUserState();
}

class _DeleteCurrentUserState extends State<DeleteCurrentUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController inputPassword = TextEditingController();
  bool showPassword = true;
  bool checkBoxValue = false;
  bool checkedBox = false;
  bool correctPass = true;

  int attempts = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 450, vertical: 290),
            child: MediumCenterBox(
              title: 'Delete your account ?',
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: inputPassword,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'Required field';
                              } else if (correctPass == false) {
                                return 'Password is wrong ${4-attempts}/3';
                              }
                              return null;
                            },
                            obscureText: showPassword,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: medium,
                                color: Theme.of(context).colorScheme.primary),
                            autocorrect: false,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              hintText: 'Retype your password',
                              hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: regular,
                                  color: Theme.of(context).colorScheme.outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              prefixIcon: Icon(
                                Icons.password_outlined,
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkBoxValue,
                                onChanged: (value) {
                                  setState(() {
                                    checkBoxValue = value!;
                                  });
                                },
                                activeColor:
                                    Theme.of(context).colorScheme.outline,
                                checkColor:
                                    Theme.of(context).colorScheme.background,
                              ),
                              Text(
                                "I'm sure I want to delete my ${currentUsername.currentusername} account",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Visibility(
                                  visible: checkedBox,
                                  child: Text(
                                    '     Please fill out all required fields',
                                    style: TextStyle(
                                      color: Colors.red.shade300,
                                      fontSize: 12,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonFinish(
                            text: 'Delete',
                            function: () async {
                              if (attempts >= 1) {
                                if (checkBoxValue) {
                                  setState(() {
                                    checkedBox = false;
                                  });
                                } else {
                                  setState(() {
                                    checkedBox = true;
                                  });
                                }
                                if (_formKey.currentState!.validate() &&
                                    checkBoxValue) {
                                  Response response = await deleteUser(
                                      currentUsername.currentusername,
                                      inputPassword.text);
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          content:  Row(
                                            children: [
                                              const Icon(Icons.delete_forever,
                                                  color: Colors.black),
                                              Text(
                                                'User ${currentUsername.currentusername} deleted !',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      currentUsername.currentusername = '-1';
                                      menuReset();
                                      Beamer.of(context).beamToNamed('/home',
                                          replaceRouteInformation: true);
                                    });
                                  } else if (response.statusCode == 401) {
                                    setState(() {
                                      correctPass = false;
                                      _formKey.currentState!.validate();
                                      inputPassword.clear();
                                      correctPass = true;
                                      attempts--;
                                    });
                                  } else {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          content: Row(
                                            children: [
                                              Icon(Icons.error,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                              Text(
                                                'Impossible action',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                }
                              } else {
                                currentUsername.currentusername = '-1';
                                menuReset();
                                Beamer.of(context).beamToNamed('/home',
                                    replaceRouteInformation: true);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextHoverColor(
                            text: "Changed my mind !",
                            size: 19,
                            fromColor: Theme.of(context).colorScheme.outline,
                            toColor: Theme.of(context).colorScheme.primary,
                            function: () {
                              Beamer.of(context).beamToNamed('/home',
                                  replaceRouteInformation: true);
                            },
                          ),
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
