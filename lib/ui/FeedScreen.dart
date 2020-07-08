import 'dart:io';

import 'package:Flavr/model/ItemDetailsFeed.dart';
import 'package:Flavr/ui/Skelton.dart';
import 'package:Flavr/ui/feed_item_card.dart';
import 'package:Flavr/utils/CustomNavigation.dart';
import 'package:Flavr/utils/Permissions.dart';
import 'package:Flavr/values/CONSTANTS.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';

class FeedScreen extends StatefulWidget {
  int loginData;
  var likedFeed = <ItemDetailsFeed>[];

  @override
  _FeedScreenState createState() => new _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _feedDetails = <ItemDetailsFeed>[];
  Future<ItemDetailsFeed> feed;
  var Constants = CONSTANTS();
  var likedList = FeedScreen().likedFeed;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String _searchText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => filter.text = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  var names = <ItemDetailsFeed>[]; // names we get from API
  var filteredNames = <ItemDetailsFeed>[];
  Icon _searchIcon = new Icon(Icons.search);
  Icon _voiceSearchIcon = new Icon(Icons.keyboard_voice);

  Widget _appBarTitle = new Text('Home');

  final TextEditingController filter = new TextEditingController();

  GlobalKey<ScaffoldState> login_state = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          ),
          new IconButton(
            icon: _voiceSearchIcon,
            onPressed: () {
              microphonePermission();
              _voiceSearchPressed();
            },
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: RefreshIndicator(
        key: login_state,
        onRefresh: _refresh,
        child: Column(children: <Widget>[
          FutureBuilder<dynamic>(
            future: _loadData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text(
                    Constants.NODATAMSG,
                    textAlign: TextAlign.center,
                  );
                case ConnectionState.active:
                  return null;
                case ConnectionState.waiting:
                  return buildRowLoading(context);
                case ConnectionState.done:
                  return _buildRow(context);
              }
              return null;
            },
          ),
        ]),

//        FutureBuilder<dynamic>(
//          future: _loadData(),
//          builder: (context, snapshot) {
//            Container(
//              margin: EdgeInsets.only(top: 70),
//              decoration: BoxDecoration(
//                color: Color(0xFFF1EFF1),
//                borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(40),
//                  topRight: Radius.circular(40),
//                ),
//              ),
//            );
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//                return Text(
//                  Constants.NODATAMSG,
//                  textAlign: TextAlign.center,
//                );
//              case ConnectionState.active:
//                return null;
//              case ConnectionState.waiting:
//                return buildRowLoading(context);
//              case ConnectionState.done:
//                return _buildRow(context);
//            }
//            return null;
//          },
//        ),
      ),
    );
  }

  Future<Null> _refresh() {
    return _loadData().then((_FeedListPageState) {
      setState(() => initSpeechRecognizer());
    });
  }

  Future _loadData() async {
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader: Constants.APITOKEN
    };
    var response1 =
    await dio.get(Constants.FEEDSAPI, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      var isInCookingList = false;
      if (memberJSON[Constants.INCOOKINGLIST] == 1) {
        isInCookingList = true;
      }

      final itemDetailsfeed = new ItemDetailsFeed(
          memberJSON[Constants.RECIPEID],
          memberJSON[Constants.NAME],
          memberJSON[Constants.PHOTO],
          memberJSON[Constants.PREPARATIONTIME],
          memberJSON[Constants.SERVES],
          memberJSON[Constants.COMPLEXITY],
          isInCookingList,
          memberJSON[Constants.YOUTUBEURL]);
      _feedDetails.add(itemDetailsfeed);
      names.add(itemDetailsfeed);
      filteredNames = names;
    }
  }

  _HomeScreenState() {
    filter.addListener(() {
      setState(() {
        _searchText = filter.text;
      });
    });
  }

  void _voiceSearchPressed() {
    if (_isAvailable && !_isListening)
      _speechRecognition
          .listen(locale: Constants.ENGLISHLANGUAGE)
          .then((result) => filter.text = result);

    setState(() {
      if (this._voiceSearchIcon.icon == Icons.keyboard_voice) {
        this._voiceSearchIcon = new Icon(Icons.close);
        this._appBarTitle = TextFormField(
          textInputAction: TextInputAction.done,
          controller: filter,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: new Icon(Icons.settings_voice),
            hintText: Constants.HINTLISTINIG,
          ),
          onFieldSubmitted: (term) {
            filter.text = _searchText;
            FocusScope.of(context).unfocus();
          },
        );
        _HomeScreenState();
      } else {
        _isAvailable = true;
        this._searchIcon = Icon(Icons.search);
        this._voiceSearchIcon = new Icon(Icons.keyboard_voice);
        this._appBarTitle = Text(Constants.APPTITLEHOME);
        filter.clear();
        _searchText = "";
      }
    });
  }

  Future _searchPressed() async {
    await setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = TextFormField(
          textInputAction: TextInputAction.done,
          controller: filter,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: Constants.HINTSEARCH,
          ),
          onFieldSubmitted: (term) {
            _searchText = filter.text;
            FocusScope.of(context).unfocus();
          },
        );
        _HomeScreenState();
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = Text(Constants.APPTITLEHOME);
        filter.clear();
        _searchText = "";
      }
    });
  }

  Widget _buildRow(BuildContext context) {
    var counterProvider = Provider.of<ItemDetailsFeed>(context);
    if (!(_searchText.isEmpty)) {
      var tempList = <ItemDetailsFeed>[];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .getName()
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return Expanded(
        child: Stack(
          children: <Widget>[
            // Our background
            Container(
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            ListView.builder(
              itemCount: filteredNames.length,
              itemBuilder: (context, index) =>
                  FeedItemCard(
                    itemIndex: index,
                    product: filteredNames[index],
                    press: () {
                      navigateToSubPage(context, index, filteredNames);
                    },
                  ),

            )
          ],
        ));
  }}