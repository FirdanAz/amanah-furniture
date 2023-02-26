import 'dart:convert';
import 'dart:io';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/model/keranjang_model.dart';
import 'package:amanah_furniture/model/product_all_model.dart';
import 'package:amanah_furniture/model/product_detail_model.dart';
import 'package:amanah_furniture/model/user_model.dart';
import 'package:amanah_furniture/ui/widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = "http://amanahfurniture.space/api";

  Future getALlProduct() async {
    const endPoint = '/produk';
    final url = '$_baseUrl$endPoint';

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        AllProduct model = AllProduct.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDetail(int id) async {
    var endPoint = '/produk/$id';
    final url = '$_baseUrl$endPoint';

    try {
      final response = await http.get(Uri.parse(url));
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        DetailModel model = DetailModel.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postLogin(BuildContext context, String email, String password) async {
    const endPoint = '/login';
    final url = '$_baseUrl$endPoint';
    final body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        String token = json.decode(response.body)['access_token'];
        print(token);
        await PublicFunction.setToken(token);
        return true;
      } else {
        showSnackBar(
          context,
          content: const Text('Email atau Password salah'),
          color: Colors.red,
        );
        return false;
      }
    } on SocketException {
      showSnackBar(context,
          content: const Text('Tidak koneksi Internet'), color: Colors.red);
      return false;
    } on HttpException {
      showSnackBar(context,
          content: const Text('HttpException'), color: Colors.red);
      return false;
    }
  }

  Future postRegister({
    required BuildContext context,
    required String username,
    required String email,
    required String alamat,
    required String telepon,
    required String password,
  }) async {
    const endPoint = '/register';
    final url = '$_baseUrl$endPoint';
    final body = {
      'username': username,
      'email': email,
      'password': password,
      'alamat': alamat,
      'no_hp': telepon,
    };

    try {
      final response = await http.post(Uri.parse(url), body: body);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        String token = json.decode(response.body)['access_token'];
        print(token);
        await PublicFunction.setToken(token);
        return true;
      } else {
        // String errorMessage = json.decode(response.body)['erorr'];
        // print(errorMessage);
        showSnackBar(
          context,
          content: const Text('Email / Nomor telepon sudah terdaftar'),
          color: Colors.red,
        );
        return false;
      }
    } on SocketException {
      showSnackBar(context,
          content: const Text('Tidak koneksi Internet'), color: Colors.red);
      return false;
    } on HttpException {
      showSnackBar(context,
          content: const Text('HttpException'), color: Colors.red);
      return false;
    }
  }
  
  Future postKeranjang({
    required BuildContext context,
    required String barang_id,
    required String nama_barang,
    required String harga,
    required String jumlah,
    required String total_harga,
  }) async {
    var endPoint = '/keranjang/tambah/$barang_id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken();
    final body = {
      'barang_id': barang_id,
      'nama_barang': nama_barang,
      'harga': harga,
      'jumlah': jumlah,
      'total_harga': total_harga
    };
    final headers = {
      'Authorization' : 'Bearer $token'
    };

    try {
      final response = await http.post(Uri.parse(url.toString()), body: body, headers: headers);
      print('status code : ${response.statusCode}');
      if(response.statusCode == 200){
        print('sukses!!');
        showSnackBar(context,
            content: const Text('Ditambahkan'), color: ColorApp.accent);
      } if (response.statusCode == 409){
        print('Barnag sudah ada');
        showSnackBar(context,
            content: const Text('Barang Sudah ada'), color: ColorApp.accent);
      }
      else {

      }
    }  on SocketException {
      showSnackBar(context,
          content: const Text('Tidak koneksi Internet'), color: Colors.red);
    } on HttpException {
      showSnackBar(context,
          content: const Text('HttpException'), color: Colors.red);;
    }
  }

  Future getKeranjang() async {
      const endPoint = '/keranjang';
      final url = '$_baseUrl$endPoint';

      var jsonResponse;
      try{
        var response = await http.get(Uri.parse(url),
            headers: {
              'Content-Type' : 'application/json; charset=UTF-8',
              'Authorization' : 'Bearer ${await PublicFunction.getToken()}'
            }
        );
        if(response.statusCode == 200){
          jsonResponse = await json.decode(response.body);
          KeranjangModel keranjangModel = KeranjangModel.fromJson(json.decode(response.body));
          print(jsonResponse);
          return keranjangModel;
        }
      } catch(e) {
        print(e.toString());
      }
  }
  Future deleteKeranjang({required String id,}) async {
    var endPoint = '/keranjang/hapus/$id';
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken();
    final headers = {
      'Authorization' : 'Bearer $token'
    };
    try{
      var response = await http.delete(Uri.parse(url),
          headers: headers
      );
      if(response.statusCode == 200){
        print('delete sukses');
      }
    } catch(e) {
      print(e.toString());
      }
  }
  
  Future getUser(BuildContext context) async {
    const endPoint = "/user";
    final url = '$_baseUrl$endPoint';
    String token = await PublicFunction.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else {
        showSnackBar(
          context,
          content: const Text('Terjadi kesalahan, Silahkan Coba lagi!'),
          color: Colors.red,
        );
        return;
      }
    } on SocketException {
      showSnackBar(context,
          content: const Text('Tidak koneksi Internet'), color: Colors.red);
      return;
    } on HttpException {
      showSnackBar(context,
          content: const Text('HttpException'), color: Colors.red);
      return;
    }
  }
}
