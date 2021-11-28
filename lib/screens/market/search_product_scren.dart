import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/search_product_controller.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_product_card.dart';

class SearchProductScreen extends StatefulWidget {
  final int marketId;
  final int marketType;
  final String packagingCharge;

  const SearchProductScreen(
      {Key? key, required this.marketId, required this.marketType,required this.packagingCharge,})
      : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SearchProductController>(context, listen: false).init(
        widget.marketId);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SearchProductController>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    CustomBackButton(),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          isDense: true,
                          hintText: 'Search Products',
                          alignLabelWithHint: true,
                        ),
                        onChanged: (v) => controller.onSearch(v),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Search result',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            controller.getProducts.isEmpty
                ? SliverToBoxAdapter(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .5,
                child: Center(
                  child: Text('No product Found'),
                ),
              ),
            )
                : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomProductCard(
                      product: controller.getProducts[index],
                      shopId: widget.marketId,
                      marketType: widget.marketType,
                      packCharge: widget.packagingCharge,
                    ),
                  );
                },
                childCount: controller.getProducts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
