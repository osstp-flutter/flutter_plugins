import 'package:plugins/app/utils/toast_utils.dart';
import 'package:plugins/project_views/search/search_bar.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        hintText: '请输入名称查询',
        onPressed: (text) => EasyLoadingShow.showInfo('搜索内容：$text'),
      ),
      body: Container(),
    );
  }
}

