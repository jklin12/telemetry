class DailyRainfallReqModel {
  String? date;
  String? station;

  DailyRainfallReqModel({this.date, this.station});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['station'] = station;
    return data;
  }
}
