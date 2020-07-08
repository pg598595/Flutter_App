import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/ui/AddRecipeScreen.dart';
import 'package:Flavr/ui/WishList.dart';
import 'package:Flavr/ui/FeedScreen.dart';
import 'package:Flavr/ui/ProfileScreen.dart';
import 'package:Flavr/ui/HomeScreen.dart';
import 'package:Flavr/ui/LoginScreen.dart';
import 'package:Flavr/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        theme: ThemeData(
          // We set Poppins as our default font
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryColor: Color(0xFF035AA6),
          accentColor: Color(0xFF035AA6),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
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
