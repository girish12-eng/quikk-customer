import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/market_model.dart';
import 'package:quikk_customer/models/media.dart';
import 'package:quikk_customer/screens/market/market_screen.dart';

class CustomMarketCard2 extends StatelessWidget {
  final MarketModel shop;

  const CustomMarketCard2({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (shop.currentStatus == 'Yes') {
          Future.delayed(Duration(milliseconds: 400)).then(
            (value) => pushNewScreen(
              context,
              screen: MarketScreen(
                shop: shop,
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'This Market is currently offline');
        }
      },
      child: shop.currentStatus == "Yes"
          ? Card(
        elevation: 6,
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16)
            ),
            child: Container(
                decoration: BoxDecoration(
                    // color: Colors.white,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(16),
                    // ),
                    // border: Border.all(color: Colors.black12)
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffF5F5F5).withOpacity(0.5),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              shop.image!,
                              height: MediaQuery.of(context).size.height * .3,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 8,
                        //   child: Container(
                        //     padding: EdgeInsets.all(4),
                        //     decoration: BoxDecoration(
                        //       color: Color(Constant.KPrimaryColor),
                        //       borderRadius: BorderRadius.only(
                        //         topRight: Radius.circular(8),
                        //         bottomRight: Radius.circular(8),
                        //       ),
                        //     ),
                        //
                        //     width: 100,
                        //     // height: ,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Image.asset(
                        //               Constant.KAsset + 'discount.png',
                        //               width: 12,
                        //               height: 12,
                        //             ),
                        //             SizedBox(
                        //               width: 4,
                        //             ),
                        //             Text(
                        //               '50% OFF',
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .subtitle1!
                        //                   .copyWith(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //             ),
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Positioned(
                        //   right: 8,
                        //   bottom: 8,
                        //   child: Container(
                        //     padding:
                        //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(8)),
                        //     child: Text(
                        //       '1 Hrs',
                        //       style: Theme.of(context).textTheme.caption!.copyWith(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              shop.name!,
                              style:
                                  Theme.of(context).textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          double.parse(shop.rating!) > 0
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: double.parse(shop.rating!) <= 2
                                        ? Colors.red
                                        : double.parse(shop.rating!) > 2 &&
                                                double.parse(shop.rating!) <= 3
                                            ? Colors.deepOrange
                                            : double.parse(shop.rating!) > 3 &&
                                                    double.parse(shop.rating!) <=
                                                        4
                                                ? Colors.lightGreen
                                                : Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        shop.rating!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          shop.description!=null?Text(
                            shop.description!,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.blueGrey[200],
                                    ),
                          ):Container(),
                          Row(
                            children: [
                              Text(
                                '${shop.distance!} kms',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.blueGrey,
                                    ),
                              ),
                              // SizedBox(
                              //   width: 8,
                              // ),
                              // Text(
                              //   '1 Hrs',
                              //   style:
                              //       Theme.of(context).textTheme.caption!.copyWith(
                              //             color: Colors.black38,
                              //           ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        shop.address!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.blueGrey,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
          )
          : Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: <Color>[
                        Colors.grey.withOpacity(.5),
                        Colors.grey.withOpacity(.5),
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        border: Border.all(color: Colors.black12)
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  shop.image!,
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),

                            // shop discount tag
                            // Positioned(
                            //   bottom: 8,
                            //   child: Container(
                            //     padding: EdgeInsets.all(4),
                            //     decoration: BoxDecoration(
                            //       color: Color(Constant.KPrimaryColor),
                            //       borderRadius: BorderRadius.only(
                            //         topRight: Radius.circular(8),
                            //         bottomRight: Radius.circular(8),
                            //       ),
                            //     ),
                            //
                            //     width: 100,
                            //     // height: ,
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Image.asset(
                            //               Constant.KAsset + 'discount.png',
                            //               width: 12,
                            //               height: 12,
                            //             ),
                            //             SizedBox(
                            //               width: 4,
                            //             ),
                            //             Text(
                            //               '50% OFF',
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .subtitle1!
                            //                   .copyWith(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.bold,
                            //                   ),
                            //             ),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  shop.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              double.parse(shop.rating!) > 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: double.parse(shop.rating!) <= 2
                                              ? Colors.red
                                              : double.parse(shop.rating!) >
                                                          2 &&
                                                      double.parse(
                                                              shop.rating!) <=
                                                          3
                                                  ? Colors.deepOrange
                                                  : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        children: [
                                          Text(
                                            shop.rating!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                shop.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.black38,
                                    ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${shop.distance!} kms',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          color: Colors.black38,
                                        ),
                                  ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  // Text(
                                  //   '1 Hrs',
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .caption!
                                  //       .copyWith(
                                  //         color: Colors.black38,
                                  //       ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            shop.address!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black38,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'Offline',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
