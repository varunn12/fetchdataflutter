import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post.dart';




void main()=>runApp(new MaterialApp(
  home: MyApp(),
  title: 'Fetch data Example',
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
));






class MyApp extends StatelessWidget {
 List<Post> _list=new List<Post>();
  Future<List<Post>> fetchPost() async{
  final response=await http.get('https://jsonplaceholder.typicode.com/posts/');
  final responseJson=json.decode(response.body);
  
  for(int i=0; i<responseJson.length; i++){
_list.add(new Post.fromJson(responseJson[i]));
  }

  return _list;
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fetch Data Example'),
      ),
          body: new Center(
                      child: new FutureBuilder<List<Post>>(
        future: fetchPost(),
        builder: (context, snapshot){
        if(snapshot.hasData){
          //  return new Text(snapshot.data.title);
          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return new Card(
                color: Colors.grey[200],
                elevation: 4.0,
                margin: new EdgeInsets.all(16.0),
                              child: new Column(
                  children: <Widget>[
                     new Text('${snapshot.data[index].title}',
                     style: new TextStyle(
                       fontSize: 15.0,
                       fontWeight: FontWeight.bold
                     ),),
                     new Divider(
                       height: 1.0,
                       color: Colors.grey,
                     ),
                     new Text('${snapshot.data[index].body}'),
                  ],
                ),
              );
            },
          );
        }
        else if(snapshot.hasError){
            return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
        },
        
      ),
          ),
    );
  }
}