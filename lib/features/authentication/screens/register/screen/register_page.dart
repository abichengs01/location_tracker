import 'package:data_base/config/app_const.dart';
import 'package:data_base/schemas/data_model.dart';
import 'package:data_base/utils/cus_textfield.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import '../../../../../config/app_color.dart';
import '../../../../../config/app_layout.dart';
import '../../../../../config/app_style.dart';
import '../../../../../widgets/singlecolor_button.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key, required this.service});
  final ItemService service;
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool cPasswordVisible = false;
  bool sameText = true;
  bool alreadyExist = false;
  TextEditingController name = TextEditingController();
  TextEditingController emailMobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  late RealmResults<UserData> userDatum;

  onAdd(String name, String emailMobile, String id, String password) {
    debugPrint('Adding $name');
    if (widget.service.addUser(name, emailMobile, id, password)) {
      debugPrint('Added $name');
      loadItems();
    } else {
      debugPrint('Something went wrong while adding $name');
    }
  }

  alreadyExistFun() {
    var didUser = ItemService().queryData("email == '${emailMobile.text}'");
    if (didUser.email != null) {
      setState(() {
        alreadyExist = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() {
    setState(() {
      userDatum = widget.service.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: AppLayout.screenPadding,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Create new account",
                      style: AppStyle(context).headingLargeBold.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          letterSpacing: 2,
                          color: AppColor.greenHeading),
                    ),
                  ),
                  AppLayout.spaceH20,
                  const Text("Name"),
                  AppLayout.spaceH10,
                  MyTextField(
                    control: name,
                    value: (value) {
                      if (value == null || value!.trim().isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                    hint: "Name",
                    inputkeybordtype: null,
                    length: null,
                    suffixIcon: null,
                    align: TextAlign.start,
                    vertAlign: TextAlignVertical.center,
                  ),
                  AppLayout.spaceH10,
                  const Text("E-mail Id"),
                  AppLayout.spaceH10,
                  MyTextField(
                      control: emailMobile,
                      value: (value) {
                        if (value == null ||
                            value!.trim().isEmpty ||
                            value == null ||
                            value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter valid E-mail Id';
                        }
                        return null;
                      },
                      hint: "E-mail Id",
                      inputkeybordtype: null,
                      onChanged: (p0) {
                        alreadyExist = false;
                      },
                      length: null,
                      suffixIcon: null,
                      align: TextAlign.start,
                      vertAlign: TextAlignVertical.center),
                  AppLayout.spaceH10,
                  const Text("Password"),
                  AppLayout.spaceH10,
                  MyTextField(
                      control: password,
                      value: (value) {
                        if (value == null || value!.trim().isEmpty) {
                          return 'Please enter the password';
                        }
                        return null;
                      },
                      obstext: !passwordVisible,
                      hint: "Enter Password",
                      inputkeybordtype: null,
                      length: null,
                      onChanged: (p0) {
                        sameText = true;
                      },
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: passwordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      align: TextAlign.start,
                      vertAlign: TextAlignVertical.center),
                  AppLayout.spaceH10,
                  const Text("Confirm password"),
                  AppLayout.spaceH10,
                  MyTextField(
                      control: cPassword,
                      value: (value) {
                        if (value == null || value!.trim().isEmpty) {
                          return "Passsword doesn't match ";
                        }
                        return null;
                      },
                      obstext: !cPasswordVisible,
                      hint: "Enter password again",
                      inputkeybordtype: null,
                      length: null,
                      onChanged: (p0) {
                        sameText = true;
                      },
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              cPasswordVisible = !cPasswordVisible;
                            });
                          },
                          icon: cPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      align: TextAlign.start,
                      vertAlign: TextAlignVertical.center),
                  AppLayout.spaceH30,
                  !sameText
                      ? const Text(
                          "Password doen't match",
                          style: TextStyle(color: AppColor.redErrorText),
                        )
                      : Container(),
                  alreadyExist
                      ? const Text(
                          "E-mail address already exist",
                          style: TextStyle(color: AppColor.redErrorText),
                        )
                      : Container(),
                  SingleColorButton(
                    width: MediaQuery.of(context).size.width,
                    text: "Create",
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (password.text == cPassword.text) {
                          alreadyExistFun();
                          if (alreadyExist == false) {
                            var count = SharedPrefs.getUserCount;
                            int incre = count == null ? 0 : count + 1;
                            await SharedPrefs().saveCount(incre);

                            await onAdd(name.text, emailMobile.text, "$incre",
                                password.text);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              alreadyExist = true;
                            });
                          }
                        } else {
                          setState(() {
                            sameText = false;
                          });
                        }
                      }
                    },
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Already have an account?")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
