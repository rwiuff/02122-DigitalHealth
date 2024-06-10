// lib/src/analysis/data_analysis.dart

import 'dart:math';

class DataAnalysis {
  List<double> stepsData;
  List<Map<String, dynamic>> energyData; // Assume each map contains {'activity': 'running', 'duration': 30} in minutes
  List<Map<String, String>> sleepData; // Assume each map contains {'start': '22:00', 'end': '06:00'}
  List<double> weightData;

  DataAnalysis({
    required this.stepsData,
    required this.energyData,
    required this.sleepData,
    required this.weightData,
  });

  // Average Steps per day
  double averageSteps() {
    if (stepsData.isEmpty) {
      return 0.0;
    }
    return stepsData.reduce((a, b) => a + b) / stepsData.length;
  }

  // Calculate total calories burned by physical activity
  double totalCaloriesBurned() {
    if (energyData.isEmpty) {
      return 0.0;
    }
    
    double totalCalories = 0.0;

    for (var activity in energyData) {
      String activityType = activity['activity'];
      double duration = activity['duration'];
      double metValue = _getMetValue(activityType);
      totalCalories += metValue * duration * 3.5 * 70 / 200; // MET formula for calorie calculation
    }
    
    return totalCalories;
  }

  // Get MET value for different activities
  double _getMetValue(String activity) {
    switch (activity.toLowerCase()) {
      case 'running':
        return 9.8;
      case 'walking':
        return 3.8;
      case 'cycling':
        return 7.5;
      default:
        return 1.0; // Default MET for low activity
    }
  }

  // Calculate average sleep hours based on given start and end time
  double averageSleepHours() {
    if (sleepData.isEmpty) {
      return 0.0;
    }
    
    double totalSleepHours = 0.0;

    for (var sleep in sleepData) {
      String start = sleep['start']!;
      String end = sleep['end']!;
      totalSleepHours += _calculateSleepDuration(start, end);
    }

    return totalSleepHours / sleepData.length;
  }

  // Calculate sleep duration in hours
  double _calculateSleepDuration(String start, String end) {
    DateTime startTime = DateTime.parse('1970-01-01T$start:00');
    DateTime endTime = DateTime.parse('1970-01-02T$end:00');
    Duration sleepDuration = endTime.difference(startTime);
    return sleepDuration.inMinutes / 60;
  }

  // Calculate average weight
  double averageWeight() {
    if (weightData.isEmpty) {
      return 0.0;
    }
    return weightData.reduce((a, b) => a + b) / weightData.length;
  }
}

void main() {
  List<double> steps = [1000, 1500, 1200, 1300, 1600];
  List<Map<String, dynamic>> energy = [
    {'activity': 'running', 'duration': 30},
    {'activity': 'walking', 'duration': 60},
    {'activity': 'cycling', 'duration': 45}
  ];
  List<Map<String, String>> sleep = [
    {'start': '22:00', 'end': '06:00'},
    {'start': '23:00', 'end': '07:00'}
  ];
  List<double> weight = [70.5, 71.0, 70.8, 71.2, 70.9];

  DataAnalysis analysis = DataAnalysis(
    stepsData: steps,
    energyData: energy,
    sleepData: sleep,
    weightData: weight,
  );

  print('Average Steps: ${analysis.averageSteps()}');
  print('Total Calories Burned: ${analysis.totalCaloriesBurned()}');
  print('Average Sleep Hours: ${analysis.averageSleepHours()}');
  print('Average Weight: ${analysis.averageWeight()}');
}
