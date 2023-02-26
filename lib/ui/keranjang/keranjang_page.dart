import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/model/keranjang_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../service/api_service.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool _isLoad = false;
  KeranjangModel? keranjangModel;

  Future _getData() async {
    _isLoad = true;
    KeranjangModel keranjang = await ApiService().getKeranjang();
    setState(() {
      keranjangModel = keranjang;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: ColorApp.accent,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: keranjangModel!.data!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ApiService().deleteKeranjang(id: keranjangModel!.data![index].id.toString());
              },
              child: ListTile(
                title: Text('${keranjangModel!.data![index].namaBarang}'),
                leading: Icon(Icons.card_travel_outlined),
              ),
            );
          },
        ),
      ),
    );
  }
}
