import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/widgets/load_image.dart';
import 'package:plugins/r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
class StateLayout extends StatelessWidget {
  const StateLayout({Key? key, required this.type, this.hintText})
      : super(key: key);

  final StateType type;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (type == StateType.loading)
          const CupertinoActivityIndicator(radius: 16.0)
        else if (type != StateType.onlyText)
          Opacity(
            // opacity: context.isDark ? 0.5 : 1,
            opacity: 1,

            child: LoadAssetImage(
              R.assetsImagesIconNone,
              width: 120,
            ),
          ),
        const SizedBox(
          width: double.infinity,
          height: Dimens.gap_dp16,
        ),
        Text(
          hintText ?? type.hintText,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  /// text
  onlyText,

  /// 无网络
  network,

  /// 加载中
  loading,

  /// 空
  empty,

  /// 错误
  error
}

extension StateTypeExtension on StateType {
  String get img =>
      <String>['', '', '', '', R.assetsImagesIconNone,][index];

  String get hintText =>
      <String>['', '无网络连接', '加载中...', '无数据', '❌',][index];
}
