import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Service/product_service.dart';
import 'package:flutter_club_blaga/Service/user_service.dart';
import 'package:flutter_club_blaga/Widgets/image_display_list.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';

import '../Widgets/Style/assets/fonts/weights.dart';
import '../Widgets/button_finish.dart';
import '../Widgets/medium_center_box.dart';
import '../Widgets/text_hover_color.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _imgKey = GlobalKey<TagsState>();

  TextEditingController inputName = TextEditingController();
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputDescription = TextEditingController();

  final RegExp _doubleRegExp = RegExp(r'^[0-9]+([.][0-9]+)?$');
  List<String> images = [];
  bool productExists = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Theme
            .of(context)
            .colorScheme
            .onPrimary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 130),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: MediumCenterBox(
                  title: 'Sell',
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: TextFormField(
                                    controller: inputName,
                                    validator: (name){
                                      if(name!.isEmpty){
                                        return 'Required field';
                                      }
                                      else if(name.length < 5){
                                        return 'Name is too short';
                                      }else if(name.length > 30){
                                        return 'Name is too long';
                                      }else if(productExists == true){
                                        return 'Product with the same name exists already';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: medium,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      hintText: 'Name of product',
                                      hintStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: regular,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.drive_file_rename_outline_rounded,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          gapPadding: 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: inputPrice,
                                    validator: (price) {
                                      if (price!.isEmpty) {
                                        return 'Required field';
                                      } else if (!_doubleRegExp
                                          .hasMatch(price)) {
                                        return 'Please enter a valid price (ex. 3.32)';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: medium,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                    autocorrect: false,
                                    keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                    decoration: InputDecoration(
                                      hintText: 'Price (euro)',
                                      hintStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: regular,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.euro,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          gapPadding: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: inputDescription,
                              validator: MultiValidator([
                                MinLengthValidator(30,
                                    errorText: 'Make description longer'),
                              ]),
                              maxLength: 255,
                              maxLines: 7,
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: medium,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Add a description for your product',
                                hintStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: regular,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .outline,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  gapPadding: 1,
                                ),
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .outline,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    inputDescription.clear();
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color:
                                    Theme
                                        .of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Tags(
                              key: _imgKey,
                              textField: TagsTextField(
                                autofocus: false,
                                width: double.infinity,
                                hintText: 'Link to the images of your product',
                                hintTextColor:
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .outline,
                                inputDecoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: regular,
                                    color:
                                    Theme
                                        .of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    gapPadding: 1,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.link,
                                    color:
                                    Theme
                                        .of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 26,
                                  fontWeight: medium,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                ),
                                onSubmitted: (String str) {
                                  setState(() {
                                    if (!images.contains(str)) {
                                      images.add(str);
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                spacing: 8,
                                runSpacing: 8,
                                children: images.map((image) {
                                  return IntrinsicWidth(
                                      child: ImageDisplayList(
                                        link: image,
                                        function: () {
                                          setState(() {
                                            images.remove(image);
                                          });
                                        },
                                      ));
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ButtonFinish(
                              text: 'Sell your product',
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  Response response = await sellProduct(
                                      inputName.text,
                                      double.parse(inputPrice.text),
                                      images[0],
                                      inputDescription.text,
                                      currentUsername.currentusername,
                                      images);
                                  if (response.statusCode == 201) {
                                    setState(
                                          () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          content: Row(
                                            children: [
                                              Icon(Icons.check,
                                                  color: Theme
                                                      .of(context)
                                                      .colorScheme
                                                      .background),
                                              Text(
                                                'Check',
                                                style: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .colorScheme
                                                        .background,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ));

                                        final newProductId = int.parse(
                                            json.decode(response.body)['id']
                                                .toString());

                                        Response userResponse = await addProductToUser(
                                            newProductId,
                                            currentUsername.currentusername);
                                        if (userResponse.statusCode == 201) {
                                          setState(() {
                                            Beamer.of(context).beamToNamed(
                                                '/home',
                                                replaceRouteInformation: true);
                                            Beamer.of(context).beamToNamed(
                                                '/shop/product$newProductId');
                                          });
                                        }
                                      },
                                    );
                                  } else {
                                    setState(() {
                                      productExists = true;
                                      _formKey.currentState!.validate();
                                      productExists=false;
                                      inputName.clear();
                                    });
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextHoverColor(
                              text: "Cancel",
                              size: 19,
                              fromColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline,
                              toColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              function: () {
                                Beamer.of(context).beamToNamed('/home',
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
          ),
        ),
      ),
    );
  }
}
