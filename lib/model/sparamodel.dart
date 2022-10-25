class SparaModel {
  String? sparaId;
  String? sparaName;
  String? sparaPrice;
  String? sparaVersion;
  String? sparaImage;
  String? sparaAdmin;

  SparaModel(
      {this.sparaId,
      this.sparaName,
      this.sparaPrice,
      this.sparaVersion,
      this.sparaImage,
      this.sparaAdmin});

  SparaModel.fromJson(Map<String, dynamic> json) {
    sparaId = json['spara_id'];
    sparaName = json['spara_name'];
    sparaPrice = json['spara_price'];
    sparaVersion = json['spara_version'];
    sparaImage = json['spara_image'];
    sparaAdmin = json['spara_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spara_id'] = this.sparaId;
    data['spara_name'] = this.sparaName;
    data['spara_price'] = this.sparaPrice;
    data['spara_version'] = this.sparaVersion;
    data['spara_image'] = this.sparaImage;
    data['spara_admin'] = this.sparaAdmin;
    return data;
  }
}
