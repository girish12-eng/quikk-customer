import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/market/market_screen.dart';
import 'package:quikk_customer/models/market_model.dart';

class CustomMarketCard extends StatelessWidget {
  final MarketModel shop;

  const CustomMarketCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: () => Future.delayed(Duration(milliseconds: 400)).then(
        (value) => pushNewScreen(
          context,
          screen: MarketScreen(
            shop: shop,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.network(
                shop.image!,
                width: 100,
                height: 125,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    shop.description!,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black38,
                        ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${shop.address} | ${shop.distance} kms',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black38,
                        ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(
                        '4.2',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('•'),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '1 hrs',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Constant.KAsset + 'discount.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '40% off',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black38,
                            ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
