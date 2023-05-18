import 'package:dartz/dartz.dart';

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

        // Apply feature weighting if available
        if (featureWeights.containsKey(className) &&
            featureWeights[className]!.containsKey(feature)) {
          final featureWeight = featureWeights[className]![feature]!;
          featureProbability *= featureWeight;
        }
      }

      probabilities[className] = classProbability * featureProbability;
    }

    final totalProbability = probabilities.values.reduce((a, b) => a + b);
    probabilities
        .updateAll((className, probability) => probability / totalProbability);

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

  classifier.addEvidence(['G2', 'G3', 'G9'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G2', 'G9'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G9', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G9', 'G3', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G9', 'G2', 'G3'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G2', 'G9', 'G3'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G2', 'G3', 'G9'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G2', 'G9', 'G3'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G2', 'G9'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G3', 'G9', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G9', 'G3', 'G2'], 'Penggerek Buah Kopi');
  classifier.addEvidence(['G9', 'G2', 'G3'], 'Penggerek Buah Kopi');

  //Gejala ke-2
  classifier.addEvidence(['G17', 'G18', 'G23', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G18', 'G17', 'G23', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G18', 'G23', 'G17', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G18', 'G23', 'G24', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G18', 'G24', 'G23', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G18', 'G23', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G23', 'G18', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G23', 'G17', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G17', 'G23', 'G18', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G17', 'G23', 'G24', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G17', 'G24', 'G18', 'G23'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G17', 'G24', 'G23', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G17', 'G18', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G17', 'G24', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G18', 'G17', 'G24'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G18', 'G24', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G24', 'G17', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G23', 'G24', 'G18', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G17', 'G18', 'G23'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G17', 'G23', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G18', 'G17', 'G23'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G18', 'G23', 'G17'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G23', 'G17', 'G18'], 'Penggerek Cabang Kopi');
  classifier.addEvidence(['G24', 'G23', 'G18', 'G17'], 'Penggerek Cabang Kopi');

  //Gejala ke-3
  classifier.addEvidence(['G16', 'G28', 'G30'], 'Penggerek Batang');
  classifier.addEvidence(['G28', 'G16', 'G30'], 'Penggerek Batang');
  classifier.addEvidence(['G28', 'G30', 'G16'], 'Penggerek Batang');
  classifier.addEvidence(['G30', 'G28', 'G16'], 'Penggerek Batang');
  classifier.addEvidence(['G16', 'G30', 'G28'], 'Penggerek Batang');
  classifier.addEvidence(['G30', 'G16', 'G28'], 'Penggerek Batang');
  classifier.addEvidence(['G30', 'G28', 'G16'], 'Penggerek Batang');
  classifier.addEvidence(['G28', 'G30', 'G16'], 'Penggerek Batang');

  //Gejala ke-4
  classifier.addEvidence(['G19', 'G20'], 'Kutu Hijau');
  classifier.addEvidence(['G20', 'G19'], 'Kutu Hijau');
  classifier.addEvidence(['G19'], 'Kutu Hijau');
  classifier.addEvidence(['G20'], 'Kutu Hijau');

  //Gejala ke-5
  classifier.addEvidence(['G21', 'G22'], 'Kutu Putih');
  classifier.addEvidence(['G22', 'G21'], 'Kutu Putih');
  classifier.addEvidence(['G22'], 'Kutu Putih');
  classifier.addEvidence(['G21'], 'Kutu Putih');

  //Gejala ke-6
  classifier.addEvidence(['G11', 'G13', 'G1'], 'Karat Daun Kopi');
  classifier.addEvidence(['G13', 'G11', 'G1'], 'Karat Daun Kopi');
  classifier.addEvidence(['G13', 'G1', 'G11'], 'Karat Daun Kopi');
  classifier.addEvidence(['G1', 'G13', 'G11'], 'Karat Daun Kopi');
  classifier.addEvidence(['G11', 'G1', 'G13'], 'Karat Daun Kopi');
  classifier.addEvidence(['G1', 'G11', 'G13'], 'Karat Daun Kopi');
  classifier.addEvidence(['G1', 'G13', 'G11'], 'Karat Daun Kopi');
  classifier.addEvidence(['G13', 'G1', 'G11'], 'Karat Daun Kopi');

  //Gejala ke-7
  classifier.addEvidence(['G10', 'G12', 'G14', 'G15'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G12', 'G10', 'G14', 'G15'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G12', 'G14', 'G10', 'G15'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G12', 'G14', 'G15', 'G10'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G14', 'G12', 'G10', 'G15'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G14', 'G12', 'G15', 'G10'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G14', 'G15', 'G12', 'G10'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G15', 'G14', 'G12', 'G10'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G15', 'G14', 'G10', 'G12'], 'Bercak Daun Kopi');
  classifier.addEvidence(['G15', 'G10', 'G14', 'G12'], 'Bercak Daun Kopi');

  //Gejala ke-8
  classifier.addEvidence(['G4', 'G5', 'G6', 'G7'], 'Nemotoda');
  classifier.addEvidence(['G5', 'G4', 'G6', 'G7'], 'Nemotoda');
  classifier.addEvidence(['G5', 'G6', 'G4', 'G7'], 'Nemotoda');
  classifier.addEvidence(['G5', 'G6', 'G7', 'G4'], 'Nemotoda');
  classifier.addEvidence(['G6', 'G5', 'G4', 'G7'], 'Nemotoda');
  classifier.addEvidence(['G6', 'G5', 'G7', 'G4'], 'Nemotoda');
  classifier.addEvidence(['G6', 'G7', 'G5', 'G4'], 'Nemotoda');
  classifier.addEvidence(['G7', 'G6', 'G5', 'G4'], 'Nemotoda');
  classifier.addEvidence(['G7', 'G6', 'G4', 'G5'], 'Nemotoda');
  classifier.addEvidence(['G7', 'G4', 'G6', 'G5'], 'Nemotoda');

  //Gejala ke-9
  classifier.addEvidence(['G8', 'G25', 'G26'], 'Jamur Upas');
  classifier.addEvidence(['G25', 'G8', 'G26'], 'Jamur Upas');
  classifier.addEvidence(['G25', 'G26', 'G8'], 'Jamur Upas');
  classifier.addEvidence(['G26', 'G8', 'G25'], 'Jamur Upas');
  classifier.addEvidence(['G8', 'G26', 'G25'], 'Jamur Upas');
  classifier.addEvidence(['G26', 'G25', 'G8'], 'Jamur Upas');
  classifier.addEvidence(['G26', 'G8', 'G25'], 'Jamur Upas');
  classifier.addEvidence(['G25', 'G26', 'G8'], 'Jamur Upas');

  //Gejala ke-10
  classifier.addEvidence(['G27', 'G29'], 'Penyakit Akar');
  classifier.addEvidence(['G29', 'G27'], 'Penyakit Akar');
  classifier.addEvidence(['G27'], 'Penyakit Akar');
  classifier.addEvidence(['G29'], 'Penyakit Akar');

  classifier.calculateFeatureWeights();

  final featuresToPredict = gejala;

  bool areFeaturesValid = true;
  for (final feature in featuresToPredict) {
    if (!classifier.featureWeights.values
        .any((weights) => weights.containsKey(feature))) {
      areFeaturesValid = false;
      break;
    }
  }

  if (areFeaturesValid && gejala.isNotEmpty) {
    final prediction = classifier.predict(featuresToPredict);
    final predictedClass = classifier.getPredictedClass(prediction);

    if (predictedClass != null) {
      print(prediction);
      return Right(predictedClass);
    } else {
      return const Left('Tidak dapat memprediksi kelas.');
    }
  } else {
    return const Left('Fitur yang dimasukkan tidak ada dalam data pelatihan');
  }
}
