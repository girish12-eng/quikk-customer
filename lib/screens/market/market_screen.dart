import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/controller/market_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:quikk_customer/screens/cart_screen.dart';
import 'package:quikk_customer/screens/market/search_product_scren.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';
import 'package:quikk_customer/widgets/custom_market_item_shimmer.dart';
import 'package:quikk_customer/widgets/custom_market_screen_shimmer.dart';
import 'package:quikk_customer/widgets/custom_product_card.dart';
import 'package:quikk_customer/models/market_model.dart';

class MarketScreen extends StatefulWidget {
  static const id = 'MarketScreen';
  final MarketModel shop;

  const MarketScreen({Key? key, required this.shop}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  Color textColor = Colors.transparent;
  Color shoppingCart = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MarketScreenController>(context, listen: false)
        .init(widget.shop.id.toString());

    // widget.shop.marketType == 1
    //     ? Provider.of<CartController>(context, listen: false)
    //         .setPackagingCharge(widget.shop.packageCharge!)
    //     : Provider.of<CartController>(context, listen: false)
    //         .setPackagingCharge('0.0');

    // Provider.of<CartController>(context, listen: false)
    //     .setMarketType(widget.shop.marketType!);
    Provider.of<MarketScreenController>(context, listen: false)
        .getMarketCategory(widget.shop.id.toString());


  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Provider.of<MarketScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchProductScreen(
                  marketId: widget.shop.id!,
                  marketType: widget.shop.marketType!,
                  packagingCharge: widget.shop.packageCharge!,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: controller.getLoading
            ? CustomMarketScreenShimmer()
            : Stack(
                children: [
                  CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      // SliverAppBar(
                      //   pinned: true,
                      //   leading: CustomBackButton(),
                      //   actions: [
                      //     GestureDetector(
                      //       onTap: () => pushNewScreen(
                      //         context,
                      //         screen: CartScreen(),
                      //         // withNavBar: true,
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 8),
                      //         child: Container(
                      //           padding: EdgeInsets.all(
                      //             8,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             color: Colors.black,
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: Stack(
                      //             alignment: Alignment.center,
                      //             children: [
                      //               Icon(Icons.shopping_cart_rounded),
                      //               Positioned(
                      //                 top: 0,
                      //                 right: 0,
                      //                 child: CircleAvatar(
                      //                   backgroundColor: Colors.black,
                      //                   radius: 8,
                      //                   child: Center(
                      //                     child: Text(
                      //                       '${Provider.of<CartController>(context).getCart.length}',
                      //                       style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 10,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      //   expandedHeight: 200,
                      //   flexibleSpace: FlexibleSpaceBar(
                      //     title: Text(
                      //       widget.shop.name!,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline6!
                      //           .copyWith(color: textColor),
                      //     ),
                      //     background: Image.network(
                      //       widget.shop.image!,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, bottom: 8),
                              child: Text(
                                widget.shop.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                widget.shop.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                widget.shop.address!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Container(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.getMarketCategories!.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () {
                                      Future.delayed(
                                              Duration(milliseconds: 400))
                                          .then((value) {
                                        controller.onCategoryButtonPressed(
                                          widget.shop.id.toString(),
                                          controller.getMarketCategories![index]
                                              .categoryId
                                              .toString(),
                                          index,
                                        );
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: controller.getSelectedCat == null
                                            ? Colors.transparent
                                            : controller.getSelectedCat == index
                                                ? Colors.black12
                                                : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            controller
                                                .getMarketCategories![index]
                                                .name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'All products',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                widget.shop.marketType == 1
                                    ? Row(
                                        children: [
                                          Switch(
                                            activeColor:
                                                Color(Constant.KPrimaryColor),
                                            value: controller.getIsVeg,
                                            onChanged: (v) {
                                              controller.toggleIsVeg();
                                            },
                                          ),
                                          Text('Veg')
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      controller.getLoading || controller.getCatProductLoading
                          ? SliverToBoxAdapter(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height,
                                  child: CustomMarketItemShimmer()),
                            )
                          : controller.getIsVeg
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (_, index) {
                                    return CustomProductCard(
                                      product: controller.getProducts![index],
                                      shopId: widget.shop.id!,
                                      isVeg: controller.getIsVeg,
                                      marketType: widget.shop.marketType!,
                                      packCharge: widget.shop.marketType == 1
                                          ? widget.shop.packageCharge!
                                          : '0.0'
                                    );
                                  },
                                      childCount: controller.getProducts!.length),
                                )

                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (_, index) {
                                    return CustomProductCard(
                                      product: controller.getProducts![index],
                                      shopId: widget.shop.id!,
                                      marketType: widget.shop.marketType!,
                                      packCharge: widget.shop.marketType == 1
                                          ? widget.shop.packageCharge ?? '0.0'
                                          : '0.0',
                                    );
                                  },
                                      childCount: controller.getProducts!.length),
                                ),
                      widget.shop.fssai != null
                          ? SliverToBoxAdapter(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Constant.KAsset + 'fsaai_icon.png',
                                      width: MediaQuery.of(context).size.width *
                                          .2,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      widget.shop.fssai ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black38,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'The pictures displayed on the menu may differ from the original picture of the product.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.black38,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'The product delivered may vary from the product displayed on the menu bar.Prices of items in this menu are managed by the store.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.black38,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SliverToBoxAdapter(),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .4,
                        ),
                      ),
                    ],
                  ),
                  Provider.of<CartController>(context).getCart.length < 1
                      ? SizedBox()
                      : Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => pushNewScreen(
                              context,
                              screen: CartScreen(
                                isFromMarket: true,
                              ),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            ),
                            child: Container(
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Color(Constant.KPrimaryColor),
                                // border: Border.all(color: Colors.black38),
                                boxShadow: [
                                  BoxShadow(
                                    // color: Color(Constant.KPrimaryColor),
                                    color: Colors.black38,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        Constant.KCurrency +
                                            '${Provider.of<CartController>(context).getSubtotal}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'plus delivery charges',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.shopping_cart_rounded,
                                          color: Colors.white,
                                        ),
                                        Provider.of<CartController>(context)
                                                    .getCart
                                                    .length ==
                                                0
                                            ? SizedBox()
                                            : Positioned(
                                                right: 0,
                                                top: 0,
                                                child: CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor: Colors.black,
                                                  child: Text(
                                                    Provider.of<CartController>(
                                                            context)
                                                        .getCart
                                                        .length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
