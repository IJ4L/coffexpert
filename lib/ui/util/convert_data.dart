void convertData(List<int> data) {
  List<String> convertedData = data.map((value) => 'G$value').toList();
  print(convertedData);
}
