import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:flutter/material.dart';

class FeedItemCard extends StatelessWidget {
  // list of colors that we use in our app
//  var kBackgroundColor = Color(0xFFF1EFF1);
//  var kPrimaryColor = Color(0xFF035AA6);
//  var kSecondaryColor = Color(0xFFFFA41B);
//  var kTextColor = Color(0xFF000839);
//  var kTextLightColor = Color(0xFF747474);
//  var kBlueColor = Color(0xFF40BAD5);
//
//  var kDefaultPadding = 20.0;
//
//// our default Shadow
//  var kDefaultShadow = BoxShadow(
//    offset: Offset(0, 15),
//    blurRadius: 27,
//    color: Colors.black12, // Black color with 12% opacity
//  );

  const FeedItemCard({
    Key key,
    this.itemIndex,
    this.product,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final ItemDetailsFeed product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? Color(0xFFAD3DF7) : Color(0xFF8E1212),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 27,
                    color: Colors.black12, // Black color with 12% opacity
                  )
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '${product.recipeId}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 150,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  child: new FadeInImage.assetNetwork(
                    placeholder: 'images/loaderfood.gif',
                    image: product.photo,
                    fit: BoxFit.fitWidth,
                    width: 100,
                    height: 200,
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20 * 1.5, // 30 padding
                        vertical: 20 / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: itemIndex.isEven ? Color(0xFF8E1212) : Color(0xFFAD3DF7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "Serves ${product.serves}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
