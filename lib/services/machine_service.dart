import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class NaiveBayes {
  Map<String, Map<String, int>> evidence = {};
  Map<String, int> classCounts = {};
  Map<String, Map<String, double>> featureWeights = {};
  int vocabularySize = 0;

  void addEvidence(List<String> features, String className) {
    final evidenceKey = features.join(',');

    evidence[className] ??= {};
    evidence[className]![evidenceKey] ??= 0;

    evidence[className]![evidenceKey] = evidence[className]![evidenceKey]! + 1;
    classCounts[className] = (classCounts[className] ?? 0) + 1;

    vocabularySize += features.length;

    // Logger().i(evidence);
  }

  void calculateFeatureWeights() {
    for (final className in evidence.keys) {
      featureWeights[className] = {};

      final classEvidence = evidence[className];

      for (final evidenceKey in classEvidence!.keys) {
        final featureCount = classEvidence[evidenceKey]!;
        final features = evidenceKey.split(',');

        for (final feature in features) {
          featureWeights[className]![feature] ??= 0;
          featureWeights[className]![feature] =
              featureWeights[className]![feature]! + featureCount.toDouble();
        }
      }
      // Logger().i(featureWeights[className]);
    }
  }

  Map<String, double> predict(List<String> features) {
    final Map<String, double> probabilities = {};

    for (final className in evidence.keys) {
      final classEvidence = evidence[className];
      final classCount = classCounts[className]!;
      double classProbability =
          classCount / classCounts.values.reduce((a, b) => a + b);
      double featureProbability = 1;

      for (final feature in features) {
        final evidenceKey = feature;
        final featureCount = classEvidence?[evidenceKey] ?? 0;

        featureProbability *=
            (featureCount + 1) / (classCount + vocabularySize);

        if (featureWeights.containsKey(className) &&
            featureWeights[className]!.containsKey(feature)) {
          final featureWeight = featureWeights[className]![feature]!;
          featureProbability *= featureWeight;
        }
      }
      // Logger().d(classProbability);
      probabilities[className] = classProbability * featureProbability * 100;
      Logger().d(probabilities[className]);
    }

    final totalProbability = probabilities.values.reduce((a, b) => a + b);
    probabilities
        .updateAll((className, probability) => probability / totalProbability);

    // Logger().d(probabilities);
    // Logger().i(probabilities);
    return probabilities;
  }

  String? getPredictedClass(Map<String, double> prediction) {
    String? predictedClass;
    double highestProbability = 0;

    for (final className in prediction.keys) {
      if (prediction[className]! > highestProbability) {
        highestProbability = prediction[className]!;
        predictedClass = className;
      }
    }

    return predictedClass;
  }
}

