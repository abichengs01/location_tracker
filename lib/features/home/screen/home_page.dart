import 'package:data_base/config/app_color.dart';
import 'package:data_base/config/app_const.dart';
import 'package:data_base/config/app_layout.dart';
import 'package:data_base/config/app_routes.dart';
import 'package:data_base/config/app_style.dart';
import 'package:data_base/features/home/widget/map_view.dart';
import 'package:data_base/features/widget/alert_box.dart';
import 'package:data_base/schemas/data_model.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.service});
  final ItemService service;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RealmResults<UserData> items;
  String name = "${SharedPrefs.getUserName}";
  String email = "${SharedPrefs.getEmail}";

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() {
    setState(() {
      items = widget.service.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColor.backgroundGreen,
        child: Column(
          children: [
            AppLayout.spaceH50,
            AppLayout.spaceH20,
            CircleAvatar(
              backgroundColor: AppColor.avatarColor,
              radius: 50,
              child: Text(
                name[0].toUpperCase(),
                style: AppStyle(context)
                    .headingLargeBold
                    .copyWith(color: AppColor.white, fontSize: 40),
              ),
            ),
            AppLayout.spaceH10,
            Text(name.toUpperCase(),
                style: AppStyle(context)
                    .headingMediumBold
                    .copyWith(fontSize: 25, color: AppColor.black)),
            AppLayout.spaceH10,
            Text(email),
            AppLayout.spaceH10,
            const Divider(),
            const Spacer(),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.listPage,
                    arguments: widget.service);
              },
              title: const Text("Location history"),
              trailing: const Icon(Icons.history),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertBox(
                      title: "Logout",
                      subTitle: "Are you sure that you want to logout?",
                      noFun: () {
                        Navigator.pop(context);
                      },
                      yesFun: () {
                        Navigator.pop(context);
                        SharedPrefs().removeUserNameToken();
                        Navigator.popAndPushNamed(
                            context, AppRoutes.authentication,
                            arguments: widget.service);
                      },
                    );
                  },
                );
              },
              title: const Text("log out"),
              trailing: const Icon(Icons.logout_outlined),
            ),
            AppLayout.spaceH15
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
        child: AppBar(
          title: const Text(AppString.appName),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: AppColor.backgroundGreen,
              radius: 15,
              child: Text(
                name[0].toUpperCase(),
                style: AppStyle(context).headingLargeBold.copyWith(
                      color: AppColor.greenHeading,
                    ),
              ),
            ),
            AppLayout.spaceW10
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.915,
          child: Stack(
            children: [
              MapView(service: widget.service),
            ],
          ),
        ),
      ),
    );
  }
}
