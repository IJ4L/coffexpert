class PredictionModel {
  final List<Map<String, dynamic>> penyakit;
  final List<String> gejala;
  final int tampilkan;

  PredictionModel({
    required this.penyakit,
    required this.gejala,
    required this.tampilkan,
  });
}
