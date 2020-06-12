
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutterdemoapp/model/InstructionDetailsFeed.dart';
import 'package:flutterdemoapp/values/CONSTANTS.dart';

class LoadingInstructionAPI{
  var _instructionDetails;
  var Constants = CONSTANTS();

   Future<List<InstructionDetailsFeed>> loadInstruction(int list) async {
    String instructionsURL =
        "${Constants.GETINGREDENTSandINSTURCTIONSAPI}${list}/instructions";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
      Constants.APITOKEN
    };
    var response1 =
    await dio.get(instructionsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final instructionfeed = new InstructionDetailsFeed(
        memberJSON[Constants.ID],
        memberJSON[Constants.INSTRUCTION],
      );
      _instructionDetails.add(instructionfeed);
    }
    return _instructionDetails;
  }
}

