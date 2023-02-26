class KeranjangModel {
  bool? success;
  String? message;
  List<Data>? data;

  KeranjangModel({this.success, this.message, this.data});

  KeranjangModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? barangId;
  String? username;
  String? namaBarang;
  int? harga;
  int? jumlah;
  int? totalHarga;

  Data(
      {this.id,
        this.userId,
        this.barangId,
        this.username,
        this.namaBarang,
        this.harga,
        this.jumlah,
        this.totalHarga});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    barangId = json['barang_id'];
    username = json['username'];
    namaBarang = json['nama_barang'];
    harga = json['harga'];
    jumlah = json['jumlah'];
    totalHarga = json['total_harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['barang_id'] = this.barangId;
    data['username'] = this.username;
    data['nama_barang'] = this.namaBarang;
    data['harga'] = this.harga;
    data['jumlah'] = this.jumlah;
    data['total_harga'] = this.totalHarga;
    return data;
  }
}
