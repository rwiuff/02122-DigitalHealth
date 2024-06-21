// src/data_endpoint.dart
part of '../main.dart';

//EXAMPLE WITH Memory 
//https://github.com/cph-cachet/carp.sensing-flutter/wiki/5.-Extending-CARP-Mobile-Sensing


// @JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
// abstract class DataEndPoint {
//   String get type;

//   Map<String, dynamic> toJson();
//   factory DataEndPoint.fromJson(Map<String, dynamic> json) {
//     switch (json['type']) {
//       case 'sqlite':
//         return SQLiteDataEndPoint.fromJson(json);
//       default:
//         throw UnsupportedError('Unsupported data endpoint type');
//     }
//   }
// }

// @JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
// class SQLiteDataEndPoint implements DataEndPoint {
//   final String databaseName;

//   SQLiteDataEndPoint({this.databaseName = 'sensing_database'});

//   @override
//   String get type => 'sqlite';

//   @override
//   Map<String, dynamic> toJson() => _$SQLiteDataEndPointToJson(this);

//   factory SQLiteDataEndPoint.fromJson(Map<String, dynamic> json) => _$SQLiteDataEndPointFromJson(json);

//   Future<void> saveData(String data) async {
//     // Implement the logic to save data to SQLite
//   }

//   void configure() {
//     // Implement any necessary configuration for the endpoint
//   }
// }

// // JSON serialization functions
// SQLiteDataEndPoint _$SQLiteDataEndPointFromJson(Map<String, dynamic> json) {
//   return SQLiteDataEndPoint(
//     databaseName: json['databaseName'] as String? ?? 'sensing_database',
//   );
// }

// Map<String, dynamic> _$SQLiteDataEndPointToJson(SQLiteDataEndPoint instance) =>
//     <String, dynamic>{
//       'type': instance.type,
//       'databaseName': instance.databaseName,
//     };
