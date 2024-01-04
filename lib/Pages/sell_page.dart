import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/image_display_list.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Widgets/Style/assets/fonts/weights.dart';
import '../Widgets/medium_center_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.onPrimary,
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
                                    validator: MultiValidator([
                                      MinLengthValidator(5,
                                          errorText: 'Name too short'),
                                      MaxLengthValidator(30,
                                          errorText: 'Name too long')
                                    ]),
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: medium,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      hintText: 'Name of product',
                                      hintStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: regular,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.drive_file_rename_outline_rounded,
                                        color: Theme.of(context)
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
                                          Theme.of(context).colorScheme.primary,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.euro,
                                        color: Theme.of(context)
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
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Add a description for your product',
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
                                  Icons.description,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    inputDescription.clear();
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color:
                                        Theme.of(context).colorScheme.outline,
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
                                    Theme.of(context).colorScheme.outline,
                                inputDecoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: regular,
                                    color:
                                        Theme.of(context).colorScheme.outline,
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
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 26,
                                  fontWeight: medium,
                                  color: Theme.of(context).colorScheme.primary,
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
