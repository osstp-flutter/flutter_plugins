import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? getHref() {
  return null;
}

class SettingPage extends StatefulWidget {
  SettingPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    final href = getHref();
    int? index = href?.indexOf("#");
    if (href != null && index != null && index > 0) {
      String uri = href;
      String key = uri.substring(index + 1, uri.length);
      if (key.isNotEmpty && key.length > 3) {
        var result = Uri.decodeFull(key);
        // if (routers.keys.contains(result) && result != "/") {
        //   Future(() {
        //     Navigator.pushNamed(context, result);
        //   });
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // var routeLists = routers.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: new Container(
        // child: new ListView.builder(
        //   itemBuilder: (context, index) {
          //   return new InkWell(
          //     onTap: () {
          //       Navigator.of(context).pushNamed(routeLists[index]);
          //     },
          //     child: new Card(
          //       child: new Container(
          //         alignment: Alignment.centerLeft,
          //         margin: EdgeInsets.symmetric(horizontal: 10),
          //         height: 50,
          //         child: new Text(routers.keys.toList()[index]),
          //       ),
          //     ),
          //   );
          // },
          // itemCount: routers.length,
        // ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

