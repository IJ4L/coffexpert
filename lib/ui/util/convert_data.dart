List<String> convertData(List<int> data) {
  List<String> convertedData = data.map((value) => 'G$value').toList();
  return convertedData;
}
