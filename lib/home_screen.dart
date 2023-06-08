import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Postsmodel.dart';


class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  List<Postsmodel> postlist = [];

  Future<List<Postsmodel>> getpostapi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postlist.add(Postsmodel.fromJson(i));
      }
      return postlist;
    }else{
      return postlist;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Api Test",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 30),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getpostapi(),
                builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context , index){
                        return Card(
                          color: Colors.brown,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("title",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.orangeAccent),),
                                Text(postlist[index].title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                SizedBox(height: 12,),
                                Text("Description",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue),),
                                Text(postlist[index].body.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(),
                );
                },
            ),
          ),
        ],
      ),
    );
  }
}
