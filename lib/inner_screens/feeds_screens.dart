import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/feed_items.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class FeedsScreens extends StatefulWidget {
  static const routeName = "/FeedsScreens";
  const FeedsScreens({super.key});

  @override
  State<FeedsScreens> createState() => _FeedsScreensState();
}

class _FeedsScreensState extends State<FeedsScreens> {
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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2, color: color),
        ),
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
      body: SingleChildScrollView(
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
                      borderSide: BorderSide(color: Colors.grey, width: 1),
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
                            searchTextFocusNode.hasFocus ? Colors.red : color,
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

              children: List.generate(10, (index) => const FeedItems()),
            ),
          ],
        ),
      ),
    );
  }
}
