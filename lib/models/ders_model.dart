class DersModel {
  int? id;
  String? dersAd;
  int? sinifId;

  DersModel({this.id, this.dersAd, this.sinifId});

  DersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dersAd = json['dersAd'];
    sinifId = json['sinifId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dersAd'] = dersAd;
    data['sinifId'] = sinifId;
    return data;
  }
}
