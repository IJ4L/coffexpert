// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';

import '../models/prediction_model.dart';

Future<Either<String, PredictionModel>> procesOfNaiveBayes(
    List<String> pilihan) async {
  double n = 1;
  double p = 0.1;
  int m = 30;
  List<Map<String, dynamic>> probabilities = [];
  int tampilkan = 1;

  // Inisialisasi nc untuk setiap class
  List<Map<String, double>> penyakit = [
    {'G1': 0, 'G2': 0, 'G3': 0},
    {'G4': 0, 'G5': 0, 'G6': 0, 'G7': 0},
    {'G8': 0, 'G9': 0, 'G10': 0},
    {'G11': 0, 'G12': 0},
    {'G13': 0, 'G14': 0},
    {'G15': 0, 'G16': 0, 'G17': 0},
    {'G18': 0, 'G19': 0, 'G20': 0, 'G21': 0},
    {'G22': 0, 'G23': 0, 'G24': 0, 'G25': 0},
    {'G26': 0, 'G27': 0, 'G28': 0},
    {'G29': 0, 'G30': 0}
  ];

  List<Map<String, int>> generatedList = List.generate(
    10,
    (index) => pilihan.fold<Map<String, int>>(
      {},
      (map, key) => map..[key] = 0,
    ),
  );

  // Mengubah nilai penyakit menjadi 1 jika penyakit dan generatedList memiliki keys yang sama
  for (var i = 0; i < generatedList.length; i++) {
    var ncMap = generatedList[i];
    var generatedMap = penyakit[i];
    for (var key in generatedMap.keys) {
      if (ncMap.containsKey(key)) {
        ncMap[key] = 1;
      }
    }
  }

  // Menghitung nilai p(ai|vi) dan p(vi)
  for (var i = 0; i < generatedList.length; i++) {
    var ncMap = generatedList[i];
    var data = 0.1;

    ncMap.forEach((key, value) {
      double pAiVi = (value + p * m) / (n + m);
      data *= pAiVi;
    });

    probabilities.add({
      'penyakit': i,
      'akurasi': data,
    });
  }

  double tempAkurasi;
  int tempPenyakit;

  for (var i = 0; i < probabilities.length; i++) {
    for (var j = i + 1; j < probabilities.length; j++) {
      if (probabilities[j]['akurasi'] > probabilities[i]['akurasi']) {
        tempAkurasi = probabilities[j]['akurasi'];
        probabilities[j]['akurasi'] = probabilities[i]['akurasi'];
        probabilities[i]['akurasi'] = tempAkurasi;

        tempPenyakit = probabilities[j]['penyakit'];
        probabilities[j]['penyakit'] = probabilities[i]['penyakit'];
        probabilities[i]['penyakit'] = tempPenyakit;
      }
    }
  }

  double highestProbability = probabilities[0]['akurasi'];
  double secondHighestProbability = probabilities[1]['akurasi'];
  double thirdHighestProbability = probabilities[2]['akurasi'];

  if (highestProbability.toString().substring(0, 10) ==
      secondHighestProbability.toString().substring(0, 10)) {
    tampilkan = 2;
  }

  if (thirdHighestProbability.toString().substring(0, 10) ==
      secondHighestProbability.toString().substring(0, 10)) {
    tampilkan = 0;
  }

  if (highestProbability.toString().substring(0, 10) !=
      secondHighestProbability.toString().substring(0, 10)) {
    tampilkan = 1;
  }

  if (tampilkan == 2 || tampilkan == 1) {
    return Right(PredictionModel(
      penyakit: probabilities,
      gejala: pilihan,
      tampilkan: tampilkan,
    ));
  } else {
    return const Left('Masukkan Gejala Yang Tepat');
  }

  // for (var i = 0; i < probabilities.length; i++) {
  //   print(probabilities[i]);
  //   print('');
  // }

  // print('Probabilitas tertinggi: $highestProbability');
  // print('Probabilitas kedua tertinggi: $secondHighestProbability');
  // print('Tampilkan: $tampilkan');
}
