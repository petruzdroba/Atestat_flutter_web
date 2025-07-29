import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Class/user.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/medium_center_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../Widgets/Style/assets/fonts/weights.dart';
import '../Widgets/button_finish.dart';
import '../Widgets/text_hover_color.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({super.key, required this.user});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPfp = TextEditingController();

  bool noChanges = false;
  bool alreadyExists = false;
  bool notValidImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300, vertical: 250),
              child: Form(
                key: _formKey,
                child: MediumCenterBox(
                  title: 'Edit profile',
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                !noChanges
                                    ? 'Leave field empty if no change is needed'
                                    : 'Nothing changed!',
                                style: GoogleFonts.mukta(
                                  fontSize: 15,
                                  fontWeight: !noChanges ? regular : semiBold,
                                  color: !noChanges
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.red[400],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: inputName,
                              validator: (name) {
                                if (name!.isNotEmpty) {
                                  if (name.length < 5) {
                                    return 'Name too short';
                                  } else if (name.length > 30) {
                                    return 'Name too long';
                                  }
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: medium,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              autocorrect: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: InputDecoration(
                                hintText: 'New name',
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
                              controller: inputPfp,
                              validator: (image) {
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: medium,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              autocorrect: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: InputDecoration(
                                hintText: 'Profile picture link',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: regular,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                prefixIcon: Icon(
                                  Icons.link,
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
                              height: 40,
                            ),
                            ButtonFinish(
                              text: 'Save changes',
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (inputName.text.isEmpty &&
                                      inputPfp.text.isEmpty) {
                                    setState(() {
                                      noChanges = true;
                                    });
                                  } else {
                                    setState(() {
                                      noChanges = false;
                                    });
                                    String newName = inputName.text.isEmpty
                                        ? widget.user.name
                                        : inputName.text;
                                    String newPfp = inputPfp.text.isEmpty
                                        ? widget.user.pfp
                                        : inputPfp.text;

                                    Response response = await editUser(
                                        currentUsername.currentusername,
                                        newName,
                                        newPfp);
                                    if(response.statusCode == 200){
                                      setState(() {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(20)),
                                            content: Row(
                                              children: [
                                                Icon(Icons.check,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background),
                                                Text(
                                                  'Profile changes saved !',
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
                                        context.beamToNamed('/profile/${currentUsername.currentusername}',
                                            replaceRouteInformation: true);
                                      });
                                    }else{
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
                                                  'Something went wrong !',
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
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextHoverColor(
                              text: "Dismiss",
                              size: 19,
                              fromColor: Theme.of(context).colorScheme.outline,
                              toColor: Theme.of(context).colorScheme.primary,
                              function: () {
                                context.beamToNamed('/profile/${currentUsername.currentusername}',
                                    replaceRouteInformation: true);
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
          )),
    );
  }
}
