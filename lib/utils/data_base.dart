import 'package:data_base/schemas/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'package:flutter/material.dart';

class ItemService {
  late Realm _realm;
  final _config = Configuration.local([Data.schema, UserData.schema]);
  ItemService() {
    openRealm();
  }
  openRealm() {
    _realm = Realm(_config);
  }

  closeRealm() {
    if (!_realm.isClosed) {
      _realm.close();
    }
  }

  RealmResults<Data> getDatum() {
    return _realm.all<Data>();
  }

  RealmResults<UserData> getUsers() {
    return _realm.all<UserData>();
  }

  UserData queryData(query) {
    try {
      var queryData = _realm.all<UserData>().query(query).first;
      return queryData;
    } catch (e) {
      return UserData();
    }
  }

  RealmResults<Data> queryListData(query) {
    try {
      var queryData = _realm.all<Data>().query(query);
      return queryData;
    } catch (e) {
      return query;
    }
  }

  bool addUser(String name, String email, String id, String password) {
    try {
      _realm.write(() {
        _realm.add<UserData>(
            UserData(name: name, email: email, id: id, password: password));
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  bool addData(
      int id, String userId, String lat, String long, String dateTime) {
    try {
      _realm.write(() {
        _realm.add<Data>(Data(
            lat: lat, long: long, id: id, userId: userId, dateTime: dateTime));
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  bool deleteItem(Data item) {
    try {
      _realm.write(() {
        _realm.delete(item);
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }
}
