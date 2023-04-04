class HistoryDbModel {
  int? historyId;
  int? statonId;
  int? assetId;
  String? title;
  String? body;
  String? file;
  HistoryDbModel(
      {this.historyId,
      this.statonId,
      this.assetId,
      this.title,
      this.body,
      this.file});

  Map<String, dynamic> toMap() {
    return {
      'historyId': historyId,
      'statonId': statonId,
      'assetId': assetId,
      'title': title,
      'body': body,
      'file': file,
    };
  }
}
