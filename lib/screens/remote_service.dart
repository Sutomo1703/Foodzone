import 'package:flutter_foodzone/screens/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    // var uri = Uri.parse("https://api.jsonbin.io/b/62a88900402a5b3802276405");
    var uri = Uri.parse("https://api.jsonbin.io/b/62bc1bd0449a1f38212218a3");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
  }
}