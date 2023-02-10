import 'dart:convert';

import 'package:amanah_furniture/model/product_all_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  Future getALlProduct() async {
    const url =
        "http://amanahfurniture.space/api/produk";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        AllProduct model =
        AllProduct.fromJson(json.decode(response.body));
        print(model);
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

}