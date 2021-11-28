import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/order_history_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/order_model.dart';
import 'package:quikk_customer/screens/my_account/order/order_summery_screen.dart';

class CustomOrderHistoryCard extends StatelessWidget {
  final OrderModel order;

  const CustomOrderHistoryCard({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black38,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () => pushNewScreen(
                  context,
                  screen: OrderSummeryScreen(
                    order: order,
                  ),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Sun ,14 May,2021',
                          order.createdAtConvert.toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Row(
                          children: [
                            Text(
                              Constant.KCurrency + '${order.total}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.items![0].shop!.name!),
                        Text(
                          'OTP : ${order.otp}',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(order.items![0].shop!.address!,
                          // overflow: TextOverflow.ellipsis,
                        )),
                        Text('Status : ${order.statusName}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Order #5678768',
                          'Order ${json.decode(order.misc!)['order_code']}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black45,
                                  ),
                        ),
                        Row(
                          children: [
                            Text('Payment Status : '),
                            Text(
                              order.paymentStatusName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: order.paymentStatusName! == 'Unpaid'
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 16,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Text(
                              order.items!
                                  .map((e) => e.product!.name)
                                  .toString(),
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            order.statusName!.contains("Completed")?
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      order.rating != 'null' ? 'You rated' : 'Rate Order',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    order.rating != 'null'
                        ? RatingBarIndicator(
                            rating: double.parse(order.rating!),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 24.0,
                            direction: Axis.horizontal,
                          )
                        : RatingBar.builder(
                            minRating: 1,
                            allowHalfRating: true,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 24,
                            direction: Axis.horizontal,
                            onRatingUpdate: (double value) {
                              Provider.of<OrderHistoryController>(context,
                                      listen: false)
                                  .setOrderRating(
                                order.id.toString(),
                                value.toString(),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}
