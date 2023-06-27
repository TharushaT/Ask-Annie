

import 'package:moviedatabase/screens/chat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


_launchWhatsapp() async {
  var whatsapp = "+94761567331";
  var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  }

}



class Developer extends StatefulWidget {
  const Developer({Key? key}) : super(key: key);

  @override
  State<Developer> createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 5,),


                    IconButton(icon:Icon(Icons.close),onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Basic()));
                    },),

                  ],
                ),
              ),


           CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/index-cca5b.appspot.com/o/Cover%20(1).png?alt=media&token=6398a4a2-ea9f-4b10-9c97-ecb1b36d5603",height: 500,)

            ],
          ),
        ),
      ),

      );

  }
}