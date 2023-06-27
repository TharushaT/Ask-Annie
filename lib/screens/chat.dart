import 'dart:async';
import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:moviedatabase/backend/chat_handling.dart';
import 'package:http/http.dart' as http;
import 'package:moviedatabase/screens/dev.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  State<Basic> createState() => BasicState();
}

class BasicState extends State<Basic> {
  List<ChatMessage> messages = basicSample;

  var user_message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading:false,
            backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Developer()));
                  },
                  child: const Icon(
                      Icons.contactless_rounded
                  ),
                ),
                const SizedBox(width: 20,)
              ],
            )
          ],
          title: const Text(
            'Ask Annie',
            style: TextStyle(color: Colors.white60),
          ),
        ),
        body: FutureBuilder(
          future: _fetchData(user_message),
          builder: (context, snapshot) {
            return Container(
              color:ThemeData.dark().primaryColor,
              child: DashChat(

                inputOptions:  InputOptions(
                    sendOnEnter: true,
                    inputToolbarStyle:
                        BoxDecoration(color: ThemeData.dark().cardColor),),
                currentUser: user,
                scrollToBottomOptions: const ScrollToBottomOptions(
                  disabled: false,
                ),
                messageOptions:  MessageOptions(
                  containerColor: ThemeData.dark().canvasColor,
                  currentUserContainerColor: ThemeData.dark().dialogBackgroundColor,
                  textColor: Colors.white,
                  currentUserTextColor: Colors.white,
                  currentUserTimeTextColor: Colors.white60,
                  showOtherUsersName: true,
                  showOtherUsersAvatar: true,
                  showTime: true,
                ),
                onSend: (ChatMessage m) async {
                  user_message = m.text;
                  _fetchData(user_message);

                  setState(() {
                    messages.add(m);
                  });
                },
                messages: messages.reversed.toList(),
                messageListOptions: MessageListOptions(
                  onLoadEarlier: () async {
                    await Future.delayed(const Duration(seconds: 3));
                  },
                ),
              ),
            );
          },
        ));
  }
}

Future<void> _fetchData(String userMessage) async {
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
          "prompt": userMessage
        },
      ),
      headers: headers);

  //var decodedRespnose = jsonDecode(response.body);

  var jsonBody = await jsonDecode(response.body);
  final message = jsonBody['generations'][0]["text"].toString().substring(1);

  basicSample
      .add(ChatMessage(user: user1, createdAt: DateTime.now(), text: message));
}
