class Post{
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId,this.id,this.title,this.body});

  factory Post.fromJson(Map<String, dynamic> json){
    return new Post(body: json['body'],
    id: json['id'],
    title: json['title'],
    userId: json['userId'],
    );
  }
}