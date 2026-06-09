import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';
import 'package:grocery_app/Screens/Cart/cart_widget.dart';
import 'package:grocery_app/Screens/Wishlist/wishlist_widget.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/back_widget.dart';
import 'package:grocery_app/Widget/empty_screen.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).screenSize;
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final wishListItemList =
        wishListProvider.getWishlistItems.values.toList().reversed.toList();
    return wishListItemList.isEmpty
        ? EmptyScreen(
          title: 'Your wishlist is Empty',
          subtitle: 'Explore more and shortlist items',
          imagePath: 'assets/images/wishlist.png',
          buttonText: 'Add a wish',
        )
        : Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackWidget(),
            title: TextWidget(
              title: 'Wishlist (${wishListItemList.length})',
              color: color,
              textSize: 22,
              isTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                    title: 'Empty Wishlist',
                    subtitle: 'Are you sure ?',
                    fct: () {
                      // Handle empty wishlist logic here
                      wishListProvider.clearWishlist();
                    },
                    context: context,
                  );
                },
                icon: Icon(IconlyLight.delete),
              ),
            ],
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: MasonryGridView.count(
            itemCount: wishListItemList.length,
            crossAxisCount: 2,
            // mainAxisSpacing: 4,
            // crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: wishListItemList[index],
                child: WishlistWidget(),
              );
            },
          ),
        );
  }
}
