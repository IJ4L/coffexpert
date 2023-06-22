// import 'package:coffe_brain/models/prediction_model.dart';
// import 'package:dartz/dartz.dart';
// import 'package:logger/logger.dart';

// class NaiveBayes {
//   Map<String, Map<String, int>> evidence = {};
//   Map<String, int> classCounts = {};
//   Map<String, Map<String, double>> featureWeights = {};
//   int vocabularySize = 0;

//   void addEvidence(List<String> features, String className) {
//     final evidenceKey = features.join(',');

//     evidence[className] ??= {};
//     evidence[className]![evidenceKey] ??= 0;

//     evidence[className]![evidenceKey] = evidence[className]![evidenceKey]! + 1;
//     classCounts[className] = (classCounts[className] ?? 0) + 1;

//     vocabularySize += features.length;
//   }

//   void printData() {
//     Logger().wtf("Jumlah Class");
//     Logger().i(classCounts);
//     Logger().wtf("Bukti");
//     Logger().i(evidence);
//     Logger().wtf("Ukursan Kosa Kata");
//     Logger().i(vocabularySize);
//     Logger().wtf("Bobot Fitur");
//     Logger().i(featureWeights);
//   }

//   void calculateFeatureWeights() {
//     for (final className in evidence.keys) {
//       featureWeights[className] = {};

//       final classEvidence = evidence[className];

//       for (final evidenceKey in classEvidence!.keys) {
//         final featureCount = classEvidence[evidenceKey]!;
//         final features = evidenceKey.split(',');

//         for (final feature in features) {
//           featureWeights[className]![feature] ??= 0;
//           featureWeights[className]![feature] =
//               featureWeights[className]![feature]! + featureCount.toDouble();
//         }
//       }
//     }
//   }

//   Map<String, double> predict(List<String> features) {
//     final Map<String, double> probabilities = {};

//     for (final className in evidence.keys) {
//       final classEvidence = evidence[className];
//       final classCount = classCounts[className]!;
//       double classProbability =
//           classCount / classCounts.values.reduce((a, b) => a + b);
//       double featureProbability = 1;

//       for (final feature in features) {
//         final evidenceKey = feature;
//         final featureCount = classEvidence?[evidenceKey] ?? 0;

//         featureProbability *=
//             (featureCount + 1) / (classCount + vocabularySize);

//         if (featureWeights.containsKey(className) &&
//             featureWeights[className]!.containsKey(feature)) {
//           final featureWeight = featureWeights[className]![feature]!;
//           featureProbability *= featureWeight;
//         }
//       }

//       probabilities[className] =
//           (classProbability * featureProbability * 100).toDouble();
//     }

//     final totalProbability = probabilities.values.reduce((a, b) => a + b);
//     probabilities.updateAll((className, probability) {
//       return probability / totalProbability;
//     });

//     Logger().w(probabilities);

//     return probabilities;
//   }

//   String? getPredictedClass(Map<String, double> prediction) {
//     String? predictedClass;
//     double highestProbability = 0;

//     for (final className in prediction.keys) {
//       if (prediction[className]! > highestProbability) {
//         highestProbability = prediction[className]!;
//         predictedClass = className;
//       }
//     }

//     return predictedClass;
//   }
// }

// Future<Either<String, PredictionModel>> procesNaiveBayes(
//     List<String> gejala) async {
//   final classifier = NaiveBayes();

//   classifier.addEvidence(['G1'], 'Penggerek Buah Kopi');
//   classifier.addEvidence(['G2'], 'Penggerek Buah Kopi');
//   classifier.addEvidence(['G3'], 'Penggerek Buah Kopi');

//   classifier.addEvidence(['G4'], 'Penggerek Cabang Kopi');
//   classifier.addEvidence(['G5'], 'Penggerek Cabang Kopi');
//   classifier.addEvidence(['G6'], 'Penggerek Cabang Kopi');
//   classifier.addEvidence(['G7'], 'Penggerek Cabang Kopi');

//   classifier.addEvidence(['G8'], 'Penggerek Batang');
//   classifier.addEvidence(['G9'], 'Penggerek Batang');
//   classifier.addEvidence(['G10'], 'Penggerek Batang');

//   classifier.addEvidence(['G12'], 'Kutu Hijau');
//   classifier.addEvidence(['G11'], 'Kutu Hijau');

//   classifier.addEvidence(['G14'], 'Kutu Putih');
//   classifier.addEvidence(['G13'], 'Kutu Putih');

//   classifier.addEvidence(['G15'], 'Karat Daun Kopi');
//   classifier.addEvidence(['G16'], 'Karat Daun Kopi');
//   classifier.addEvidence(['G17'], 'Karat Daun Kopi');

//   classifier.addEvidence(['G18'], 'Bercak Daun Kopi');
//   classifier.addEvidence(['G19'], 'Bercak Daun Kopi');
//   classifier.addEvidence(['G20'], 'Bercak Daun Kopi');
//   classifier.addEvidence(['G21'], 'Bercak Daun Kopi');

//   classifier.addEvidence(['G22'], 'Nemotoda');
//   classifier.addEvidence(['G23'], 'Nemotoda');
//   classifier.addEvidence(['G24'], 'Nemotoda');
//   classifier.addEvidence(['G25'], 'Nemotoda');

//   classifier.addEvidence(['G26'], 'Jamur Upas');
//   classifier.addEvidence(['G27'], 'Jamur Upas');
//   classifier.addEvidence(['G28'], 'Jamur Upas');

//   classifier.addEvidence(['G30'], 'Penyakit Akar');
//   classifier.addEvidence(['G29'], 'Penyakit Akar');

//   classifier.calculateFeatureWeights();

//   final featuresToPredict = gejala;

//   classifier.printData();

//   bool areFeaturesValid = true;
//   for (final feature in featuresToPredict) {
//     if (!classifier.featureWeights.values.any((weights) {
//       return weights.containsKey(feature);
//     })) {
//       areFeaturesValid = false;
//       break;
//     }
//   }

//   if (areFeaturesValid && gejala.isNotEmpty) {
//     final prediction = classifier.predict(featuresToPredict);
//     final predictedClass = classifier.getPredictedClass(prediction);

//     double highestProbability = 0;

//     for (final className in prediction.keys) {
//       final probability = prediction[className]!;

//       if (probability > highestProbability) {
//         highestProbability = probability;
//       }
//     }

//     if (predictedClass != null) {
//       // PredictionModel data = PredictionModel(
//       //   penyakit: predictedClass,
//       //   akurasi: (highestProbability * 100).toStringAsFixed(2),
//       //   gejala: gejala,
//       // );
//       return Right(data);
//     } else {
//       return const Left('Tidak dapat memprediksi kelas.');
//     }
//   } else {
//     return const Left('Fitur yang dimasukkan tidak ada dalam data pelatihan');
//   }
// }
