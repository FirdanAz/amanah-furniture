import 'package:amanah_furniture/common/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/assets.dart';
import '../../common/public_function.dart';
import '../../model/product_all_model.dart';
import '../../model/product_detail_model.dart';
import '../../service/api_service.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.id}) : super(key: key);
  int? id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoad = false;
  DetailModel? detailModel;
  AllProduct? allProduct;

  Future _getData() async {
    _isLoad = true;
    DetailModel product = await ApiService().getDetail(widget.id!.toInt());
    setState(() {
      detailModel = product;
    });
    print(await PublicFunction.getToken());
    AllProduct products = await ApiService().getALlProduct();
    setState(() {
      allProduct = products;
    });
    print(await PublicFunction.getToken());
    print(allProduct);
    _isLoad = false;
  }

  rupiah(var nilai) {
    final formartter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: 'id_ID');
    var rupiah = formartter.format(nilai);
    return rupiah;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoad ? Scaffold(body: Center(child: CircularProgressIndicator(color: ColorApp.accent),),) : Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          width: double.maxFinite,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 40,
                    color: ColorApp.accent,
                    child: Center(
                      child: Text(
                        'Order Sekarng',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Ink(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: ColorApp.accent,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                            SvgAssets.vectorKeranjang),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 330,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ColorApp.secondary),
            elevation: 0,
            backgroundColor: Colors.blue,
            leading: InkWell(child: Icon(Icons.arrow_back_ios_new, color: ColorApp.accent), onTap: () => Navigator.pop(context),),
            flexibleSpace: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.network(
                'http://amanahfurniture.space/images/${detailModel!.data!.gambarBarang}',
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  ),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    '${detailModel!.data!.namaBarang}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorApp.accent
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 10,top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: allProduct!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var item = allProduct!.data![index];
                        return Container(
                          margin: EdgeInsets.only(
                              left: 10
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: item.id),)),
                            child: Image.network(
                              'http://amanahfurniture.space/images/${item.gambarBarang}',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${detailModel!.data!.deskripsiBarang}',
                    style: GoogleFonts.poppins(
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    '${detailModel!.data!.namaBarang}',
                    style: GoogleFonts.poppins(
                        color: Colors.black54
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '${rupiah(detailModel!.data!.harga!)}',
                    style: GoogleFonts.poppins(
                      color: ColorApp.accent,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
