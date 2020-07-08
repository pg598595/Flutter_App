import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/ui/AddRecipeScreen.dart';
import 'package:Flavr/ui/WishList.dart';
import 'package:Flavr/ui/FeedScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';
import 'package:Flavr/ui/HomeScreen.dart';
import 'package:Flavr/ui/LoginScreen.dart';
import 'package:Flavr/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'IntroductionScreen.dart';

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
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color.fromRGBO(32, 33, 36, 1.0),
            appBarTheme: AppBarTheme(),
            primarySwatch: Colors.blue,
            primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
            accentColor: Color(int.parse('0xff2399CC')),
            iconTheme: IconThemeData(color: Colors.black)),
        theme:  ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color.fromRGBO(32, 33, 36, 1.0),
            appBarTheme: AppBarTheme(),
            primarySwatch: Colors.pink,
            primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
            accentColor: Color(int.parse('0xff2399CC')),
            iconTheme: IconThemeData(color: Colors.white)),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/OnBoardingPage": (BuildContext context) => OnBoardingPage(),
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
