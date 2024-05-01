// part of '../main.dart';

// class DataAnalysis {
//   //declaration
//   List<double> stepsData = [];
//   List<double> energyData = [];
//   List<double> sleepData = [];
//   List<double> weightData = [];

//   DataAnalysis({
//     required this.stepsData,
//     required this.energyData,
//     required this.sleepData,
//     required this.weightData
//   });

//   // Average STEPS
//   double averageHearthRate() {
//     if (stepsData.isEmpty) {
//       return 0.0;
//     }
//       return stepsData.reduce((HealthSamplingPackage.getHealthMeasure(STEPS)) => stepsData)
//   }

//   // Average Energy burned
//   double averageSteps() {
//       if (energyData.isEmpty) {
//       return 0.0;
//     }
//     return energyData.reduce((HealthSamplingPackage.getHealthMeasure(BASAL_ENERGY_BURNED)) => energyData)
//   }
//   // Average Sleep
//   double averageSleepHours() {
//       if (sleepData.isEmpty) {
//       return 0.0;
//     }
//     return sleepData.reduce((HealthSamplingPackage.getHealthMeasure(SLEEP_SESSION)) => sleepData)
//   }

//   //Average Weight
//   double averageWeight() {
//       if (weightData.isEmpty) {
//       return 0.0;
//     }
//       return weightData.reduce((HealthSamplingPackage.getHealthMeasure(WEIGHT)) => weightData)

//   }

//   //TODO implementation of get/set for data from study_protocol_manager
//   //TODO data analysis
// }