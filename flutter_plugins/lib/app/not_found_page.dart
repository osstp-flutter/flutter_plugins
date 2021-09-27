import 'package:plugins/app/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面不存在'),
      ),
      body: StateLayout(
        type: StateType.error,
        hintText: '页面不存在',
      ),
    );
  }
}
