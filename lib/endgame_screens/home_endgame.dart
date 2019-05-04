import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class InfinitySaga extends StatefulWidget{
  final String title;

  InfinitySaga({Key key, this.title}) : super(key: key);
  @override
  ListInfinitySaga createState()  => new ListInfinitySaga();
}

class InfinityComic{
  final String title;
  final String cover;
  InfinityComic(this.title, this.cover);
}

class ListInfinitySaga extends State<InfinitySaga>{

  Future<List<InfinityComic>> _getComics() async{
    var now = new DateTime.now();
    var md5D = generateMd5("${now}LLAVEPRIVADA+LLAVEPUBLICA");
    var url = "https://gateway.marvel.com/v1/public/series?title=infinity gauntlet&ts=${now}&apikey=LLAVEPRIVADA&hash=${md5D}";
    print(url);
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
    List<InfinityComic> comics = [];
    var dataMarvel = jsonData["data"];
    var results = dataMarvel["results"];
    for (var comic in results){
      var thumb = comic["thumbnail"];
      var image = "${thumb["path"]}.jpg";
      InfinityComic infinityComic = InfinityComic(comic["title"], image);
      comics.add(infinityComic);
    }
    return comics;
  }

  String generateMd5(String input) {
    return crypto.md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getComics(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                  child: Center(
                  child: Text("Loading."),
                  ),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: CircleAvatar(backgroundImage:
                        NetworkImage(snapshot.data[index].cover
                        ),
                      ),
                      title: Text(snapshot.data[index].title),
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context)=> InfinityDetail(snapshot.data[index]))
                        );
                      },
                    );
                  }
              );
            }
          },
        ),
      )
    );
  }
}

class InfinityDetail extends StatelessWidget{
  final InfinityComic infinityComic;

  InfinityDetail(this.infinityComic);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(infinityComic.title),
        ),
        body: Image.network(
          infinityComic.cover,
        )
    );
  }
}

