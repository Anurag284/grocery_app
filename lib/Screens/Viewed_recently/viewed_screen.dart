import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/viewed_provider.dart';
import 'package:grocery_app/Screens/Cart/cart_widget.dart';
import 'package:grocery_app/Screens/Viewed_recently/viewed_widget.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/empty_screen.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:provider/provider.dart';

class ViewedScreen extends StatelessWidget {
  static const routeName = '/ViewedScreen';
  const ViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final viewdProdProvider = Provider.of<ViewedProvider>(context);
    final viewedProdItemList =
        viewdProdProvider.getViewedProdListItems.values
            .toList()
            .reversed
            .toList();

    return viewedProdItemList.isEmpty
        ? EmptyScreen(
          title: 'Your history is Empty',
          subtitle: 'No product has been viewed recently',
          imagePath: 'assets/images/history.png',
          buttonText: 'Shop Now',
        )
        : Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            title: TextWidget(
              title: 'Viewed Recently (2)',
              color: color,
              textSize: 24,
              isTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                    title: 'Empty History',
                    subtitle: 'Are you sure?',
                    fct: () {
                      // Handle empty history logic here
                    },
                    context: context,
                  );
                },
                icon: Icon(IconlyLight.delete, color: color),
              ),
            ],
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView.builder(
            itemCount: viewedProdItemList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: viewedProdItemList[index],
                child: ViewedWidget(),
              );
            },
          ),
        );
  }
}
