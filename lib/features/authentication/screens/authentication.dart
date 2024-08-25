import 'package:data_base/config/app_style.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../config/app_const.dart';
import '../../../config/app_layout.dart';
import '../../../config/app_routes.dart';
import '../../../utils/cus_textfield.dart';
import '../../../widgets/singlecolor_button.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key, required this.service});
  final ItemService service;

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String id = "0";
  String name = "";
  String userFound = "";
  var formKey = GlobalKey<FormState>();

  userDoesExist(String email, String pass) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _did = ItemService().queryData("email == '$email'");
    if (_did.id != null) {
      if (_did.password == pass) {
        setState(() {
          userFound = "ok";
          id = "${_did.id}";
          name = "${_did.name}";
        });
      } else {
        setState(() {
          userFound = "incorrect Password";
        });
      }
    } else {
      setState(() {
        userFound = "incorrect E-mail";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                15, 15, 15, MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppString.appName,
                      style: AppStyle(context).headingLargeBold.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 2,
                          color: AppColor.greenHeading),
                    ),
                  ),
                  AppLayout.spaceH10,
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/categories/location_image.png"))),
                  ),
                  AppLayout.spaceH30,
                  MyTextField(
                    value: (value) {
                      if (value == null || value!.trim().isEmpty) {
                        return 'Please enter the registered E-mail id';
                      }
                      return null;
                    },
                    control: email,
                    prefix: const Icon(Icons.person),
                    hint: "E-mail id",
                    inputkeybordtype: null,
                    length: null,
                    suffixIcon: null,
                    align: TextAlign.start,
                    vertAlign: TextAlignVertical.center,
                  ),
                  AppLayout.spaceH10,
                  MyTextField(
                    value: (value) {
                      if (value == null || value!.trim().isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    control: password,
                    prefix: const Icon(Icons.key),
                    obstext: true,
                    hint: "Password",
                    inputkeybordtype: null,
                    length: null,
                    suffixIcon: null,
                    align: TextAlign.start,
                    vertAlign: TextAlignVertical.center,
                  ),
                  AppLayout.spaceH30,
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      userFound,
                      style: const TextStyle(color: AppColor.redErrorText),
                    ),
                  ),
                  SingleColorButton(
                    width: MediaQuery.of(context).size.width,
                    text: "Log In",
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        userDoesExist(email.text, password.text);
                        if (userFound == "ok") {
                          await SharedPrefs().saveUserToken(id);
                          await SharedPrefs().saveUserName(name);
                          await SharedPrefs().saveUserEmail(email.text);
                          // ignore: use_build_context_synchronously
                          Navigator.popAndPushNamed(context, AppRoutes.home,
                              arguments: widget.service);
                        }
                      }
                    },
                  ),
                  const Padding(
                    padding: AppLayout.cardPadding,
                    child: Center(child: Text("or")),
                  ),
                  SingleColorButton(
                    width: MediaQuery.of(context).size.width,
                    text: "Create New Account",
                    function: () {
                      Navigator.pushNamed(context, AppRoutes.register,
                          arguments: widget.service);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
