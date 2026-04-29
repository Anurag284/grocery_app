import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/heart_button.dart';
import 'package:grocery_app/Widget/price_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class FeedItems extends StatefulWidget {
  const FeedItems({super.key});

  @override
  State<FeedItems> createState() => _FeedItemsState();
}

class _FeedItemsState extends State<FeedItems> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  Widget build(BuildContext context) {
    final Size size = Utils(context).screenSize;
    final Color color = Utils(context).color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                errorWidget: Image.asset('assets/images/cat/fruits.png'),
                width: size.width * 0.22,
                height: size.width * 0.22,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: 'Title',
                      color: color,
                      textSize: 20,
                      isTitle: true,
                    ),
                    HeartButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceWidget(),
                    SizedBox(width: 8),
                    Flexible(
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                              title: 'KG',
                              color: color,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: ValueKey('10\$'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              textAlign: TextAlign.center,
                              cursorColor: Colors.green,
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.,]'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = '1';
                                  } else {
                                    // total =
                                    //     userPrice *
                                    //     intParse(_quantityTextController.text);
                                  }
                                });
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).cardColor,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    title: 'Add to Cart',
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
