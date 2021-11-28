import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';

class CartItemCard extends StatefulWidget {
  final ProductModel product;
  final int quantity;
  final int index;
  final Variationss variation;

  const CartItemCard(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.index,
      required this.variation})
      : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CartController>(context);
    return


    //without variation

    Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        widget.product.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    double.parse(widget.product.discountPrice!) < 1
                        ? SizedBox()
                        : Positioned(
                        top: 2,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(Constant.KPrimaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: widget.variation.name == null?
                            Text(
                              '${(((double.parse(widget.product.discountPrice!)) / double.parse(widget.product.unitPrice!)) * 100).toStringAsFixed(1)} % OFF',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            :Text(
                              '${(((double.parse(widget.variation.discountPrice!)) / double.parse(widget.variation.price!)) * 100).toStringAsFixed(1)} % OFF',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              controller.getMarketType == 1
                                  ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CircleAvatar(
                                  backgroundColor: widget.product.type == 0
                                      ? Colors.green
                                      : Colors.red,
                                  radius: 4,
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Text(
                                  widget.product.name!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    widget.variation.name == null?
                    SizedBox():
                        Text(
                      widget.variation.name!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.red,
                        letterSpacing: 0.5,
                      ),
                    ),
                    widget.variation.name != null?
                    SizedBox():
                    Text(
                      widget.product.quantity!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.red,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    widget.variation.name == null?
                    double.parse(widget.product.discountPrice!) < 1
                        ? SizedBox(
                      height: 4,
                    )
                        : Text(
                      Constant.KCurrency + widget.product.unitPrice!,
                      style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(
                        // fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black38),
                    )
                    :    double.parse(widget.variation.discountPrice!) < 1
                        ? SizedBox(
                      height: 4,
                    )
                        : Text(
                      Constant.KCurrency + widget.variation.price!,
                      style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(
                        // fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black38),
                    ),
                    widget.variation.name == null?
                    SizedBox():
                    Text(
                      '${Constant.KCurrency} ${double.parse(widget.variation.price!) - double.parse(widget.variation.discountPrice!)}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.variation.name != null?
                    SizedBox():
                    Text(
                      '${Constant.KCurrency} ${double.parse(widget.product.unitPrice!) - double.parse(widget.product.discountPrice!)}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        controller.loading
                            ? Center(
                          child: SizedBox(
                            width: 100,
                            height: 32,
                            child: CustomLoading(),
                          ),
                        )
                            : Row(
                          children: [
                            InkWell(
                              onTap: () =>
                                  controller.decrementQuantity(widget.index),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                    Color(Constant.KSecondaryColor),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Text(widget.quantity.toString()),
                            InkWell(
                              onTap: () =>
                                  controller.incrementQuantity(widget.index),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                    Color(Constant.KSecondaryColor),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
        )
      ],
    )  ;
  }
}
