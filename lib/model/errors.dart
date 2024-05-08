class ErrorModel {
  bool? status;
  dynamic message;

  ErrorModel({
    this.status,
    this.message,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"];
  }
}
