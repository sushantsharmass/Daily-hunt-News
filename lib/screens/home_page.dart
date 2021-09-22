import 'package:dailyhunt/models/newsdata.dart';
import 'package:dailyhunt/models/spotmodel.dart';
import 'package:dailyhunt/screens/articles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  

  List<SpotModel> articles = List<SpotModel>();

  bool _loading = true;

  @override
  void initState(){
    super.initState();
    getNews();
  }

  getNews()async{
    NewsData newsClass = NewsData();
    await newsClass.getNewss();
    articles = newsClass.newss;
    setState(() {
      _loading = false;
    });
  }

  Future<Null> getyou()async{
    await Future.delayed(Duration(seconds:2));
    total = '$apif'+ '$feed' + '$apil';
    http.Response response = await http.get(total);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
    getNews();
    
  }       


  String apif = 'http://api.openweathermap.org/data/2.5/weather?q=';
  String apil = '&units=metric&appid=deaf5261d8a67bcc2113e008837d1605';
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  String total;
  String feed;


  Future getWeather(String input) async {
    // await Future.delayed(Duration(seconds:2));
    http.Response response = await http.get(apif + input + apil);
    var results = jsonDecode(response.body);
    // await Future.delayed(Duration(seconds:2));
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }


  feeds(String input){
      feed = input;
    }



  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News",
            style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight:FontWeight.bold)
            ),
            Text("Hunt",
            style: TextStyle(color: Colors.black,fontSize: 22.0,fontWeight:FontWeight.bold)
            ),
          ],
        )
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ): RefreshIndicator(
          onRefresh: getyou,
          child: Column(
          children: [
            SizedBox(height:10.0),
            Container(
              margin: EdgeInsets.only(left:15.0,right:15.0,top:2.0,bottom:20.0),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  //spreadRadius: 7.0,
                ),
                ],
                borderRadius:BorderRadius.circular(10),
              ),
              child: TextField(
                onSubmitted: (String input) {
                  getWeather(input);
                  feeds(input);
                    },
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.grey),
                      hintText: 'Search for cities', 
                      hintStyle: TextStyle(fontSize: 17,color: Colors.grey),
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:15.0,right:15.0,top:0.0,bottom:20.0),
              height:MediaQuery.of(context).size.height/5,
              width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.cloud,size:24.0, color: Colors.white),
                        SizedBox(height:20.0),
                        Text(feed !=null ? feed: 'Delhi',
                        style: TextStyle(color: Colors.white,fontSize:24.0)
                        ),
                        Row(
                          children: [
                            Text("Humidity",
                            style: TextStyle(color: Colors.white,fontSize:24.0)),
                            SizedBox(width:10.0),
                            Text(humidity != null ? humidity.toString() : '87',
                            style: TextStyle(color: Colors.white,fontSize:22.0)),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:10.0),
                    child: Column(
                      children: [
                        Text(temp != null
                        ? temp.toString() + '\u00B0C'
                        : '29',
                        style: TextStyle(color: Colors.white,fontSize:40.0)
                        ),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.wind, size:20.0, color: Colors.white),
                            SizedBox(width:10.0),
                            Text("Wind",
                            style: TextStyle(color: Colors.white,fontSize:17.0)
                            ),
                            SizedBox(width:10.0),
                            Text(windSpeed != null ? windSpeed.toString() : '14',
                            style: TextStyle(color: Colors.white,fontSize:20.0)
                            ),
                          ],
                        ),
                        Text(currently != null ? currently.toString() : 'fog',
                        style: TextStyle(color: Colors.white,fontSize:17.0)),
                      ],
                    ),
                  )
                ],
              )
            ),
            Expanded(
                child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: articles.length,
                itemBuilder: (BuildContext context,int index){
                  return GestureDetector(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ArticleViewss(
                      blogUrl: articles[index].url,
                      )
                      ));
                      },
                      child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical:10.0),
                      height:MediaQuery.of(context).size.height/2,
                      width:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        gradient: LinearGradient(
                          
                          begin: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.7),
                          ]
                        ),
                        borderRadius:BorderRadius.circular(40.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                          fit: StackFit.expand,
                          
                          children: [
                            Image.network(
                              articles[index].urlToImage,
                              fit: BoxFit.fill,
                              
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(articles[index].title,
                                  style: TextStyle(color: Colors.white,fontSize:27.0,fontWeight:FontWeight.bold)
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                    ),
                  );
                }
                ),
            )
          ],
        ),
      ),
    );
  }
}


























// int selectedindex = 0;
//   final List<String> cat = ['World','Sports','Business','Technology'];

// Container(
            //   margin: EdgeInsets.symmetric(horizontal: 10.0),
            //   height:MediaQuery.of(context).size.height/12,
            //   width:MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //   ),
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: cat.length,
            //     itemBuilder: (BuildContext context, int index){
            //       return GestureDetector(
            //           onTap: (){
            //             setState(() {
            //               selectedindex = index;
            //             });
            //           },
            //           child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //           child: Text(cat[index],
            //           style: TextStyle(color: index == selectedindex ?Colors.blueAccent: Colors.grey,fontSize:24.0,fontWeight:FontWeight.bold,letterSpacing:1.2)
            //           ),
            //         ),
            //       );
            //     }
            //     ),
            // ),

