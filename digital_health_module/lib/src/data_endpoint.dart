part of '../main.dart';

//EXAMPLE WITH Memory 
//https://github.com/cph-cachet/carp.sensing-flutter/wiki/5.-Extending-CARP-Mobile-Sensing

// Define a base class for DataEndPoints
abstract class DataEndPoint {
  // Common properties and methods for all data endpoints
}

// Define the SQLiteDataEndPoint class that extends DataEndPoint
class SQLiteDataEndPoint extends DataEndPoint {
  final String databaseName;

  SQLiteDataEndPoint({this.databaseName = 'sensing_database'});

  // Example method to save data (this needs actual implementation)
  Future<void> saveData(String data) async {
    // Implement the logic to save data to SQLite
  }

  // Example method to configure the endpoint
  void configure() {
    // Implement any necessary configuration for the endpoint
  }
}
//TODO API med data