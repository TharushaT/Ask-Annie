import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;
import 'package:moviedatabase/backend/chat_handling.dart';
Future<void> _fetchData (String user_message) async{
  Map<String, String> headers = {
    'Authorization': 'Bearer Replace_Your_Token',
    "Accept": "application/json",
    "content-type": "application/json"
  };
  var url = Uri.https('api.cohere.ai', 'v1/generate');

  final response = await http.post(url,
      body: jsonEncode(
        {
          "max_tokens": 1000,
          "return_likelihoods": "NONE",
          "truncate": "END",
          "prompt": "$user_message"
        },
      ),
      headers: headers);

  //var decodedRespnose = jsonDecode(response.body);
  print(user_message);
  var jsonBody = await jsonDecode(response.body);
  final message =
  jsonBody['generations'][0]["text"].toString().replaceAll("}", "");
  print(message);

  basicSample.add(ChatMessage(
      user: user1, createdAt: DateTime.now(), text: message));
}