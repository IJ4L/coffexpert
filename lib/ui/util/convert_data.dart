List<String> convertData(List<int> data) {
  List<String> convertedData = data.map((value) => 'G${value + 1}').toList();
  return convertedData;
}
