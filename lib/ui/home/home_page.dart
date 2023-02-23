import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/model/product_all_model.dart';
import 'package:amanah_furniture/service/api_service.dart';
import 'package:amanah_furniture/ui/auth/login.dart';
import 'package:amanah_furniture/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllProduct? allProduct;
  bool _isLoad = false;
  int current = 0;
  List<String> items = [
    "All",
    "Chair",
    "Table",
    "Floor",
    "Lamp",
  ];

  Future _getData() async {
    _isLoad = true;
    AllProduct product = await ApiService().getALlProduct();
    setState(() {
      allProduct = product;
    });
    print(await PublicFunction.getToken());
    print(allProduct);
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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 30,
        foregroundColor: Colors.transparent,
      ),
      body: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 10, left: 25, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Best Furnitire",
                          style: GoogleFonts.poppins(
                              color: ColorApp.accent,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                      Text("Selamat Pagi, User",
                          style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72.6),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 260.w,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search,
                                          size: 22.w, color: ColorApp.accent),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      const Text(
                                        "Search",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0x99303841)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () async =>
                                  await PublicFunction.removeToken('token')
                                      .then((value) => PublicFunction
                                          .navigatorPushAndRemoved(
                                              context, const LoginPage())),
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
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            current = index;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.all(5),
                                          width: 55,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: current == index
                                                ? ColorApp.accent
                                                : Colors.white54,
                                            borderRadius: current == index
                                                ? BorderRadius.circular(15)
                                                : BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              items[index],
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: current == index
                                                      ? Colors.white
                                                      : Colors.black45),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: _isLoad == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allProduct!.data!.length,
                        itemBuilder: (context, index) {
                          final item = allProduct!.data![index];
                          final formartter = NumberFormat.simpleCurrency(
                              decimalDigits: 0, locale: 'id_ID');
                          var nilai = item.harga;
                          var rupiah = formartter.format(nilai);

                          return Container(
                            // cardprodukyWb (690:98)
                            margin: EdgeInsets.fromLTRB(
                                14 * fem, 0 * fem, 14 * fem, 20 * fem),
                            width: double.infinity,
                            height: 120 * fem,
                            child: Container(
                              child: InkWell(
                                hoverColor: Colors.blue,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: item.id),));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      // rectangle588fPR (690:99)
                                      left: 0 * fem,
                                      right: 0 * fem,
                                      top: 20 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 300 * fem,
                                          height: 100 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10 * fem),
                                              border: Border.all(
                                                  color: Color(0xffeeeeee)),
                                              color: Color(0xffffffff),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x19000000),
                                                  offset:
                                                      Offset(0 * fem, 10 * fem),
                                                  blurRadius: 10 * fem,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // group73hqu (690:100)
                                      left: 15 * fem,
                                      top: 0 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(3.39 * fem,
                                            16.41 * fem, 3.39 * fem, 12.84 * fem),
                                        width: 83 * fem,
                                        height: 105 * fem,
                                        decoration: BoxDecoration(
                                          color: Color(0xffeeeeee),
                                          borderRadius:
                                              BorderRadius.circular(5 * fem),
                                        ),
                                        child: Center(
                                          // kursiremovebgpreview1mKy (690:102)
                                          child: SizedBox(
                                            width: 76.22 * fem,
                                            height: 75.75 * fem,
                                            child: Image.network(
                                              'http://amanahfurniture.space/images/${item.gambarBarang}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // kursisedangpremiumFW3 (690:103)
                                      left: 107 * fem,
                                      top: 35 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 115 * fem,
                                          height: 15 * fem,
                                          child: Text(
                                            item.namaBarang.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5 * ffem / fem,
                                              color: Color(0xff797979),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   // loremipsumissimplydummytextoft (690:104)
                                    //   left: 107 * fem,
                                    //   top: 55 * fem,
                                    //   child: Align(
                                    //     child: SizedBox(
                                    //       width: 146 * fem,
                                    //       height: 21 * fem,
                                    //       child: Text(
                                    //         item.deskripsiBarang.toString(),
                                    //         style: GoogleFonts.poppins(
                                    //           fontSize: 7 * ffem,
                                    //           fontWeight: FontWeight.w400,
                                    //           height: 1.5 * ffem / fem,
                                    //           color: Color(0xff6f6f6f),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Positioned(
                                      // rp500000kbD (690:105)
                                      left: 107 * fem,
                                      top: 90 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 59 * fem,
                                          height: 15 * fem,
                                          child: Text(
                                            rupiah,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5 * ffem / fem,
                                              color: Color(0xffe0c28d),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
