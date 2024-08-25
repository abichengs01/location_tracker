import 'package:data_base/config/app_color.dart';
import 'package:data_base/config/app_layout.dart';
import 'package:data_base/config/app_style.dart';
import 'package:data_base/features/home/list_page/polyline/screen/Polyline_page.dart';
import 'package:data_base/schemas/data_model.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.service});
  final ItemService service;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String fromDate = "2000-01-01 00:00:00.00";
  String todate = "2200-01-01 00:00:00.00";
  // ignore: prefer_typing_uninitialized_variables
  var listData;
  @override
  void initState() {
    super.initState();
    setState(() {
      listData = loadItems();
    });
  }

  loadItems() {
    final userId = SharedPrefs.getUserToken;
    RealmResults<Data> data =
        ItemService().queryListData("userId == '$userId'");
    return data;
  }

  dateFormate(date) {
    String formattedDate =
        DateFormat('dd-MM-yyyy ').format(DateTime.parse(date));
    return formattedDate;
  }

  timeFormate(time) {
    String formattedTime = DateFormat('hh:mm a').format(DateTime.parse(time));
    return formattedTime;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, String fromTo) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        listData = "";
        fromTo == "from" ? fromDate = "$picked" : todate = "$picked";
        sortedListFun();
      });
    }
  }

  sortedListFun() {
    var temp = loadItems();
    List list = [];
    for (var i in temp) {
      if (DateTime.parse(i.dateTime).isBefore(DateTime.parse(todate)) &&
          DateTime.parse(i.dateTime).isAfter(DateTime.parse(fromDate))) {
        list.add(i);
      }
    }
    setState(() {
      listData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedMenu = "";
    return Scaffold(
      backgroundColor: AppColor.listBackground,
      appBar: AppBar(
        title: const Text("History"),
        actions: <Widget>[
          PopupMenuButton<String>(
            initialValue: selectedMenu,
            onSelected: (String item) {
              setState(() {
                switch (item) {
                  case "as":
                    _selectDate(context, "from");

                  case "de":
                    _selectDate(context, "to");

                  case "mv":
                    {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PolylinePage(
                              service: widget.service,
                              data: listData ?? loadItems());
                        },
                      ));
                    }
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "as",
                child: Text('↓ From Date'),
              ),
              const PopupMenuItem<String>(
                value: "de",
                child: Text('↑ To Date'),
              ),
              const PopupMenuItem<String>(
                value: "mv",
                child: Text('Map view'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8,
                        shadowColor: AppColor.black,
                        color: AppColor.backgroundGreen,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: true,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Latitude : ",
                                      style: AppStyle(context)
                                          .bodysmallBold
                                          .copyWith(
                                              color: AppColor.black,
                                              fontSize: 15)),
                                  TextSpan(
                                      text: "${listData[index].lat}",
                                      style: AppStyle(context)
                                          .bodysmall
                                          .copyWith(
                                              color: AppColor.black,
                                              fontSize: 15))
                                ]),
                              ),
                              const Text("&"),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Longitude : ",
                                      style: AppStyle(context)
                                          .bodysmallBold
                                          .copyWith(
                                              color: AppColor.black,
                                              fontSize: 15)),
                                  TextSpan(
                                      text: "${listData[index].long}",
                                      style: AppStyle(context)
                                          .bodysmall
                                          .copyWith(
                                              color: AppColor.black,
                                              fontSize: 15))
                                ]),
                              )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dateFormate("${listData[index].dateTime}")),
                              Text(timeFormate("${listData[index].dateTime}"))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              AppLayout.smallH
            ],
          ),
        ),
      ),
    );
  }
}
