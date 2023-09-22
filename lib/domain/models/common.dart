class Common<T> {
  String? status;
  T? data;

  Common({this.status, this.data});

  Common.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    status = json['status'];
    if (json['data'] != null) {
      data = fromJsonT(json['data']);
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = status ?? "";
    if (this.data != null) {
      data['data'] = toJsonT(this.data!);
    }
    return data;
  }
}
