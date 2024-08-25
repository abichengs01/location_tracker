// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Data extends _Data with RealmEntity, RealmObjectBase, RealmObject {
  Data({
    String? lat,
    String? long,
    String? dateTime,
    int? id,
    String? userId,
  }) {
    RealmObjectBase.set(this, 'lat', lat);
    RealmObjectBase.set(this, 'long', long);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
  }

  Data._();

  @override
  String? get lat => RealmObjectBase.get<String>(this, 'lat') as String?;
  @override
  set lat(String? value) => RealmObjectBase.set(this, 'lat', value);

  @override
  String? get long => RealmObjectBase.get<String>(this, 'long') as String?;
  @override
  set long(String? value) => RealmObjectBase.set(this, 'long', value);

  @override
  String? get dateTime =>
      RealmObjectBase.get<String>(this, 'dateTime') as String?;
  @override
  set dateTime(String? value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  int? get id => RealmObjectBase.get<int>(this, 'id') as int?;
  @override
  set id(int? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  Stream<RealmObjectChanges<Data>> get changes =>
      RealmObjectBase.getChanges<Data>(this);

  @override
  Data freeze() => RealmObjectBase.freezeObject<Data>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Data._);
    return const SchemaObject(ObjectType.realmObject, Data, 'Data', [
      SchemaProperty('lat', RealmPropertyType.string, optional: true),
      SchemaProperty('long', RealmPropertyType.string, optional: true),
      SchemaProperty('dateTime', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.int, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
    ]);
  }
}

class UserData extends _UserData
    with RealmEntity, RealmObjectBase, RealmObject {
  UserData({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'password', password);
  }

  UserData._();

  @override
  String? get id => RealmObjectBase.get<String>(this, 'id') as String?;
  @override
  set id(String? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get password =>
      RealmObjectBase.get<String>(this, 'password') as String?;
  @override
  set password(String? value) => RealmObjectBase.set(this, 'password', value);

  @override
  Stream<RealmObjectChanges<UserData>> get changes =>
      RealmObjectBase.getChanges<UserData>(this);

  @override
  UserData freeze() => RealmObjectBase.freezeObject<UserData>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(UserData._);
    return const SchemaObject(ObjectType.realmObject, UserData, 'UserData', [
      SchemaProperty('id', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('password', RealmPropertyType.string, optional: true),
    ]);
  }
}
