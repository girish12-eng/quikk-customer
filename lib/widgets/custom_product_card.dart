import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/cart_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/product_model.dart';
import 'package:readmore/readmore.dart';

class CustomProductCard extends StatefulWidget {
  final ProductModel product;
  final int shopId;
  final bool isVeg;
  final int marketType;
  final String packCharge;


  const CustomProductCard({
    Key? key,
    required this.product,
    required this.shopId,
    this.isVeg = false,
    required this.marketType,
    required this.packCharge,
  }) : super(key: key);

  @override
  _CustomProductCardState createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {


  Variationss? _chosenValue;

  double nValue = 0.0;
  double newSub = 0.0;
  double mValue = 0.0;
  int? varIndex = 0;

  calculateNewValue(value) {
    newSub = (double.parse(value!.price!) - double.parse(value.discountPrice!));
    nValue =
        (((double.parse(value.discountPrice!)) / double.parse(value.price!)) *
            100);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product.variationss!.length > 0){
      toCheckVariationList();}}


   void toCheckVariationList() {
    if (widget.product.variationss!.length > 0) {
      mValue = double.parse(widget.product.variationss![0].price!);
      newSub = (double.parse(widget.product.variationss![0].price!) -
          double.parse(widget.product.variationss![0].discountPrice!));
      nValue = (((double.parse(widget.product.variationss![0].discountPrice!)) /
              double.parse(widget.product.variationss![0].price!)) *
          100);
    } else {
      mValue = double.parse(widget.product.unitPrice!);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('fffffff' + widget.product.quantity! + 'ffffffff');
    var controller = Provider.of<CartController>(context);

    int ind = controller.getCart.indexWhere((i) => i.product.id == widget.product.id);
    print(ind);
    // if(ind!=-1){
    //   if(controller.getCart[ind].variation.id==null){
    //     _chosenValue=controller.getCart[ind].product.variationss as Variationss?;
    //   }
    // }

    // if (ind > -1) {
    //   if (controller.getCart[ind].variationIndex != null) {
    //     print("Subha bmar ha");
    //     print(controller.getCart[ind].variationIndex ?? '');
    //     varIndex = controller.getCart[ind].variationIndex;
    //     print("lodadasjdnjasbfabdfhdasfbudabsvfa");
    //
    //     print(varIndex);
    //     print(_chosenValue);
    //     _chosenValue = controller.getCart[ind].product.variationss![varIndex!];
    //     print("afterrrrr");
    //     print(_chosenValue);
    //   }
    // }

    return widget.isVeg
        ? widget.product.type == 0
            ? Column(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                              widget.product.recommend == 1
                                  ? Positioned(
                                      top: 2,
                                      left: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Color(Constant.KPrimaryColor),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(
                                            'BestSeller',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        widget.marketType == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      widget.product.type == 0
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
                                  widget.marketType == 1
                                      ? SizedBox()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // border: Border.all(color: Colors.black12),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.directions_bike,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '1.0 hrs',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),

                              // DROPDOWN
                              widget.product.variationss!.isNotEmpty
                                  ? Container(
                                      height: 25,
                                      margin: EdgeInsets.only(top: 10),
                                      padding:
                                          EdgeInsets.only(left: 3, right: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                              color: Colors.grey
                                                  .withOpacity(0.2))),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            hint: Text(
                                              "Choose Variations",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            isExpanded: true,
                                            items: widget.product.variationss!
                                                .map((variation) {
                                              return DropdownMenuItem(
                                                value: variation,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      variation.name.toString(),
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                        '${Constant.KCurrency} ${double.parse(variation.price!) - double.parse(variation.discountPrice!)}',
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            value: _chosenValue,
                                            onChanged: (value) {
                                              setState(() {
                                                calculateNewValue(value);
                                                _chosenValue =
                                                    (value as Variationss?)!;
                                                mValue =
                                                    double.parse(value!.price!);
                                                // final index = model.getCart.indexWhere((element) =>
                                                // element.product.variationss![0].name == value.name);
                                                // if (index == -1) {
                                                //   print('Using indexWhere: ${index.toString()}');
                                                // }
                                              });
                                            }),
                                      ),
                                    )
                                  : SizedBox(),

                              // ITEM QUANTITY
                              SizedBox(
                                height: 4,
                              ),
                              widget.product.quantity!.isEmpty ||  widget.product.quantity=="null"
                                  ? SizedBox()
                              // : widget.product.quantity!.contains("")?Container()
                                  : widget.product.variationss!.isEmpty
                                  ? Text(
                                widget.product.quantity.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: Colors.redAccent,
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(
                                height: 4,
                              ),

                              // DESCRIPTION

                              SizedBox(
                                height: 4,
                              ),
                              widget.product.description != null
                                  ? ReadMoreText(
                                widget.product.description!,
                                trimLines: 2,
                                colorClickableText: Colors.black87,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'show more',
                                trimExpandedText: 'show less',
                                style: Theme.of(context).textTheme.caption,
                              )
                                  : Container(),
                              SizedBox(
                                height: 8,
                              ),

                              //  PRICE ROW
                              double.parse(widget.product.discountPrice!) < 1
                                  ? SizedBox(
                                      height: 2,
                                    )
                                  : Row(
                                      children: [
                                        widget.product.variationss!.isEmpty
                                            ? Text(
                                                Constant.KCurrency +
                                                    widget.product.unitPrice!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        // fontWeight: FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black54),
                                              )
                                            : Text(
                                                Constant.KCurrency +
                                                    mValue.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        // fontWeight: FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black54),
                                              ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              child: widget.product.variationss!
                                                      .isEmpty
                                                  ? Text(
                                                      '${(((double.parse(widget.product.discountPrice!)) / double.parse(widget.product.unitPrice!)) * 100).toStringAsFixed(1)} % OFF',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                    )
                                                  : Text(
                                                      '${nValue.toStringAsFixed(1)} % OFF',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                    )),
                                        )
                                      ],
                                    ),

                              // PRICE MAIN
                              widget.product.variationss!.isEmpty
                                  ? Text(
                                      '${Constant.KCurrency} ${double.parse(widget.product.unitPrice!) - double.parse(widget.product.discountPrice!)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    )
                                  : Text(
                                      '${Constant.KCurrency} +$newSub',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.product.avgRating! < 1
                                      ? SizedBox()
                                      : RatingBarIndicator(
                                          rating: widget.product.avgRating!,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 12.0,
                                          direction: Axis.horizontal,
                                        ),
                                  ind == -1
                                      ? widget.product.inStock!
                                          ? ElevatedButton(
                                              onPressed: () {
                                                print(widget.marketType);
                                                Provider.of<CartController>(
                                                        context,
                                                        listen: false)
                                                    .setMarketType(
                                                        widget.marketType);
                                                controller.addOnCart(
                                                    widget.product,
                                                    1,
                                                    widget.shopId,
                                                    context,
                                                    double.parse(
                                                        widget.packCharge),
                                                    _chosenValue,
                                                    // varIndex!
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Text(
                                                  'ADD',
                                                ),
                                              ),
                                            )
                                          : TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'OUT OF STOCK',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                      : controller.loading
                                          ? Container(
                                              width: 100,
                                              // color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color(Constant
                                                          .KPrimaryColor),
                                                    ),
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () => controller
                                                      .decrementQuantity(ind),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
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
                                                        color: Color(
                                                          Constant
                                                              .KSecondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Text(
                                                  (controller.getCart[ind]
                                                          .quantity)
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                InkWell(
                                                  onTap: () => controller
                                                      .incrementQuantity(ind),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
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
                                                        color: Color(
                                                          Constant
                                                              .KSecondaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // IconButton(
                                                //   icon: Icon(Icons.add),
                                                //   splashRadius: 16,
                                                //   onPressed: () =>
                                                //       controller.incrementQuantity(ind),
                                                // ),
                                              ],
                                            )
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
              )
            : SizedBox()

        // all product including veg

        : Column(
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
                    // IMAGE SECTION
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
                          // double.parse(product.discountPrice!) < 1
                          //     ? SizedBox()
                          //     :
                          widget.product.recommend == 1
                              ? Positioned(
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
                                      child: Text(
                                        'BestSeller',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
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
                              //   RED CIRCLE
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    widget.marketType == 1
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  widget.product.type == 0
                                                      ? Colors.green
                                                      : Colors.red,
                                              radius: 4,
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      width: 4,
                                    ),

                                    //PRODUCT NAME
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

                              //TIME IN HOURS
                              widget.marketType == 1
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                        // border: Border.all(color: Colors.black12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.directions_bike,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '1.0 hrs',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),

                          // DROPDOWN
                          widget.product.variationss!.isNotEmpty
                              ? Container(
                                  height: 25,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.2))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        hint: Text(
                                          "Choose Variations",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        isExpanded: true,
                                        items: widget.product.variationss!
                                            .map((variation) {
                                          return DropdownMenuItem(
                                            value: variation,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  variation.name.toString(),
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                Text(
                                                    '${Constant.KCurrency} ${double.parse(variation.price!) - double.parse(variation.discountPrice!)}',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        value: _chosenValue == null
                                            ? widget.product.variationss![0]
                                            : _chosenValue,
                                        onChanged: (value) {
                                          print("GIRISH===>>" +
                                              varIndex.toString());
                                          setState(() {
                                            calculateNewValue(value);
                                            _chosenValue =
                                                (value as Variationss?)!;
                                            mValue =
                                                double.parse(value!.price!);
                                            // varIndex = widget
                                            //     .product.variationss!
                                            //     .indexWhere((element) =>
                                            //         element.id == value.id);
                                            // final index = model.getCart.indexWhere((element) =>
                                            // element.product.variationss![0].name == value.name);
                                            // if (index == -1) {
                                            //   print('Using indexWhere: ${index.toString()}');
                                            // }
                                          });
                                        }),
                                  ),
                                )
                              : SizedBox(),

                          // ITEM QUANTITY
                          SizedBox(
                            height: 4,
                          ),
                          widget.product.quantity!.isEmpty ||  widget.product.quantity=="null"
                              ? SizedBox()
                                 // : widget.product.quantity!.contains("")?Container()
                              : widget.product.variationss!.isEmpty
                                  ? Text(
                                      widget.product.quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.redAccent,
                                          ),
                                    )
                                  : SizedBox(),
                          SizedBox(
                            height: 4,
                          ),

                          // DESCRIPTION
                          widget.product.description != null
                              ? ReadMoreText(
                                  widget.product.description!,
                                  trimLines: 2,
                                  colorClickableText: Colors.black87,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'show more',
                                  trimExpandedText: 'show less',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              : Container(),
                          SizedBox(
                            height: 8,
                          ),

                          //  PRICE ROW
                          double.parse(widget.product.discountPrice!) < 1
                              ? SizedBox(
                                  height: 2,
                                )
                              : Row(
                                  children: [
                                    widget.product.variationss!.isEmpty
                                        ? Text(
                                            Constant.KCurrency +
                                                widget.product.unitPrice!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    // fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black54),
                                          )
                                        : Text(
                                            Constant.KCurrency +
                                                mValue.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    // fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black54),
                                          ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          child: widget
                                                  .product.variationss!.isEmpty
                                              ? Text(
                                                  '${(((double.parse(widget.product.discountPrice!)) / double.parse(widget.product.unitPrice!)) * 100).toStringAsFixed(1)} % OFF',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                )
                                              : Text(
                                                  '${nValue.toStringAsFixed(1)} % OFF',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                )),
                                    )
                                  ],
                                ),

                          // PRICE MAIN
                          widget.product.variationss!.isEmpty
                              ? Text(
                                  '${Constant.KCurrency} ${double.parse(widget.product.unitPrice!) - double.parse(widget.product.discountPrice!)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              : Text(
                                  '${Constant.KCurrency} +$newSub',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),

                          // RatingBarIndicator ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.product.avgRating! < 1
                                  ? SizedBox()
                                  : RatingBarIndicator(
                                      rating: widget.product.avgRating!,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 12.0,
                                      direction: Axis.horizontal,
                                    ),

                              //ADD BUTTON
                              ind == -1
                                  ? widget.product.inStock!
                                      ? ElevatedButton(
                                          onPressed: () {
                                            print(widget.marketType);
                                            Provider.of<CartController>(context,
                                                    listen: false)
                                                .setMarketType(
                                                    widget.marketType);
                                            controller.addOnCart(
                                                widget.product,
                                                1,
                                                widget.shopId,
                                                context,
                                                double.parse(widget.packCharge),
                                                _chosenValue,
                                                // ==null? widget.product.variationss![0]:_chosenValue,
                                                // varIndex
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'ADD',
                                            ),
                                          ),
                                        )

                                      //OUT OF STOCK
                                      : TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'OUT OF STOCK',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )

                                  //CircularProgressIndicator Loader
                                  : controller.loading
                                      ? Container(
                                          width: 100,
                                          // color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color(
                                                      Constant.KPrimaryColor),
                                                ),
                                                width: 24,
                                                height: 24,
                                              ),
                                            ],
                                          ),
                                        )

                                      //DECREMENT BUTTON && INCREMENT  BUTTON ROW
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //DECREMENT BUTTON
                                            InkWell(
                                              onTap: () => controller
                                                  .decrementQuantity(ind),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
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
                                                    color: Color(
                                                      Constant.KSecondaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //QUANTITY TEXT
                                            Text(
                                              (controller.getCart[ind].quantity)
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),

                                            //INCREMENT BUTTON
                                            InkWell(
                                              onTap: () => controller
                                                  .incrementQuantity(ind),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
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
                                                    color: Color(
                                                      Constant.KSecondaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
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
          );
  }
}
