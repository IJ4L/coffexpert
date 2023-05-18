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

void main() {
  final classifier = NaiveBayes();

  //Gejala ke-1
  classifier.addEvidence(['G2', 'G3', 'G9'], 'P1');
  classifier.addEvidence(['G3', 'G2', 'G9'], 'P1');
  classifier.addEvidence(['G3', 'G9', 'G2'], 'P1');
  classifier.addEvidence(['G9', 'G3', 'G2'], 'P1');
  classifier.addEvidence(['G9', 'G2', 'G3'], 'P1');
  classifier.addEvidence(['G2', 'G9', 'G3'], 'P1');

  //Gejala ke-2
  classifier.addEvidence(['G2', 'G4', 'G9'], 'P2');
  classifier.addEvidence(['G4', 'G2', 'G9'], 'P2');
  classifier.addEvidence(['G4', 'G9', 'G2'], 'P2');
  classifier.addEvidence(['G9', 'G4', 'G2'], 'P2');
  classifier.addEvidence(['G9', 'G2', 'G4'], 'P2');
  classifier.addEvidence(['G2', 'G9', 'G4'], 'P2');

  //Gejala ke-3
  classifier.addEvidence(['G5', 'G6', 'G9'], 'P3');
  classifier.addEvidence(['G6', 'G5', 'G9'], 'P3');
  classifier.addEvidence(['G6', 'G9', 'G5'], 'P3');
  classifier.addEvidence(['G9', 'G6', 'G5'], 'P3');
  classifier.addEvidence(['G9', 'G5', 'G6'], 'P3');
  classifier.addEvidence(['G5', 'G9', 'G6'], 'P3');

  // Gejala yang tidak ada di daftar
  classifier.addEvidence(['G1', 'G9', 'G8'], 'P4');
  classifier.addEvidence(['G9', 'G1', 'G8'], 'P4');

  classifier.calculateFeatureWeights();

  final featuresToPredict = ['G1', 'G9', '4'];

  bool areFeaturesValid = true;
  for (final feature in featuresToPredict) {
    if (!classifier.featureWeights.values
        .any((weights) => weights.containsKey(feature))) {
      areFeaturesValid = false;
      break;
    }
  }

  if (areFeaturesValid) {
    final prediction = classifier.predict(featuresToPredict);
    final predictedClass = classifier.getPredictedClass(prediction);

    if (predictedClass != null) {
      print('Hasil prediksi: $predictedClass');
    } else {
      print('Tidak dapat memprediksi kelas.');
    }
  } else {
    print('Fitur yang dimasukkan tidak ada dalam data pelatihan.');
  }
}
