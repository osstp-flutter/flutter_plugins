import 'package:plugins/app/plutins_item_entity.dart';
import 'package:plugins/app/utils/other_utils.dart';
import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/project_views/custom/views/my_card.dart';
import 'package:plugins/routers/navigator_router.dart';
import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({
    Key? key,
    required this.item,
    required this.tabIndex,
    required this.index,
  }) : super(key: key);

  final PluginsItemEntity item;
  final int tabIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: MyCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () =>
                  NavigatorRouter.push(context, item.router),
              child: _buildContent(context),
            ),
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    final TextStyle? textTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = ThemeUtils.isDart();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(item.title),
            ),
            Text(
              '✨ ${item.version}',
              style: TextStyle(
                fontSize: Dimens.font_sp12,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
        Gaps.vGap8,
        // 插件支持环境
        Text(
          item.supportPlatform,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        // 插件描述
        Text(item.description, style: textTextStyle),
        Gaps.vGap10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: '更新内容：'),
                    TextSpan(
                        text: item.updateContent,
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
              ),
            ),
            Text(
              item.updateTime,
              style: TextStyles.textSize12,
            ),
          ],
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        Row(
          children: <Widget>[
            CustomItemButton(
              key: Key('custom_button_1_$index'),
              text: 'Pub',
              textColor: isDark ? Colours.dark_text : Colours.text,
              bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
              onTap: () => _showCallPhoneDialog(context, ''),
            ),
            const Expanded(
              child: Gaps.empty,
            ),
            // CustomItemButton(
            //   key: Key('custom_button_2_$index'),
            //   text: orderLeftButtonText[tabIndex],
            //   textColor: isDark ? Colours.dark_text : Colours.text,
            //   bgColor: isDark ? Colours.dark_material_bg : Colours.bg_gray,
            //   onTap: () {
            //     if (tabIndex >= 2) {
            //       // NavigatorRouter.push(context, OrderRouter.orderTrackPage);
            //     }
            //   },
            // ),
            // if (orderRightButtonText[tabIndex].isEmpty)
            //   Gaps.empty
            // else
            //   Gaps.hGap10,
            // if (orderRightButtonText[tabIndex].isEmpty)
            //   Gaps.empty
            // else
            //   CustomItemButton(
            //     key: Key('custom_button_3_$index'),
            //     text: orderRightButtonText[tabIndex],
            //     textColor: isDark ? Colours.dark_button_text : Colors.white,
            //     bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
            //     onTap: () {
            //       if (tabIndex == 2) {}
            //     },
            //   ),
          ],
        )
      ],
    );
  }

  void _showCallPhoneDialog(BuildContext context, String url) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Text('是否打开?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => NavigatorRouter.goBack(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Utils.launchWebURL(url);
                NavigatorRouter.goBack(context);
              },
              style: ButtonStyle(
                // 按下高亮颜色
                overlayColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).errorColor.withOpacity(0.2)),
              ),
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomItemButton extends StatelessWidget {
  const CustomItemButton(
      {Key? key, this.bgColor, this.textColor, required this.text, this.onTap})
      : super(key: key);

  final Color? bgColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        constraints: const BoxConstraints(
          minWidth: 64.0,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),
        ),
      ),
      onTap: onTap,
    );
  }
}
