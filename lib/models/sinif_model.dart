class SinifModel {
  int? id;
  String? sinifAd;

  SinifModel({this.id, this.sinifAd});

  SinifModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sinifAd = json['sinifAd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sinifAd'] = sinifAd;
    return data;
  }
}
