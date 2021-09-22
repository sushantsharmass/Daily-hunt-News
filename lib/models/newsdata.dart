import 'dart:convert';

import 'package:dailyhunt/models/spotmodel.dart';

import 'package:http/http.dart' as http ;

class NewsData {

  List<SpotModel> newss = [];

  Future<void> getNewss() async {
    
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b8d7f21c581a4047b1a3b7743251063e";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){


          SpotModel spotModel = SpotModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          newss.add(spotModel);
        }
      });
      
    }

  }

}