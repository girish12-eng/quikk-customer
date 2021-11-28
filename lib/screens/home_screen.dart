import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/home_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/all_category_pages.dart';
import 'package:quikk_customer/widgets/custom_home_screen_shimmer.dart';
import 'package:quikk_customer/widgets/custom_market_card_2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeScreenController>(context);
    print(MediaQuery.of(context).size.aspectRatio);
    return SafeArea(
      child: controller.loading
          ? CustomHomeScreenShimmer()
          : Scaffold(
              // appBar: AppBar(
              //   shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //   ),
              //   leading: SizedBox(),
              //   elevation: 6,
              //   flexibleSpace: GestureDetector(
              //     onTap: () => controller.openBottomSheet(context),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Icon(Icons.location_on,color: Colors.red,size: 26,),
              //             SizedBox(width: 3,),
              //             SizedBox(
              //               width:
              //                   MediaQuery.of(context).size.width * .75,
              //               child: Text(
              //                 controller.address ?? '',
              //                 overflow: TextOverflow.ellipsis,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .headline6!
              //                     .copyWith(
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         IconButton(
              //           onPressed: () => controller.goToSearchScreen(context),
              //           icon: Icon(Icons.search),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              body: SafeArea(
                child: SmartRefresher(
                  controller: controller.getRefreshController,
                  onRefresh: () async {
                    // await Future.delayed(Duration(seconds: 4));
                    controller.init().then(
                          (value) => controller.getRefreshController
                              .refreshCompleted(),
                        );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        locationContainer(controller),
                        carouselContainer(controller),
                        SizedBox(height: 20,),
                        categoryRowContainer(controller),
                        SizedBox(height: 10,),
                        categoryContainer(controller),
                        // Container(
                        //   padding: const EdgeInsets.all(12.0),
                        //   height: 180,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: controller.getCategories.length > 7
                        //           ? 7
                        //           : controller.getCategories.length,
                        //       itemBuilder: (context,index){
                        //     return InkWell(
                        //       onTap: () {
                        //         Future.delayed(
                        //             Duration(milliseconds: 400))
                        //             .then(
                        //               (value) =>
                        //               controller.getShopsByCategory(
                        //                 controller.getCategories[index].id
                        //                     .toString(),
                        //               ),
                        //         );
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(right: 10.0),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               border: Border.all(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(16.0),
                        //           ),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               ClipRRect(
                        //                 borderRadius: BorderRadius.circular(16.0),
                        //                 // child: Image.asset("assets/images/snacks.jpeg",
                        //                 //   height: 120,width: 120,
                        //                 // fit: BoxFit.cover,)
                        //               child: Image.network(
                        //                   controller
                        //                       .getCategories[index]
                        //                       .image!,
                        //                   fit: BoxFit.cover,
                        //                   height: 120,
                        //                 ),
                        //               ),
                        //               SizedBox(height: 10,),
                        //               Text(
                        //                 controller
                        //                     .getCategories[index].name!,
                        //                 textAlign: TextAlign.center,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .caption!
                        //                     .copyWith(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.black,
                        //                 ),
                        //               )
                        //
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // ),
                        // SizedBox(height: 30,),
                        // SizedBox(
                        //   height: 100,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (_, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(left: 8),
                        //         child: Container(
                        //           color: Colors.white,
                        //           child: Material(
                        //             color: Colors.transparent,
                        //             child: InkWell(
                        //               splashFactory: InkRipple.splashFactory,
                        //               borderRadius: BorderRadius.circular(16),
                        //               onTap: () {
                        //                 Future.delayed(
                        //                     Duration(milliseconds: 400))
                        //                     .then(
                        //                       (value) =>
                        //                       controller.getShopsByCategory(
                        //                         controller.getCategories[index].id
                        //                             .toString(),
                        //                       ),
                        //                 );
                        //               },
                        //               child: Container(
                        //                 padding: EdgeInsets.only(
                        //                   left: 4,
                        //                   right: 4,
                        //                   bottom: 4,
                        //                 ),
                        //                 width: 100,
                        //                 decoration: BoxDecoration(
                        //                   // color: Colors.white,
                        //                   border:
                        //                   Border.all(color: Colors.black12),
                        //                   borderRadius: BorderRadius.circular(16),
                        //                 ),
                        //                 child: Column(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //                   crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: [
                        //                     Container(
                        //                       width: 75,
                        //                       height: 75,
                        //                       // color: Colors.red,
                        //                       child: AspectRatio(
                        //                         aspectRatio: 1 / 1,
                        //                         child: ClipRRect(
                        //                           borderRadius:
                        //                           BorderRadius.circular(8),
                        //                           child: Image.network(
                        //                             controller
                        //                                 .getCategories[index]
                        //                                 .image!,
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       controller
                        //                           .getCategories[index].name!,
                        //                       textAlign: TextAlign.center,
                        //                       overflow: TextOverflow.ellipsis,
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .caption!
                        //                           .copyWith(
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.black,
                        //                       ),
                        //                     )
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     itemCount: controller.getCategories.length > 7
                        //         ? 7
                        //         : controller.getCategories.length,
                        //   ),
                        // ),
                        // SizedBox(height: 30,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Coupons For You',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .headline6!
                        //           .copyWith(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     // TextButton(
                        //     //   onPressed: () {},
                        //     //   child: Text('view all'),
                        //     // ),
                        //   ],
                        // ),
                        // SizedBox(height: 30,),
                        // Container(
                        //   height: 140,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (_, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(left: 16),
                        //         child: GestureDetector(
                        //           onTap: () {
                        //             // Fluttertoast.showToast(
                        //             //   msg: controller
                        //             //       .getCoupon[index].description!,
                        //             // );
                        //             showModalBottomSheet(
                        //               context: context,
                        //               builder: (_) => Container(
                        //                 padding: EdgeInsets.symmetric(
                        //                     horizontal: 16),
                        //                 color: Colors.white,
                        //                 height: 240,
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //                   children: [
                        //                     SizedBox(
                        //                       height: 16,
                        //                     ),
                        //                     Text(
                        //                       controller.getCoupon[index].by!,
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .headline4!
                        //                           .copyWith(
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.black,
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 4,
                        //                     ),
                        //                     Text(
                        //                       controller.getCoupon[index]
                        //                           .discountType ==
                        //                           'percent'
                        //                           ? '${controller.getCoupon[index].description} up to ₹${controller.getCoupon[index].maxDiscount}'
                        //                           : '${controller.getCoupon[index].description}',
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .bodyText1!
                        //                           .copyWith(
                        //                         color: Colors.black,
                        //                       ),
                        //                     ),
                        //                     // SizedBox(
                        //                     //   height: 4,
                        //                     // ),
                        //                     Divider(
                        //                       thickness: 1,
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         CircleAvatar(
                        //                           radius: 6,
                        //                           backgroundColor: Colors.green,
                        //                           child: Icon(
                        //                             Icons.check,
                        //                             size: 8,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 4,
                        //                         ),
                        //                         Text(
                        //                           'Minimum order : ${controller.getCoupon[index].minOrder}',
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .caption,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     SizedBox(
                        //                       height: 8,
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         CircleAvatar(
                        //                           radius: 6,
                        //                           backgroundColor: Colors.green,
                        //                           child: Icon(
                        //                             Icons.check,
                        //                             size: 8,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 4,
                        //                         ),
                        //                         Text(
                        //                           'Maximum discount : ${controller.getCoupon[index].maxDiscount}',
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .caption,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     SizedBox(
                        //                       height: 8,
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         CircleAvatar(
                        //                           radius: 6,
                        //                           backgroundColor: Colors.green,
                        //                           child: Icon(
                        //                             Icons.check,
                        //                             size: 8,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 4,
                        //                         ),
                        //                         controller.getCoupon[index]
                        //                             .shopId ==
                        //                             0
                        //                             ? Text(
                        //                           'Applicable on all shops',
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .caption,
                        //                         )
                        //                             : Text(
                        //                           'Applicable only on : ${controller.getCoupon[index].by}',
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .caption,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     SizedBox(
                        //                       height: 8,
                        //                     ),
                        //                     Row(
                        //                       children: [
                        //                         CircleAvatar(
                        //                           radius: 6,
                        //                           backgroundColor: Colors.green,
                        //                           child: Icon(
                        //                             Icons.check,
                        //                             size: 8,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         SizedBox(
                        //                           width: 4,
                        //                         ),
                        //                         Text(
                        //                           'Valid upto : ${DateFormat('yyyy-MM-dd – kk:mm').format(
                        //                             DateTime.parse(controller
                        //                                 .getCoupon[index]
                        //                                 .expiresAt!),
                        //                           )}',
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .caption,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     // Text(
                        //                     //   'Valid on orders with minimum order value of ₹${_coupons[index].minOrder}',
                        //                     //   style: Theme.of(context)
                        //                     //       .textTheme
                        //                     //       .caption!
                        //                     //       .copyWith(
                        //                     //     // color: Colors.black,
                        //                     //   ),
                        //                     // ),
                        //                     // SizedBox(
                        //                     //   height: 8,
                        //                     // ),
                        //                     // Row(
                        //                     //   mainAxisAlignment:
                        //                     //   MainAxisAlignment.spaceBetween,
                        //                     //   children: [
                        //                     //     Container(
                        //                     //       padding: EdgeInsets.symmetric(
                        //                     //           horizontal: 16, vertical: 4),
                        //                     //       decoration: BoxDecoration(
                        //                     //           color: Colors.blue.withOpacity(.1),
                        //                     //           border: Border.all(
                        //                     //             color:
                        //                     //             Colors.blue.withOpacity(.3),
                        //                     //           ),
                        //                     //           borderRadius:
                        //                     //           BorderRadius.circular(4)),
                        //                     //       child: Text(
                        //                     //         '${_coupons[index].code}',
                        //                     //         style: Theme.of(context)
                        //                     //             .textTheme
                        //                     //             .headline6!
                        //                     //             .copyWith(
                        //                     //           // color: Colors.black,
                        //                     //         ),
                        //                     //       ),
                        //                     //     ),
                        //                     //     selectedCoupon == _coupons[index]
                        //                     //         ? TextButton(
                        //                     //       onPressed: () {},
                        //                     //       child: Text('APPLIED'),
                        //                     //     )
                        //                     //         : TextButton(
                        //                     //       onPressed: () {
                        //                     //         var res = checkCouponValidity(
                        //                     //             context, _coupons[index]);
                        //                     //         if (res) {
                        //                     //           setState(() {
                        //                     //             selectedCoupon =
                        //                     //             _coupons[index];
                        //                     //           });
                        //                     //
                        //                     //           Navigator.pop(context);
                        //                     //           Future.delayed(
                        //                     //             Duration(milliseconds: 400),
                        //                     //           ).then(
                        //                     //                 (value) => showDialog(
                        //                     //               context: context,
                        //                     //               builder: (_) =>
                        //                     //                   AlertDialog(
                        //                     //                     content: Column(
                        //                     //                       mainAxisSize:
                        //                     //                       MainAxisSize.min,
                        //                     //                       crossAxisAlignment:
                        //                     //                       CrossAxisAlignment
                        //                     //                           .center,
                        //                     //                       children: [
                        //                     //                         Lottie.asset(Constant
                        //                     //                             .KLottieAsset +
                        //                     //                             'coupon_apply_success.json'),
                        //                     //                         Text(
                        //                     //                           'Coupon Applied',
                        //                     //                           style: Theme.of(
                        //                     //                               context)
                        //                     //                               .textTheme
                        //                     //                               .headline6!
                        //                     //                               .copyWith(
                        //                     //                             color: Colors
                        //                     //                                 .black,
                        //                     //                             fontWeight:
                        //                     //                             FontWeight
                        //                     //                                 .bold,
                        //                     //                           ),
                        //                     //                         ),
                        //                     //                       ],
                        //                     //                     ),
                        //                     //                   ),
                        //                     //             ),
                        //                     //           );
                        //                     //           Future.delayed(
                        //                     //               Duration(seconds: 2))
                        //                     //               .then(
                        //                     //                 (value) =>
                        //                     //                 Navigator.pop(context),
                        //                     //           );
                        //                     //         }
                        //                     //       },
                        //                     //       child: Text('APPLY'),
                        //                     //     )
                        //                     //   ],
                        //                     // )
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //
                        //           child: Container(
                        //             width: 120,
                        //             child: CustomCoupon(
                        //               color: int.parse(
                        //                   'FF${controller.getCoupon[index].color}',
                        //                   radix: 16),
                        //               code: controller.getCoupon[index].code,
                        //               description: controller
                        //                   .getCoupon[index].description,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     itemCount: controller.getCoupon.length,
                        //   ),
                        // ),
                        marketTextRowContainer(controller),
                        SizedBox(height: 20,),
                        controller.getShops.isEmpty
                            ? Center(
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height * .5,
                                child: Center(
                                  child: Text(
                                      'No Shops Available in this location'),
                                ),
                              ),
                            )
                      :  ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.getShops.length,
                            itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8),
                          child: CustomMarketCard2(
                            shop: controller.getShops[index],
                          ),
                        );
                        })


                        //     : SliverPadding(
                        //   padding: EdgeInsets.only(
                        //       left: 16, right: 16, bottom: 32),
                        //   sliver: SliverList(
                        //     delegate: SliverChildBuilderDelegate(
                        //           (_, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 8),
                        //           child: CustomMarketCard2(
                        //             shop: controller.getShops[index],
                        //           ),
                        //         );
                        //       },
                        //       childCount: controller.getShops.length,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )




                  // CustomScrollView(
                  //   physics: BouncingScrollPhysics(),
                  //   slivers: [
                  //     // SliverAppBar(
                  //     //   backgroundColor: Colors.white,
                  //     //   leading: SizedBox(),
                  //     //   flexibleSpace: GestureDetector(
                  //     //     onTap: () => controller.openBottomSheet(context),
                  //     //     child: Padding(
                  //     //       padding: const EdgeInsets.only(
                  //     //         left: 8,
                  //     //       ),
                  //     //       child: Row(
                  //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     //         children: [
                  //     //           Column(
                  //     //             mainAxisAlignment: MainAxisAlignment.center,
                  //     //             crossAxisAlignment: CrossAxisAlignment.start,
                  //     //             children: [
                  //     //               Row(
                  //     //                 children: [
                  //     //                   Icon(Icons.location_on),
                  //     //                   SizedBox(
                  //     //                     width: MediaQuery.of(context)
                  //     //                             .size
                  //     //                             .width *
                  //     //                         .75,
                  //     //                     child: Text(
                  //     //                       controller.address ?? '',
                  //     //                       overflow: TextOverflow.ellipsis,
                  //     //                       style: Theme.of(context)
                  //     //                           .textTheme
                  //     //                           .headline6!
                  //     //                           .copyWith(
                  //     //                             fontWeight: FontWeight.bold,
                  //     //                           ),
                  //     //                     ),
                  //     //                   ),
                  //     //                 ],
                  //     //               ),
                  //     //             ],
                  //     //           ),
                  //     //           IconButton(
                  //     //             onPressed: () {},
                  //     //             icon: Icon(Icons.search),
                  //     //           )
                  //     //         ],
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     //   floating: true,
                  //     // ),
                  //     // SliverPadding(
                  //     //   padding: EdgeInsets.symmetric(
                  //     //     horizontal: 16,
                  //     //   ),
                  //     //   sliver: SliverToBoxAdapter(
                  //     //     child: Text(
                  //     //       'Get your delivery within 1 hour',
                  //     //       style: Theme.of(context).textTheme.headline4!.copyWith(
                  //     //           color: Colors.black, fontWeight: FontWeight.bold),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight2,
                  //       ),
                  //     ),
                  //     // SliverToBoxAdapter(
                  //     //   child: SizedBox(
                  //     //     width: 200.0,
                  //     //     height: 100.0,
                  //     //     child: Shimmer.fromColors(
                  //     //       baseColor: Colors.green,
                  //     //       highlightColor: Colors.yellow,
                  //     //       child: CircleAvatar(
                  //     //
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     SliverPadding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       sliver: SliverToBoxAdapter(
                  //         child: CarouselSlider(
                  //           items: controller.bannerList
                  //               .map(
                  //                 (e) => ClipRRect(
                  //                   borderRadius: BorderRadius.circular(16),
                  //                   child: Image(
                  //                     image: NetworkImage(
                  //                       e.image!,
                  //                     ),
                  //                     fit: BoxFit.fill, // use this
                  //                   ),
                  //                 ),
                  //               )
                  //               .toList(),
                  //           options: CarouselOptions(
                  //             height: 132,
                  //             aspectRatio: 16 / 9,
                  //             viewportFraction: 1,
                  //             initialPage: 0,
                  //             enableInfiniteScroll: true,
                  //             reverse: false,
                  //             autoPlay: true,
                  //             autoPlayInterval: Duration(seconds: 3),
                  //             autoPlayAnimationDuration:
                  //                 Duration(milliseconds: 800),
                  //             autoPlayCurve: Curves.fastOutSlowIn,
                  //             enlargeCenterPage: true,
                  //             // onPageChanged: callbackFunction,
                  //             scrollDirection: Axis.horizontal,
                  //           ),
                  //         ),
                  //
                  //         // child: SizedBox(
                  //         //   height: 132,
                  //         //   child: AspectRatio(
                  //         //     aspectRatio: 16 / 9,
                  //         //     child: ClipRRect(
                  //         //       borderRadius: BorderRadius.circular(16),
                  //         //       child: Image(
                  //         //         image: NetworkImage(
                  //         //             'https://www.quikkstore.com/security/profile/7.png'),
                  //         //         fit: BoxFit.fill, // use this
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //
                  //         // Container(
                  //         //   width: double.infinity,
                  //         //   height: 150,
                  //         //   decoration: BoxDecoration(
                  //         //     color: Colors.black12,
                  //         //     borderRadius: BorderRadius.circular(16),
                  //         //   ),
                  //         //   child: ClipRRect(
                  //         //       borderRadius: BorderRadius.circular(16),
                  //         //       child: Image.asset(
                  //         //         Constant.KAsset+'front33.jpg',
                  //         //         fit: BoxFit.cover,
                  //         //       )),
                  //         // ),
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight1,
                  //       ),
                  //     ),
                  //     SliverPadding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       sliver: SliverToBoxAdapter(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               'Explore by Category',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .headline6!
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //             ),
                  //             controller.getCategories.length < 7
                  //                 ? SizedBox()
                  //                 : TextButton(
                  //                     onPressed: () => pushNewScreen(
                  //                       context,
                  //                       screen: AllCategoryScreen(
                  //                         categories: controller.getCategories,
                  //                       ),
                  //                       withNavBar: false,
                  //                       // OPTIONAL VALUE. True by default.
                  //                       pageTransitionAnimation:
                  //                           PageTransitionAnimation.cupertino,
                  //                     ),
                  //                     child: Text('view all'),
                  //                   ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight2,
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //         child: SizedBox(
                  //       height: 100,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (_, index) {
                  //           return Padding(
                  //             padding: const EdgeInsets.only(left: 8),
                  //             child: Container(
                  //               color: Colors.white,
                  //               child: Material(
                  //                 color: Colors.transparent,
                  //                 child: InkWell(
                  //                   splashFactory: InkRipple.splashFactory,
                  //                   borderRadius: BorderRadius.circular(16),
                  //                   onTap: () {
                  //                     Future.delayed(
                  //                             Duration(milliseconds: 400))
                  //                         .then(
                  //                       (value) =>
                  //                           controller.getShopsByCategory(
                  //                         controller.getCategories[index].id
                  //                             .toString(),
                  //                       ),
                  //                     );
                  //                   },
                  //                   child: Container(
                  //                     padding: EdgeInsets.only(
                  //                       left: 4,
                  //                       right: 4,
                  //                       bottom: 4,
                  //                     ),
                  //                     width: 100,
                  //                     decoration: BoxDecoration(
                  //                       // color: Colors.white,
                  //                       border:
                  //                           Border.all(color: Colors.black12),
                  //                       borderRadius: BorderRadius.circular(16),
                  //                     ),
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.center,
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       children: [
                  //                         Container(
                  //                           width: 75,
                  //                           height: 75,
                  //                           // color: Colors.red,
                  //                           child: AspectRatio(
                  //                             aspectRatio: 1 / 1,
                  //                             child: ClipRRect(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(8),
                  //                               child: Image.network(
                  //                                 controller
                  //                                     .getCategories[index]
                  //                                     .image!,
                  //                                 fit: BoxFit.cover,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Text(
                  //                           controller
                  //                               .getCategories[index].name!,
                  //                           textAlign: TextAlign.center,
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .caption!
                  //                               .copyWith(
                  //                                 fontWeight: FontWeight.bold,
                  //                                 color: Colors.black,
                  //                               ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         itemCount: controller.getCategories.length > 7
                  //             ? 7
                  //             : controller.getCategories.length,
                  //       ),
                  //     )),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight1,
                  //       ),
                  //     ),
                  //     //for coupon uncomment this
                  //     SliverPadding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       sliver: SliverToBoxAdapter(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               'Coupons For You',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .headline6!
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //             ),
                  //             // TextButton(
                  //             //   onPressed: () {},
                  //             //   child: Text('view all'),
                  //             // ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight2,
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: Container(
                  //         height: 140,
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: (_, index) {
                  //             return Padding(
                  //               padding: const EdgeInsets.only(left: 16),
                  //               child: GestureDetector(
                  //                 onTap: () {
                  //                   // Fluttertoast.showToast(
                  //                   //   msg: controller
                  //                   //       .getCoupon[index].description!,
                  //                   // );
                  //                   showModalBottomSheet(
                  //                     context: context,
                  //                     builder: (_) => Container(
                  //                       padding: EdgeInsets.symmetric(
                  //                           horizontal: 16),
                  //                       color: Colors.white,
                  //                       height: 240,
                  //                       child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           SizedBox(
                  //                             height: 16,
                  //                           ),
                  //                           Text(
                  //                             controller.getCoupon[index].by!,
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .headline4!
                  //                                 .copyWith(
                  //                                   fontWeight: FontWeight.bold,
                  //                                   color: Colors.black,
                  //                                 ),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 4,
                  //                           ),
                  //                           Text(
                  //                             controller.getCoupon[index]
                  //                                         .discountType ==
                  //                                     'percent'
                  //                                 ? '${controller.getCoupon[index].description} up to ₹${controller.getCoupon[index].maxDiscount}'
                  //                                 : '${controller.getCoupon[index].description}',
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .bodyText1!
                  //                                 .copyWith(
                  //                                   color: Colors.black,
                  //                                 ),
                  //                           ),
                  //                           // SizedBox(
                  //                           //   height: 4,
                  //                           // ),
                  //                           Divider(
                  //                             thickness: 1,
                  //                           ),
                  //                           Row(
                  //                             children: [
                  //                               CircleAvatar(
                  //                                 radius: 6,
                  //                                 backgroundColor: Colors.green,
                  //                                 child: Icon(
                  //                                   Icons.check,
                  //                                   size: 8,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 4,
                  //                               ),
                  //                               Text(
                  //                                 'Minimum order : ${controller.getCoupon[index].minOrder}',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .caption,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           SizedBox(
                  //                             height: 8,
                  //                           ),
                  //                           Row(
                  //                             children: [
                  //                               CircleAvatar(
                  //                                 radius: 6,
                  //                                 backgroundColor: Colors.green,
                  //                                 child: Icon(
                  //                                   Icons.check,
                  //                                   size: 8,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 4,
                  //                               ),
                  //                               Text(
                  //                                 'Maximum discount : ${controller.getCoupon[index].maxDiscount}',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .caption,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           SizedBox(
                  //                             height: 8,
                  //                           ),
                  //                           Row(
                  //                             children: [
                  //                               CircleAvatar(
                  //                                 radius: 6,
                  //                                 backgroundColor: Colors.green,
                  //                                 child: Icon(
                  //                                   Icons.check,
                  //                                   size: 8,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 4,
                  //                               ),
                  //                               controller.getCoupon[index]
                  //                                           .shopId ==
                  //                                       0
                  //                                   ? Text(
                  //                                       'Applicable on all shops',
                  //                                       style: Theme.of(context)
                  //                                           .textTheme
                  //                                           .caption,
                  //                                     )
                  //                                   : Text(
                  //                                       'Applicable only on : ${controller.getCoupon[index].by}',
                  //                                       style: Theme.of(context)
                  //                                           .textTheme
                  //                                           .caption,
                  //                                     ),
                  //                             ],
                  //                           ),
                  //                           SizedBox(
                  //                             height: 8,
                  //                           ),
                  //                           Row(
                  //                             children: [
                  //                               CircleAvatar(
                  //                                 radius: 6,
                  //                                 backgroundColor: Colors.green,
                  //                                 child: Icon(
                  //                                   Icons.check,
                  //                                   size: 8,
                  //                                   color: Colors.white,
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 4,
                  //                               ),
                  //                               Text(
                  //                                 'Valid upto : ${DateFormat('yyyy-MM-dd – kk:mm').format(
                  //                                   DateTime.parse(controller
                  //                                       .getCoupon[index]
                  //                                       .expiresAt!),
                  //                                 )}',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .caption,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           // Text(
                  //                           //   'Valid on orders with minimum order value of ₹${_coupons[index].minOrder}',
                  //                           //   style: Theme.of(context)
                  //                           //       .textTheme
                  //                           //       .caption!
                  //                           //       .copyWith(
                  //                           //     // color: Colors.black,
                  //                           //   ),
                  //                           // ),
                  //                           // SizedBox(
                  //                           //   height: 8,
                  //                           // ),
                  //                           // Row(
                  //                           //   mainAxisAlignment:
                  //                           //   MainAxisAlignment.spaceBetween,
                  //                           //   children: [
                  //                           //     Container(
                  //                           //       padding: EdgeInsets.symmetric(
                  //                           //           horizontal: 16, vertical: 4),
                  //                           //       decoration: BoxDecoration(
                  //                           //           color: Colors.blue.withOpacity(.1),
                  //                           //           border: Border.all(
                  //                           //             color:
                  //                           //             Colors.blue.withOpacity(.3),
                  //                           //           ),
                  //                           //           borderRadius:
                  //                           //           BorderRadius.circular(4)),
                  //                           //       child: Text(
                  //                           //         '${_coupons[index].code}',
                  //                           //         style: Theme.of(context)
                  //                           //             .textTheme
                  //                           //             .headline6!
                  //                           //             .copyWith(
                  //                           //           // color: Colors.black,
                  //                           //         ),
                  //                           //       ),
                  //                           //     ),
                  //                           //     selectedCoupon == _coupons[index]
                  //                           //         ? TextButton(
                  //                           //       onPressed: () {},
                  //                           //       child: Text('APPLIED'),
                  //                           //     )
                  //                           //         : TextButton(
                  //                           //       onPressed: () {
                  //                           //         var res = checkCouponValidity(
                  //                           //             context, _coupons[index]);
                  //                           //         if (res) {
                  //                           //           setState(() {
                  //                           //             selectedCoupon =
                  //                           //             _coupons[index];
                  //                           //           });
                  //                           //
                  //                           //           Navigator.pop(context);
                  //                           //           Future.delayed(
                  //                           //             Duration(milliseconds: 400),
                  //                           //           ).then(
                  //                           //                 (value) => showDialog(
                  //                           //               context: context,
                  //                           //               builder: (_) =>
                  //                           //                   AlertDialog(
                  //                           //                     content: Column(
                  //                           //                       mainAxisSize:
                  //                           //                       MainAxisSize.min,
                  //                           //                       crossAxisAlignment:
                  //                           //                       CrossAxisAlignment
                  //                           //                           .center,
                  //                           //                       children: [
                  //                           //                         Lottie.asset(Constant
                  //                           //                             .KLottieAsset +
                  //                           //                             'coupon_apply_success.json'),
                  //                           //                         Text(
                  //                           //                           'Coupon Applied',
                  //                           //                           style: Theme.of(
                  //                           //                               context)
                  //                           //                               .textTheme
                  //                           //                               .headline6!
                  //                           //                               .copyWith(
                  //                           //                             color: Colors
                  //                           //                                 .black,
                  //                           //                             fontWeight:
                  //                           //                             FontWeight
                  //                           //                                 .bold,
                  //                           //                           ),
                  //                           //                         ),
                  //                           //                       ],
                  //                           //                     ),
                  //                           //                   ),
                  //                           //             ),
                  //                           //           );
                  //                           //           Future.delayed(
                  //                           //               Duration(seconds: 2))
                  //                           //               .then(
                  //                           //                 (value) =>
                  //                           //                 Navigator.pop(context),
                  //                           //           );
                  //                           //         }
                  //                           //       },
                  //                           //       child: Text('APPLY'),
                  //                           //     )
                  //                           //   ],
                  //                           // )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //                 child: Container(
                  //                   width: 120,
                  //                   child: CustomCoupon(
                  //                     color: int.parse(
                  //                         'FF${controller.getCoupon[index].color}',
                  //                         radix: 16),
                  //                     code: controller.getCoupon[index].code,
                  //                     description: controller
                  //                         .getCoupon[index].description,
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //           itemCount: controller.getCoupon.length,
                  //         ),
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight1,
                  //       ),
                  //     ),
                  //     SliverPadding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16),
                  //       sliver: SliverToBoxAdapter(
                  //         child: Text(
                  //           'All Markets Nearby',
                  //           style:
                  //               Theme.of(context).textTheme.headline6!.copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //         ),
                  //       ),
                  //     ),
                  //     SliverToBoxAdapter(
                  //       child: SizedBox(
                  //         height: Constant.KHeight2,
                  //       ),
                  //     ),
                  //     controller.getShops.isEmpty
                  //         ? SliverToBoxAdapter(
                  //             child: Center(
                  //               child: Container(
                  //                 height:
                  //                     MediaQuery.of(context).size.height * .5,
                  //                 child: Center(
                  //                   child: Text(
                  //                       'No Shops Available in this location'),
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //         : SliverPadding(
                  //             padding: EdgeInsets.only(
                  //                 left: 16, right: 16, bottom: 32),
                  //             sliver: SliverList(
                  //               delegate: SliverChildBuilderDelegate(
                  //                 (_, index) {
                  //                   return Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         vertical: 8),
                  //                     child: CustomMarketCard2(
                  //                       shop: controller.getShops[index],
                  //                     ),
                  //                   );
                  //                 },
                  //                 childCount: controller.getShops.length,
                  //               ),
                  //             ),
                  //           ),
                  //   ],
                  // ),
                ),
              ),
            ),
    );
  }

  Widget carouselContainer(HomeScreenController controller){
    return  CarouselSlider(
      items: controller.bannerList
          .map(
            (e) => ClipRRect(
          child: Image(
            image: NetworkImage(
              e.image!,
            ),
            fit: BoxFit.fill, // use this
          ),
        ),
      )
          .toList(),
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration:
        Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget categoryRowContainer(HomeScreenController controller){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore by Category',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          controller.getCategories.length < 7
              ? SizedBox()
              : TextButton(
            onPressed: () => pushNewScreen(
              context,
              screen: AllCategoryScreen(
                categories: controller.getCategories,
              ),
              withNavBar: false,
              // OPTIONAL VALUE. True by default.
              pageTransitionAnimation:
              PageTransitionAnimation.cupertino,
            ),
            child: Text('view all'),
          ),
        ],
      ),
    );
  }

  Widget locationContainer(HomeScreenController controller){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        children: [
          locationCard(controller),
          searchCard(controller)
        ],
      ),
    );
  }

  Widget locationCard(HomeScreenController controller){
    return  GestureDetector(
      onTap: () => controller.openBottomSheet(context),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        child: Container(
          height: 45,
          width: 45,
          child: Icon(Icons.location_on,color: Color(Constant.KSecondaryColor),),
        ),
      ),
    );
  }

  Widget searchCard(HomeScreenController controller){
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 6),
        height: 45,
        width: MediaQuery.of(context).size.width*.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                controller.address ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
                onPressed: () => controller.goToSearchScreen(context),
                icon: Icon(Icons.search_rounded,color: Color(Constant.KSecondaryColor),))

          ],
        ),
      ),
    );
  }

  Widget categoryContainer(HomeScreenController controller){
    return Container(
      height: 180,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: controller.getCategories.length > 7
                  ? 7
                  : controller.getCategories.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: () {
                Future.delayed(
                    Duration(milliseconds: 400))
                    .then(
                      (value) =>
                      controller.getShopsByCategory(
                        controller.getCategories[index].id
                            .toString(),
                      ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(left:5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Container(
                        height: 120,
                        width: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              controller
                                  .getCategories[index]
                                  .image!,
                              fit: BoxFit.cover,
                              height: 120,
                            ),),

                      ),
                    ),
                    headText(controller.getCategories[index].name!,12.0,FontWeight.w600),
                    headText("Noida",11.0,FontWeight.w400),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget headText(String text,fontSize,fontWeight){
    return Container(
      child: Text(text,style: TextStyle(fontSize: fontSize,fontWeight: fontWeight),),
    );
  }

  Widget marketTextRowContainer(HomeScreenController controller){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            'All Markets Nearby',textAlign: TextAlign.start,
            style:
            Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}
