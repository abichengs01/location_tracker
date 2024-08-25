import 'package:realm/realm.dart';
part 'data_model.g.dart';

@RealmModel()
class _Data {
  String? lat;
  String? long;
  String? dateTime;
  int? id;
  String? userId;
}

@RealmModel()
class _UserData {
  String? id;
  String? name;
  String? email;
  String? password;
}
