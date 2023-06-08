import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Secondscreen extends StatefulWidget {
  const Secondscreen({Key? key}) : super(key: key);

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {

  List<Photos> photolist = [];

  Future<List<Photos>> getphoto() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i["title"], url:  i["url"], id: i["id"]);
        photolist.add(photos);
      }
      return photolist;
    }else{
      return photolist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Example Second Api",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent,fontSize: 25),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Photos>>(
                future: getphoto(),
                builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: photolist.length,
                    itemBuilder: (context,index){
                    return Card(
                      color: Colors.blueGrey,
                      child: ListTile(
                        leading: Image.network(snapshot.data![index].url.toString()),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data![index].title.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                        ),
                        title: Text("Notes id:-"+snapshot.data![index].id.toString()),
                      ),
                    );
                    }
                );
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            ),
          ),
        ],
      ),
    );
  }
}

class Photos{

  String title , url ;
  int id ;

  Photos({required this.title,required this.url,required this.id});
}
