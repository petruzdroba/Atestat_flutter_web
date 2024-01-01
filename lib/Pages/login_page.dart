import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:flutter_club_blaga/Widgets/medium_center_box.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 290),
            child: MediumCenterBox(
                title: 'Log In',
                alternate: "I don't have an account !",
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: inputUsername,
                          validator: MultiValidator([
                            MinLengthValidator(5, errorText: 'Required field'),
                          ]),
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary),
                          autocorrect: false,
                          decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: regular,
                                  color: Theme.of(context).colorScheme.outline),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 1)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: inputPassword,
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
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
