import 'package:flutterdemoapp/model/ItemDetailsFeed.dart';
import 'package:flutterdemoapp/ui/AddRecipeScreen.dart';
import 'package:flutterdemoapp/ui/WishList.dart';
import 'package:flutterdemoapp/ui/FeedScreen.dart';
import 'package:flutterdemoapp/ui/ProfileScreen.dart';
import 'package:flutterdemoapp/ui/HomeScreen.dart';
import 'package:flutterdemoapp/ui/LoginScreen.dart';
import 'package:flutterdemoapp/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemDetailsFeed>(builder: (context) => ItemDetailsFeed.fromFeed(true)),
      ],
      child: new MaterialApp(
        title: "MyRecipes",
        theme: new ThemeData(
            scaffoldBackgroundColor: Colors.white70,
            bottomAppBarColor: Colors.white,
            cursorColor: Colors.grey,
            cardColor: Colors.white,
            hintColor: Colors.grey,
            focusColor: Colors.white,
            primaryColor: Colors.black,
            unselectedWidgetColor: Colors.grey,
            primaryTextTheme: TextTheme(
              title: TextStyle(color: Colors.white),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
              subhead: TextStyle(color: Colors.white),
            ),
            secondaryHeaderColor: Colors.black),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/HomeScreen": (BuildContext context) => HomeScreen("email id"),
          "/LoginScreen": (BuildContext context) => LoginScreen(),
          "/FeedScreen": (BuildContext context) => FeedScreen(),
          "/WishList": (BuildContext context) => WishList(),
          "/ProfileScreen": (BuildContext context) => ProfileScreen(),
          "/AddRecipe": (BuildContext context) => AddRecipeScreen(),
        },

        home: SplashScreen(),

      ),
    );
  }
}
