import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/model/keranjang_model.dart';
import 'package:amanah_furniture/model/product_detail_model.dart';
import 'package:amanah_furniture/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
    return _isLoad ? Scaffold(body: Center(child: CircularProgressIndicator(color: ColorApp.accent,),),) : Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: ColorApp.secondary,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          width: double.maxFinite,
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 260,
              height: 40,
              margin: EdgeInsets.all(5),
              color: ColorApp.accent,
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: keranjangModel!.data!.length,
          itemBuilder: (context, index) {
            var item = keranjangModel!.data![index];
            final formartter = NumberFormat.simpleCurrency(
                decimalDigits: 0, locale: 'id_ID');
            var nilai = item.harga;
            var rupiah = formartter.format(nilai);
            return Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.1))
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: item.barangId),));
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Container(
                    height: 90,
                    child: ListTile(
                      onTap: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: item.barangId,),));
                      },
                      leading: Container(
                        width: 100,
                        height: 200,
                        child: Image.network(
                          ('http://amanahfurniture.space/images/${item.gambarBarang}'),
                          fit: BoxFit.fitHeight,
                          errorBuilder:
                              (BuildContext context, Object exception, StackTrace? stackTrace) {
                            // Appropriate logging or analytics, e.g.
                            // myAnalytics.recordError(
                            //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                            //   exception,
                            //   stackTrace,
                            // );
                            return const Icon(Icons.image_not_supported, color: ColorApp.accent,);
                          },
                        ),
                      ),
                      title: Text(item.namaBarang.toString(), style: TextStyle(fontSize: 16, color: Colors.black),),
                      subtitle: Text('$rupiah'),
                      trailing: IconButton(onPressed: () {
                        ApiService().deleteKeranjang(context: context, id: item.id.toString());
                      }, icon: Icon(Icons.delete, color: Colors.red,)),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
