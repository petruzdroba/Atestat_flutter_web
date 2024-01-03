import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:flutter_club_blaga/Widgets/button_finish.dart';
import 'package:flutter_club_blaga/Widgets/medium_center_box.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color.dart';
import 'package:http/http.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  bool showPassword = true;
  bool loggedIn = false;
  bool didHover = false;
  bool correctPass = true;
  bool userExists = true;

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
                title: 'Log In',
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 40),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: inputUsername,
                              validator: (username){
                                if(username!.isEmpty){
                                  return 'Required field';
                                }else if(userExists == false){
                                  return 'User not found';
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
                              validator: (password){
                                if(password!.isEmpty){
                                  return 'Required field';
                                }else if(correctPass == false){
                                  return 'Password is wrong';
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
                                hintText: 'Password',
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
                                          color:
                                              Theme.of(context).colorScheme.outline,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color:
                                              Theme.of(context).colorScheme.primary,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ButtonFinish(
                              text: 'Log In',
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  Response response = await logInUser(
                                      inputUsername.text, inputPassword.text);
                                  if (response.statusCode == 200){
                                    setState(() {
                                      currentUsername.currentusername = inputUsername.text;
                                      print( currentUsername.currentusername);
                                      Beamer.of(context)
                                          .beamToNamed('/home', replaceRouteInformation: true);
                                    });
                                  } else if(response.statusCode == 401) {
                                    setState(() {
                                      correctPass = false;
                                      _formKey.currentState!.validate();
                                      inputPassword.clear();
                                      correctPass = true;
                                    });
                                  }else{
                                    setState(() {
                                      userExists = false;
                                      _formKey.currentState!.validate();
                                      inputPassword.clear();
                                      inputUsername.clear();
                                      userExists = true;
                                    });
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextHoverColor(
                              text: "I don't have an account !",
                              size: 19,
                              fromColor: Theme.of(context).colorScheme.outline,
                              toColor: Theme.of(context).colorScheme.primary,
                              function: () {
                                context.beamToNamed('/signup');
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
