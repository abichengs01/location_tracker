import 'package:data_base/config/app_const.dart';
import 'package:data_base/config/app_theme.dart';
import 'package:data_base/config/router.dart';
import 'package:data_base/features/home/screen/home_page.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'features/authentication/screens/authentication.dart';
import 'package:flutter_background/flutter_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
  FlutterBackground.initialize();
  final ItemService service = ItemService();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: AppString.appName,
    theme: AppTheme.lightTheme,
    onGenerateRoute: onGenerateRoute,
    home: SharedPrefs.getUserToken == null
        ? Authentication(service: service)
        : HomePage(service: service),
  ));
}
