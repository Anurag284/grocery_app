import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Consts/constss.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/back_widget.dart';
import 'package:grocery_app/Widget/empty_product_screen.dart';
import 'package:grocery_app/Widget/feed_items.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:provider/provider.dart';

class CategoryInnerScreen extends StatefulWidget {
  static const routeName = "/CategoryInnerScreen";
  const CategoryInnerScreen({super.key});

  @override
  State<CategoryInnerScreen> createState() => _CategoryInnerScreenState();
}

class _CategoryInnerScreenState extends State<CategoryInnerScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    searchTextController.dispose();
    searchTextFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // bool isEmpty = false;
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productProviders.findByCategory(catName);
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          title: 'All Products',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body:
          productByCat.isEmpty
              ? EmptyProductScreen(
                text: 'No Product in this category yet\n Stay Tuned!',
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: kBottomNavigationBarHeight,
                        child: TextField(
                          focusNode: searchTextFocusNode,
                          controller: searchTextController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            hintText: "What's on your mind?",
                            prefixIcon: Icon(Icons.search),
                            suffix: IconButton(
                              onPressed: () {
                                searchTextController.clear();
                                searchTextFocusNode.unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color:
                                    searchTextFocusNode.hasFocus
                                        ? Colors.red
                                        : color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      padding: EdgeInsets.zero,
                      childAspectRatio: size.width / (size.height * 0.59),

                      children: List.generate(productByCat.length, (index) {
                        return ChangeNotifierProvider.value(
                          value: productByCat[index],
                          child: FeedItems(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
    );
  }
}
