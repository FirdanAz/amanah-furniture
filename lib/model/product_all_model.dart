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
  String? slug;
  int? harga;
  String? deskripsiBarang;
  String? gambarBarang;
  String? gambarDetailBarang;
  Null? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
        this.kategoriId,
        this.namaBarang,
        this.slug,
        this.harga,
        this.deskripsiBarang,
        this.gambarBarang,
        this.gambarDetailBarang,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriId = json['kategori_id'];
    namaBarang = json['nama_barang'];
    slug = json['slug'];
    harga = json['harga'];
    deskripsiBarang = json['deskripsi_barang'];
    gambarBarang = json['gambar_barang'];
    gambarDetailBarang = json['gambar_detail_barang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori_id'] = this.kategoriId;
    data['nama_barang'] = this.namaBarang;
    data['slug'] = this.slug;
    data['harga'] = this.harga;
    data['deskripsi_barang'] = this.deskripsiBarang;
    data['gambar_barang'] = this.gambarBarang;
    data['gambar_detail_barang'] = this.gambarDetailBarang;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
