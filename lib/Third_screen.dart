import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'Models/UserModel.dart';

class Thirdscreen extends StatefulWidget {
  const Thirdscreen({Key? key}) : super(key: key);

  @override
  State<Thirdscreen> createState() => _ThirdscreenState();
}


class _ThirdscreenState extends State<Thirdscreen> {
  
  List<UserModel> userlist = [];
  
  Future<List<UserModel>> getuser() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        print(i["name"]);
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    }else{
      return userlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("User Api",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 25),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserModel>>(
                future: getuser(),
                builder: (context,snapshot){
              if(snapshot.hasData){
                print(snapshot.hasData);
                return ListView.builder(
                  itemCount: userlist.length,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.white10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Reusablerow(title: "Name:-", value:snapshot.data![index].name.toString()),
                              Reusablerow(title: "username:-", value:snapshot.data![index].username.toString()),
                              Reusablerow(title: "email:-", value:snapshot.data![index].email.toString()),
                              Reusablerow(title: "address:-", value:snapshot.data![index].address!.street.toString()),
                              Reusablerow(title: "address:-", value:snapshot.data![index].address!.geo!.lat.toString()),
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
            }
            ),
          ),
        ],
      ),
    );
  }
}

class Reusablerow extends StatelessWidget {

  String title , value ;
  Reusablerow({Key? key,required this.title ,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigoAccent),),
        Text(value,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orange),),

      ],
    );

  }
}

