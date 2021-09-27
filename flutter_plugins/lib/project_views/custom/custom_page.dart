import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/widgets/flexible_space_bar.dart';
import 'package:plugins/app/widgets/load_image.dart';
import 'package:plugins/app/widgets/state_layout.dart';
import 'package:plugins/project_views/custom/provider/custom_page_provider.dart';
import 'package:plugins/project_views/custom/views/custom_list_page.dart';
import 'package:plugins/project_views/custom/views/my_card.dart';
import 'package:plugins/r.dart';
import 'package:plugins/routers/custom_routers_provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// design/3订单/index.html
class CustomPage extends StatefulWidget {
  const CustomPage({Key? key}) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage>
    with
        AutomaticKeepAliveClientMixin<CustomPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController? _tabController;
  CustomPageProvider provider = CustomPageProvider();

  int _lastReportedPage = 0;
  final List<Widget> _tabList = [
    _TabView('plugin1', 0),
    _TabView('plugin2', 1),
    _TabView('plugin3', 2),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDart();
    return ChangeNotifierProvider<CustomPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            /// 像素对齐问题的临时解决方法
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark
                    ? null
                    : const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colours.app_main,
                            Color(0xFF4647FA)
                          ]),
                        ),
                      ),
              ),
            ),
            NestedScrollView(
              key: const Key('order_list'),
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  _sliverBuilder(context),
              body: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  /// PageView的onPageChanged是监听ScrollUpdateNotification，会造成滑动中卡顿。这里修改为监听滚动结束再更新、
                  if (notification.depth == 0 &&
                      notification is ScrollEndNotification) {
                    final PageMetrics metrics =
                        notification.metrics as PageMetrics;
                    final int currentPage = (metrics.page ?? 0).round();
                    if (currentPage != _lastReportedPage) {
                      _lastReportedPage = currentPage;
                      _onPageChange(currentPage);
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: _tabList.length,
                  controller: _pageController,
                  itemBuilder: (_, index) {
                    if(index < customRouters().length)
                    {
                      return CustomListPage(index: index);
                    }
                    return StateLayout(type: StateType.empty);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    final Color? _iconColor = Colors.white;
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final tempThemeMode = await AdaptiveTheme.getThemeMode();
                if (tempThemeMode == AdaptiveThemeMode.light) {
                  savedThemeMode = AdaptiveThemeMode.dark;
                  AdaptiveTheme.of(context).setDark();
                } else {
                  savedThemeMode = AdaptiveThemeMode.light;
                  AdaptiveTheme.of(context).setLight();
                }
              },
              tooltip: '搜索',
              icon: LoadAssetImage(
                R.assetsImagesIconEllipsis,
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: Container(
              height: 113.0,
              color: Theme.of(context).primaryColor,
            ),
            centerTitle: true,
            titlePadding:
                const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text(
              '自定义 Widget',
              style: TextStyle(color: ThemeUtils.getIconColor(context)),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyCard(
                child: Container(
                  height: 80.0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor:
                        ThemeUtils.isDart() ? Colours.dark_text : Colours.text,
                    unselectedLabelColor: ThemeUtils.isDart()
                        ? Colours.dark_text_gray
                        : Colours.text,
                    labelStyle: TextStyles.textBold14,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: Dimens.font_sp14,
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: _tabList,
                    onTap: (index) {
                      if (!mounted) {
                        return;
                      }
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          80.0,
        ),
      ),
    ];
  }

  final PageController _pageController = PageController(initialPage: 0);
  Future<void> _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController?.animateTo(index, duration: Duration.zero);
  }
}

class _TabView extends StatelessWidget {
  const _TabView(this.tabName, this.index);

  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tabName),
            Consumer<CustomPageProvider>(
              builder: (_, provider, child) {
                return Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      '',
                      style: const TextStyle(fontSize: Dimens.font_sp12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
