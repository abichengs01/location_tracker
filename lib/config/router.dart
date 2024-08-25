import 'package:data_base/config/app_routes.dart';
import 'package:data_base/features/authentication/screens/authentication.dart';
import 'package:data_base/features/home/list_page/screen/list_page.dart';
import 'package:data_base/features/home/screen/home_page.dart';
import 'package:data_base/features/authentication/screens/register/screen/register_page.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments;
  switch (routeSettings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (context) => HomePage(service: args as ItemService),
      );
    case AppRoutes.register:
      return MaterialPageRoute(
        builder: (context) => Registerpage(service: args as ItemService),
      );
    case AppRoutes.authentication:
      return MaterialPageRoute(
        builder: (context) => Authentication(service: args as ItemService),
      );
    case AppRoutes.listPage:
      return MaterialPageRoute(
        builder: (context) => ListPage(service: args as ItemService),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const ErrorRoute(),
      );
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No Page Found'),
      ),
    );
  }
}