Future<Either<String, String>> procesNaiveBayes(List<String> gejala) async {
  final classifier = NaiveBayes();

  classifier.addEvidence(['G1', 'G2', 'G3'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G1', 'G3', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G2', 'G1', 'G3'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G2', 'G3', 'G1'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G1', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G2', 'G1'], 'Penggerek Buah Kopi');

  classifier.addEvidence(['G4', 'G5', 'G6', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G4', 'G5', 'G7', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G4', 'G6', 'G5', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G4', 'G6', 'G7', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G4', 'G7', 'G5', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G4', 'G7', 'G6', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G4', 'G6', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G4', 'G7', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G6', 'G4', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G6', 'G7', 'G4'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G7', 'G4', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G5', 'G7', 'G6', 'G4'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G4', 'G5', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G4', 'G7', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G5', 'G4', 'G7'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G5', 'G7', 'G4'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G7', 'G4', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G6', 'G7', 'G5', 'G4'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G4', 'G5', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G4', 'G6', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G5', 'G4', 'G6'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G5', 'G6', 'G4'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G6', 'G4', 'G5'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G7', 'G6', 'G5', 'G4'], 'Penggerek Cabang Kopi');

  classifier.addEvidence(['G8', 'G9', 'G10'], 'Penggerek Batang');
  classifier.addEvidence(['G8', 'G10', 'G9'], 'Penggerek Batang');
  classifier.addEvidence(['G9', 'G8', 'G10'], 'Penggerek Batang');
  classifier.addEvidence(['G9', 'G10', 'G8'], 'Penggerek Batang');
  classifier.addEvidence(['G10', 'G8', 'G9'], 'Penggerek Batang');
  classifier.addEvidence(['G10', 'G9', 'G8'], 'Penggerek Batang');

  classifier.addEvidence(['G11', 'G12'], 'Kutu Hijau');
  classifier.addEvidence(['G12', 'G11'], 'Kutu Hijau');
  classifier.addEvidence(['G11'], 'Kutu Hijau');
  classifier.addEvidence(['G12'], 'Kutu Hijau');

  classifier.addEvidence(['G13', 'G14'], 'Kutu Putih');
  classifier.addEvidence(['G14', 'G13'], 'Kutu Putih');
  classifier.addEvidence(['G13'], 'Kutu Putih');
  classifier.addEvidence(['G14'], 'Kutu Putih');

  classifier.addEvidence(['G15', 'G16', 'G17'], 'Karat Daun Kopi');
  classifier.addEvidence(['G15', 'G17', 'G16'], 'Karat Daun Kopi');
  classifier.addEvidence(['G16', 'G15', 'G17'], 'Karat Daun Kopi');
  classifier.addEvidence(['G16', 'G17', 'G15'], 'Karat Daun Kopi');
  classifier.addEvidence(['G17', 'G15', 'G16'], 'Karat Daun Kopi');
  classifier.addEvidence(['G17', 'G16', 'G15'], 'Karat Daun Kopi');

  classifier.addEvidence(['G18', 'G19', 'G20', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G18', 'G19', 'G21', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G18', 'G20', 'G19', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G18', 'G20', 'G21', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G18', 'G21', 'G19', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G18', 'G21', 'G20', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G18', 'G20', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G18', 'G21', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G20', 'G18', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G20', 'G21', 'G18'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G21', 'G18', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G19', 'G21', 'G20', 'G18'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G18', 'G19', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G18', 'G21', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G19', 'G18', 'G21'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G19', 'G21', 'G18'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G21', 'G18', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G20', 'G21', 'G19', 'G18'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G18', 'G19', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G18', 'G20', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G19', 'G18', 'G20'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G19', 'G20', 'G18'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G20', 'G18', 'G19'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G21', 'G20', 'G19', 'G18'], 'Bercak Daun Kopi');

  classifier.addEvidence(['G22', 'G23', 'G24', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G22', 'G23', 'G25', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G22', 'G24', 'G23', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G22', 'G24', 'G25', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G22', 'G25', 'G23', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G22', 'G25', 'G24', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G22', 'G24', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G22', 'G25', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G24', 'G22', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G24', 'G25', 'G22'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G25', 'G22', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G23', 'G25', 'G24', 'G22'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G22', 'G23', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G22', 'G25', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G23', 'G22', 'G25'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G23', 'G25', 'G22'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G25', 'G22', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G24', 'G25', 'G23', 'G22'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G22', 'G23', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G22', 'G24', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G23', 'G22', 'G24'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G23', 'G24', 'G22'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G24', 'G22', 'G23'], 'Nemotoda');
  classifier.addEvidence(['G25', 'G24', 'G23', 'G22'], 'Nemotoda');

  classifier.addEvidence(['G26', 'G27', 'G28'], 'Jamur Upas');
  classifier.addEvidence(['G26', 'G28', 'G27'], 'Jamur Upas');
  classifier.addEvidence(['G27', 'G26', 'G28'], 'Jamur Upas');
  classifier.addEvidence(['G27', 'G28', 'G26'], 'Jamur Upas');
  classifier.addEvidence(['G28', 'G26', 'G27'], 'Jamur Upas');
  classifier.addEvidence(['G28', 'G27', 'G26'], 'Jamur Upas');

  classifier.addEvidence(['G29', 'G30'], 'Penyakit Akar');
  classifier.addEvidence(['G30', 'G29'], 'Penyakit Akar');
  classifier.addEvidence(['G30'], 'Penyakit Akar');
  classifier.addEvidence(['G29'], 'Penyakit Akar');

  classifier.calculateFeatureWeights();

  final featuresToPredict = gejala;

  bool areFeaturesValid = true;
  for (final feature in featuresToPredict) {
    if (!classifier.featureWeights.values.any((weights) {
      return weights.containsKey(feature);
    })) {
      areFeaturesValid = false;
      break;
    }
    // Logger().i(areFeaturesValid);
  }

  if (areFeaturesValid && gejala.isNotEmpty) {
    final prediction = classifier.predict(featuresToPredict);
    final predictedClass = classifier.getPredictedClass(prediction);

    if (predictedClass != null) {
      if (kDebugMode) {
        print(prediction);
      }
      return Right(predictedClass);
    } else {
      return const Left('Tidak dapat memprediksi kelas.');
    }
  } else {
    return const Left('Fitur yang dimasukkan tidak ada dalam data pelatihan');
  }
}
