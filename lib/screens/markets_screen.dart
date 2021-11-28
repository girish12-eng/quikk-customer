import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/home_screen_controller.dart';
import 'package:quikk_customer/controller/market_by_category_controller.dart';
import 'package:quikk_customer/models/category_model.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';
import 'package:quikk_customer/widgets/custom_market_card_2.dart';

class CategoryMarketsScreen extends StatefulWidget {
  static const id = 'CategoryMarketsScreen';

  final CategoryModel category;

  const CategoryMarketsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryMarketsScreenState createState() => _CategoryMarketsScreenState();
}

class _CategoryMarketsScreenState extends State<CategoryMarketsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MarketByCategoryController>(context, listen: false).init(
        widget.category.id.toString(),
        Provider.of<HomeScreenController>(context, listen: false).lat!,
        Provider.of<HomeScreenController>(context, listen: false).lng!);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MarketByCategoryController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          widget.category.name!,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
      body: controller.loading
          ? CustomLoading()
          : controller.markets.length < 1
              ? Center(
                  child: Text('No market found'),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomMarketCard2(shop: controller.markets[index]),
                      );
                    },
                    itemCount: controller.markets.length,
                  ),
                ),
    );
  }
}
