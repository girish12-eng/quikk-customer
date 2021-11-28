import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/search_market_controller.dart';
import 'package:quikk_customer/models/media.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_market_card.dart';
import 'package:quikk_customer/widgets/custom_market_card_2.dart';

class SearchMarketScreen extends StatefulWidget {
  final String lat;
  final String lng;

  const SearchMarketScreen({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  _SearchMarketScreenState createState() => _SearchMarketScreenState();
}

class _SearchMarketScreenState extends State<SearchMarketScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SearchMarketController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SearchMarketController>(context);
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
                          hintText: 'Search Market',
                          alignLabelWithHint: true,
                        ),
                        onChanged: (v) =>
                            controller.onSearch(v, widget.lat, widget.lng),
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
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            controller.getShops.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      child: Center(
                        child: Text('No shop Found'),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomMarketCard2(
                              shop: controller.getShops[index]),
                        );
                      },
                      childCount: controller.getShops.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
