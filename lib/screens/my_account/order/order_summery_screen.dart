import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/order_model.dart';
import 'package:quikk_customer/screens/my_account/order/track_order_screen.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummeryScreen extends StatelessWidget {
  final OrderModel order;

  const OrderSummeryScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(order.deliveryBoyTempDate);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(
          'Order Summary',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.al
                  ),
              onPressed: () {
                print(order.status);
                print(order.statusName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackOrderScreen(
                      status: order.status!,
                      statusName: order.statusName!,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              label: Text('Track'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ${json.decode(order.misc!)['order_code']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'OTP : ${order.otp}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          order.items![0].shop!.name!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black45,
                                  ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // Text(
                        //   'Payment method',
                        //   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        // Text(
                        //   'Cash on Delivery',
                        //   style: Theme.of(context).textTheme.caption!.copyWith(
                        //         color: Colors.black45,
                        //       ),
                        // ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Address',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          order.address!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black45,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Items',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: ListView.builder(
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    // tileColor: Colors.black12,
                                    leading: Image.network(
                                      order.items![index].product!.image!,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                        '${order.items![index].product!.name!} x ${order.items![index].quantity!}'),
                                    // subtitle: Text(order.items![index].product!!),
                                    trailing: Text(Constant.KCurrency +
                                        '${double.parse(order.items![index].unitPrice!) - double.parse(order.items![index].discountedPrice!)}'),
                                    subtitle:
                                  order.items![index].product!.qty==null?
                                     SizedBox()
                                    :Text(order.items![index].product!.qty.toString(),
                                    ),
                                  ),
                                );
                              },
                              itemCount: order.items!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                order.deliveryBoyId == null || order.deliveryBoyId == 'null'
                    ? SizedBox()
                    : Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery By',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      print('sas');
                                      String url =
                                          'tel:${order.deliveryBoyContact}';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          order.deliveryBoyName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: Icon(
                                            Icons.phone,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: Image.asset(Constant.KAsset +
                                        'delivery_boi_icon.png'),
                                  )
                                ],
                              ),
                              order.deliveryBoyTempDate == 'null' ||
                                      order.deliveryBoyTempDate == null ||
                                      order.deliveryBoyTemp == 'null' ||
                                      order.deliveryBoyTemp == null
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Last temperature check at ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: Colors.black45,
                                                  ),
                                            ),
                                            Text(
                                              '${DateFormat(' hh:mm a').format(
                                                DateTime.parse(
                                                    order.deliveryBoyTempDate!),
                                              )} ${order.deliveryBoyTemp}°C',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        order.deliveryBoyIsVaccinated == '1'
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      Constant.KPrimary1Color,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'Vaccinated',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: Theme.of(context).textTheme.subtitle1!,
                            ),
                            Text(
                              Constant.KCurrency + '${order.subTotal}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery fee',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              Constant.KCurrency + '${order.deliveryCharge}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax & charges',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              Constant.KCurrency +
                                  '${double.parse(order.tax!) + double.parse(order.packagingCharges!)}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        double.parse(order.discount!) == 0
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Promo',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    '-' +
                                        Constant.KCurrency +
                                        '${double.parse(order.discount!)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 4,
                        ),
                        double.parse(order.burnCoinAmount!) == 0
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quikk Coins',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    '-' +
                                        Constant.KCurrency +
                                        '${double.parse(order.burnCoinAmount!)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              Constant.KCurrency + '${order.total}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
