import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/models/category_model.dart';
import 'package:quikk_customer/screens/markets_screen.dart';

class CustomCategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CustomCategoryCard({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Future.delayed(Duration(milliseconds: 400)).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryMarketsScreen(
                    category: category,
                  ),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 4,
              right: 4,
              bottom: 4,
            ),
            width: 100,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  // color: Colors.red,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        category.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  category.name!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
