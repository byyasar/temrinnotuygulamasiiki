class OgrenciModel {
  int? id;
  String? ogrenciAdSoyad;
  int? ogrenciNu;
  int? sinifId;
  String? ogrenciResim;

  OgrenciModel({this.id, this.ogrenciAdSoyad, this.ogrenciNu, this.sinifId, this.ogrenciResim});

  OgrenciModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ogrenciAdSoyad = json['ogrenciAdSoyad'];
    ogrenciNu = json['ogrenciNu'];
    sinifId = json['sinifId'];
    ogrenciResim = json['ogrenciResim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ogrenciAdSoyad'] = ogrenciAdSoyad;
    data['ogrenciNu'] = ogrenciNu;
    data['sinifId'] = sinifId;
    data['ogrenciResim'] = ogrenciResim;
    return data;
  }
}
