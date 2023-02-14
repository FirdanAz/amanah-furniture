class AllProduct {
  bool? success;
  String? message;
  List<Data>? data;

  AllProduct({this.success, this.message, this.data});

  AllProduct.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? kategoriId;
  String? namaBarang;
  int? harga;
  String? gambarBarang;

  Data(
      {this.id,
        this.kategoriId,
        this.namaBarang,
        this.harga,
        this.gambarBarang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriId = json['kategori_id'];
    namaBarang = json['nama_barang'];
    harga = json['harga'];
    gambarBarang = json['gambar_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori_id'] = this.kategoriId;
    data['nama_barang'] = this.namaBarang;
    data['harga'] = this.harga;
    data['gambar_barang'] = this.gambarBarang;
    return data;
  }
}
