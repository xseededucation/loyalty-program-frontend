class Common<T> {
  String? status;
  List<T>? data;

  Common({this.status, this.data});

  Common.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    status = json['status'];
    if (json['data'] != null) {
      data = List<T>.from(json['data'].map((dynamic item) => fromJsonT(item)));
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((T item) => toJsonT(item)).toList();
    }
    return data;
  }
}
