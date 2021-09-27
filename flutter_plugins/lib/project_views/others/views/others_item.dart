import 'dart:math';
import 'package:plugins/app/plutins_item_entity.dart';
import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/widgets/load_image.dart';
import 'package:plugins/r.dart';
import 'package:flutter/material.dart';

///
class OthersItem extends StatelessWidget {
  const OthersItem({
    Key? key,
    required this.item,
    required this.index,
    required this.selectIndex,
    required this.onTapMenu,
    required this.onTapOpenUrl,
    required this.onTapOperation,
    required this.onTapUtilize,
    required this.onTapMenuClose,
    required this.animation,
    required this.heroTag,
  }) : super(key: key);

  final PluginsItemEntity item;
  final int index;
  final int selectIndex;
  final ValueChanged onTapMenu;
  final ValueChanged onTapOpenUrl;
  final ValueChanged onTapOperation;
  final VoidCallback onTapUtilize;
  final VoidCallback onTapMenuClose;
  final Animation<double> animation;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExcludeSemantics(
          child: Hero(
            tag: heroTag,
            child: LoadImage(item.icon, width: 72.0, height: 72.0),
          ),
        ),
        Gaps.hGap8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.vGap4,
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Visibility(
                    // 默认为占位替换，类似于gone
                    visible: true,
                    child: _OthersItemTag(// 标记，暂时未
                      text: '✨ ${item.version}',
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      // 修改透明度实现隐藏，类似于invisible
                      opacity: 1.0,
                      child: _OthersItemTag(
                        text: item.supportPlatform,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              Gaps.vGap4,
              Container(child: Text(item.description, style: TextStyles.textGray14,),)
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Semantics(
              /// container属性为true，防止上方ExcludeSemantics去除此处语义
              container: true,
              label: '菜单',
              child: GestureDetector(
                child: Container(
                  key: Key('others_menu_item_$index'),
                  width: 44.0,
                  height: 44.0,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 28.0, bottom: 28.0),
                  child: LoadAssetImage(R.assetsImagesIconEllipsis),
                ),
                onTap: () {
                  onTapMenu(index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '>>',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            )
          ],
        )
      ],
    );

    return Stack(
      children: <Widget>[
        // item间的分隔线
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: child,
            ),
          ),
        ),
        if (selectIndex != index) Gaps.empty else _buildOthersMenu(context),
      ],
    );
  }

  Widget _buildOthersMenu(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
          animation: animation,
          child: _buildOthersMenuContent(context),
          builder: (_, Widget? child) {
            return MenuReveal(revealPercent: animation.value, child: child!);
          }),
    );
  }

  Widget _buildOthersMenuContent(BuildContext context) {
    // final bool isDark = context.isDark;
    final bool isDark = true;
    final Color buttonColor = isDark ? Colours.dark_text : Colors.white;

    return InkWell(
      onTap: onTapMenuClose,
      child: Container(
        color: isDark ? const Color(0xB34D4D4D) : const Color(0x4D000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Gaps.hGap15,
            MyButton(
              key: Key('others_edit_item_$index'),
              text: 'URL',
              fontSize: Dimens.font_sp16,
              radius: 24.0,
              minWidth: 56.0,
              minHeight: 56.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              backgroundColor:
                  isDark ? Colours.dark_app_main : Colours.app_main,
              onPressed: () {
                onTapOpenUrl(index);
              },
            ),
            MyButton(
              key: Key('others_operation_item_$index'),
              text: 'SAMPLE',
              fontSize: Dimens.font_sp16,
              radius: 24.0,
              minWidth: 56.0,
              minHeight: 56.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              textColor: Colours.text,
              backgroundColor: buttonColor,
              onPressed: () {
                onTapOperation(index);
              },
            ),
            // MyButton(
            //   key: Key('others_delete_item_$index'),
            //   text: 'USE',
            //   fontSize: Dimens.font_sp16,
            //   radius: 24.0,
            //   minWidth: 56.0,
            //   minHeight: 56.0,
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   textColor: Colours.text,
            //   backgroundColor: buttonColor,
            //   onPressed: onTapUtilize,
            // ),
            Gaps.hGap15,
          ],
        ),
      ),
    );
  }
}

class _OthersItemTag extends StatelessWidget {
  const _OthersItemTag({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp10,
          // height: Device.isAndroid ? 1.1 : null,
        ),
      ),
    );
  }
}

/// 默认字号18，白字蓝底，高度48
class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.text = '',
    this.fontSize = Dimens.font_sp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {

    final bool isDark = ThemeUtils.isDart();

    return TextButton(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
        onPressed: onPressed,
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledTextColor ??
                    (isDark
                        ? Colours.dark_text_disabled
                        : Colours.text_disabled);
              }
              return textColor ??
                  (isDark ? Colours.dark_button_text : Colors.white);
            },
          ),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ??
                  (isDark
                      ? Colours.dark_app_main
                      : Colours.app_main);
            }
            return backgroundColor ??
                (isDark ? Colours.dark_app_main : Colours.app_main);
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ??
                    (isDark ? Colours.dark_button_text : Colors.white))
                .withOpacity(0.12);
          }),
          // 按钮最小大小
          minimumSize: (minWidth == null || minHeight == null)
              ? null
              : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(side),
        ));
  }
}

class MenuReveal extends StatelessWidget {
  const MenuReveal({Key? key, required this.revealPercent, required this.child})
      : super(key: key);

  final double revealPercent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  CircleRevealClipper(this.revealPercent);

  final double revealPercent;

  @override
  Rect getClip(Size size) {
    // 右上角的点击点为圆心
    final Offset epicenter = Offset(size.width - 25.0, 25.0);

    final double theta = atan(epicenter.dy / epicenter.dx);
    final double distanceToCorner = (epicenter.dy) / sin(theta);

    final double radius = distanceToCorner * revealPercent;
    final double diameter = 2 * radius;

    return Rect.fromLTWH(
        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
