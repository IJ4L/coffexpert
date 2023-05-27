import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  final String penyakit;
  final List<dynamic> gejala;
  final String at;

  HistoryModel({
    required this.penyakit,
    required this.gejala,
    required this.at,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        penyakit: json["penyakit"],
        gejala: List<dynamic>.from(json["gejala"].map((x) => x)),
        at: json["at"],
      );

  Map<String, dynamic> toJson() => {
        "penyakit": penyakit,
        "gejala": List<dynamic>.from(gejala.map((x) => x)),
        "at": at,
      };
}
