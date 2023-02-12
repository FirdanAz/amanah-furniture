import 'dart:convert';
import 'dart:io';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/model/product_all_model.dart';
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

  Future postLogin(BuildContext context, String email, String password) async {
    const endPoint = '/login';
    final url = '$_baseUrl$endPoint';
    final body = {
      'email': email,
      'password': password,
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
}
