class NaiveBayes {
  Map<String, Map<String, int>> evidence = {};
  Map<String, int> classCounts = {};
  int vocabularySize = 0; // Menyimpan ukuran vocabulary

  void addEvidence(List<String> features, String className) {
    final evidenceKey = features.join(',');

    if (!evidence.containsKey(className)) {
      evidence[className] = {};
      classCounts[className] = 0;
    }

    if (!evidence[className]!.containsKey(evidenceKey)) {
      evidence[className]![evidenceKey] = 0;
    }

    evidence[className]![evidenceKey] = evidence[className]![evidenceKey]! + 1;
    classCounts[className] = classCounts[className]! + 1;

    // Perbarui ukuran vocabulary
    vocabularySize += features.length;
  }

  Map<String, double> predict(List<String> features) {
    final Map<String, double> probabilities = {};

    for (final className in evidence.keys) {
      final classEvidence = evidence[className];
      final classCount = classCounts[className]!;
      double classProbability =
          classCount / classCounts.values.reduce((a, b) => a + b);
      double featureProbability = 1;

      final evidenceKey = features.join(',');
      final featureCount = classEvidence![evidenceKey] ?? 0;

      // Terapkan Laplace smoothing
      featureProbability *= (featureCount + 1) / (classCount + vocabularySize);

      probabilities[className] = classProbability * featureProbability;
    }

    final totalProbability = probabilities.values.reduce((a, b) => a + b);
    probabilities
        .updateAll((className, probability) => probability / totalProbability);

    return probabilities;
  }
}

String getPredictedClass(Map<String, double> prediction) {
  String predictedClass = '';
  double highestProbability = 0;

  for (final className in prediction.keys) {
    if (prediction[className]! > highestProbability) {
      highestProbability = prediction[className]!;
      predictedClass = className;
    }
  }

  return predictedClass;
}

void main() {
  final classifier = NaiveBayes();

  // Training the Naive Bayes model
  classifier.addEvidence(['G2', 'G3', 'G9'], 'P1');
  classifier.addEvidence(['G17', 'G18', 'G23', 'G24'], 'P2');
  classifier.addEvidence(['G16', 'G28', 'G30'], 'P3');
  classifier.addEvidence(['G19', 'G20'], 'P4');
  classifier.addEvidence(['G21', 'G22'], 'P5');
  classifier.addEvidence(['G11', 'G13', 'G1'], 'P6');
  classifier.addEvidence(['G10', 'G12', 'G14', 'G15'], 'P7');
  classifier.addEvidence(['G4', 'G5', 'G6', 'G7'], 'P8');
  classifier.addEvidence(['G8', 'G25', 'G26'], 'P9');
  classifier.addEvidence(['G27', 'G29'], 'P10');

  // Making predictions
  final prediction = classifier.predict(['G27', 'G29']);
  print(prediction);
  print(getPredictedClass(prediction));
}
