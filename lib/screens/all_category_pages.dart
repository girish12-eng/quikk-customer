import 'package:flutter/material.dart';
import 'package:quikk_customer/models/category_model.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';
import 'package:quikk_customer/widgets/custom_category_card.dart';

class AllCategoryScreen extends StatelessWidget {
  final List<CategoryModel> categories;
  static const id = 'AllCategoryScreen';

  const AllCategoryScreen({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(
          'All Categories',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black,
              ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, index) {
            return CustomCategoryCard(
              category: categories[index],
            );
          },
          itemCount: categories.length,
        ),
      ),
    );
  }
}
