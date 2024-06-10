// lib/test/integration_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:package_mvp/src/backend.dart';
import 'package:package_mvp/src/data_analysis.dart';
import 'package:package_mvp/src/data_endpoint.dart';
import 'package:package_mvp/src/local_protocol_manager.dart';
import 'package:package_mvp/src/sensing.dart';
import 'package:package_mvp/src/sensing_bloc.dart';

void main() {
  test('Integration test for backend and data analysis', () {
    // Initialize backend
    final backend = CarpBackend();
    backend.initialize();

    // Simulate fetching data from backend
    final List<double> stepsData = [1000.0, 1500.0, 1200.0];
    final List<Map<String, dynamic>> energyData = [
      {'activity': 'running', 'duration': 30.0},
      {'activity': 'walking', 'duration': 60.0},
    ];
    final List<Map<String, String>> sleepData = [
      {'start': '22:00', 'end': '06:00'},
      {'start': '23:00', 'end': '07:00'}
    ];
    final List<double> weightData = [70.5, 71.0, 70.8];

    // Initialize data analysis
    final dataAnalysis = DataAnalysis(
      stepsData: stepsData,
      energyData: energyData,
      sleepData: sleepData,
      weightData: weightData,
    );

    // Perform analysis
    final averageSteps = dataAnalysis.averageSteps();
    final totalCaloriesBurned = dataAnalysis.totalCaloriesBurned();
    final averageSleepHours = dataAnalysis.averageSleepHours();
    final averageWeight = dataAnalysis.averageWeight();

    // Verify the results
    expect(averageSteps, greaterThan(0));
    expect(totalCaloriesBurned, greaterThan(0));
    expect(averageSleepHours, greaterThan(0));
    expect(averageWeight, greaterThan(0));
  });
}
