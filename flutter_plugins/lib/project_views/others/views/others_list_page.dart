import 'package:plugins/app/plutins_item_entity.dart';
import 'package:plugins/app/utils/other_utils.dart';
import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/utils/toast_utils.dart';
import 'package:plugins/app/widgets/refresh_list.dart';
import 'package:plugins/app/widgets/state_layout.dart';
import 'package:plugins/project_views/others/provider/others_page_provider.dart';
import 'package:plugins/project_views/others/views/others_item.dart';
import 'package:plugins/routers/navigator_router.dart';
import 'package:plugins/routers/others_routers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OthersListPage extends StatefulWidget {
  const OthersListPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _OthersListPageState createState() => _OthersListPageState();
}

class _OthersListPageState extends State<OthersListPage>
    with
        AutomaticKeepAliveClientMixin<OthersListPage>,
        SingleTickerProviderStateMixin {
  int _selectIndex = -1;
  late Animation<double> _animation;
  late AnimationController _controller;
  List<PluginsItemEntity> _list = [];
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    final _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation)
      ..addStatusListener((status) {
        _animationStatus = status;
      });
    _onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(othersRouters()[widget.index].length,
            (i) => othersWidgetBuilderEntityList[i]);
      });
      _setCount(_list.length);
    });
  }

  Future _loadMore() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(othersWidgetBuilderEntityList.length,
            (i) => othersWidgetBuilderEntityList[i]));
        _page++;
      });
      _setCount(_list.length);
    });
  }

  void _setCount(int count) {
//    Provider.of<OthersPageProvider>(context, listen: false).setCount(count);
    /// 与上方等价，provider 4.1.0添加的拓展方法
    context.read<OthersPageProvider>().setCount(count);
  }

  int _page = 1;
  late int _maxPage = 1;
  StateType _stateType = StateType.loading;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshListView(
      itemCount: _list.length,
      stateType: _stateType,
      onRefresh: _onRefresh,
      loadMore: _loadMore,
      hasMore: _page < _maxPage,
      pageSize: _list.length, // 设置底部显示
      itemBuilder: (_, index) {
        final String heroTag = '${widget.index}-$index';
        return TextButton(
          //标题自动为默认颜色
          onPressed: () {
            NavigatorRouter.push(context, _list[index].router);
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(1, 1)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: OthersItem(
            index: index,
            heroTag: heroTag,
            selectIndex: _selectIndex,
            item: _list[index],
            animation: _animation,
            onTapMenu: (index) {
              /// 点击其他item时，重置状态
              if (_selectIndex != index) {
                _animationStatus = AnimationStatus.dismissed;
              }

              /// 避免动画中重复执行
              if (_animationStatus == AnimationStatus.dismissed) {
                // 开始执行动画
                _controller.forward(from: 0.0);
              }
              setState(() {
                _selectIndex = index;
              });
              print("onTapMenu");
            },
            onTapMenuClose: () {
              if (_animationStatus == AnimationStatus.completed) {
                _controller.reverse(from: 1.1);
              }
              _selectIndex = -1;
              print("onTapMenuClose");
            },
            onTapOpenUrl: (index) {
              _controller.reverse(from: 1.1);
              _selectIndex = -1;
              if (_list[index].pubUrl.isEmpty && _list[index].gitUrl.isEmpty)
                EasyLoadingShow.showInfo("没有设置url");
              else
                _showDeleteBottomSheet(
                    _list[index].pubUrl, _list[index].gitUrl);
            },
            onTapOperation: (index) {
              NavigatorRouter.push(context, _list[index].router);
            },
            onTapUtilize: () {
              setState(() {
                _selectIndex = -1;
              });
              EasyLoadingShow.showInfo("功能未确定");
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _showDeleteBottomSheet(String pubUrl, String gitUrl) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertWithBottomSheet(
          onTapPubUrlUtilize: pubUrl.isEmpty
              ? null
              : () {
                  Utils.launchWebURL(pubUrl);
                },
          onTapGitUrlUtilize: gitUrl.isEmpty
              ? null
              : () {
                  Utils.launchWebURL(gitUrl);
                },
          onTapUtilize: () {
            setState(() {});
            _setCount(_list.length);
          },
        );
      },
    );
  }
}

class AlertWithBottomSheet extends StatelessWidget {
  const AlertWithBottomSheet({
    Key? key,
    this.onTapPubUrlUtilize,
    this.onTapGitUrlUtilize,
    this.onTapUtilize,
  }) : super(key: key);

  final VoidCallback? onTapPubUrlUtilize;
  final VoidCallback? onTapGitUrlUtilize;
  final VoidCallback? onTapUtilize;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  '是否打开？',
                  style: TextStyles.textSize16,
                ),
              ),
            ),
            Gaps.line,
            onTapPubUrlUtilize == null
                ? Gaps.empty
                : MyButton(
                    minHeight: 54.0,
                    textColor:
                        ThemeUtils.getTextSelectionThemeCursorColor(context),
                    text: 'Open Pub',
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      NavigatorRouter.goBack(context);
                      onTapPubUrlUtilize!();
                    },
                  ),
            onTapPubUrlUtilize == null ? Gaps.empty : Gaps.line,
            onTapGitUrlUtilize == null
                ? Gaps.empty
                : MyButton(
                    minHeight: 54.0,
                    textColor:
                        ThemeUtils.getTextSelectionThemeCursorColor(context),
                    text: 'Open Git',
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      NavigatorRouter.goBack(context);
                      onTapGitUrlUtilize!();
                    },
                  ),
            Gaps.line,
            MyButton(
              minHeight: 54.0,
              textColor: Colours.text_gray,
              text: '取消',
              backgroundColor: Colors.transparent,
              onPressed: () {
                NavigatorRouter.goBack(context);
                onTapUtilize!();
              },
            ),
          ],
        ),
      ),
    );
  }
}
