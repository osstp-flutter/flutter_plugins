import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/widgets/load_image.dart';
import 'package:plugins/app/widgets/state_layout.dart';
import 'package:plugins/project_views/others/provider/others_page_provider.dart';
import 'package:plugins/project_views/others/views/others_list_page.dart';
import 'package:plugins/project_views/search/search_page.dart';
import 'package:plugins/r.dart';
import 'package:plugins/routers/others_routers_provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
class OthersPage extends StatefulWidget {
  const OthersPage({Key? key}) : super(key: key);
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey _bodyKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();
  OthersPageProvider provider = OthersPageProvider();

  final List<Widget> _tabList = [
    _TabView('Dart', 0),
    _TabView('Flutter', 1),
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? _iconColor = Colors.white;
    return ChangeNotifierProvider<OthersPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Plugins'),
          actions: <Widget>[
            IconButton(
              tooltip: '搜索',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ));
              },
              icon: LoadAssetImage(
                R.assetsImagesIconSearch,
                key: const Key('search'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
            IconButton(
              tooltip: '主题切换',
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
              icon: LoadAssetImage(
                R.assetsImagesIconEllipsis,
                key: const Key('ellipsis'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
          ],
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
              ),
              alignment: Alignment.centerLeft,
              // 隐藏点击效果
              padding: const EdgeInsets.only(left: 16.0),
              // color: context.backgroundColor,
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colours.dark_bg_color,
                labelColor: Colours.app_main,
                indicatorPadding: const EdgeInsets.only(right: 98.0 - 36.0),
                tabs: _tabList,
              ),
            ),
            Gaps.line,
            Expanded(
              child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: _tabList.length,
                  onPageChanged: _onPageChange,
                  controller: _pageController,
                  itemBuilder: (_, int index) {
                    if (index < othersRouters().length) {
                      return OthersListPage(index: index);
                    }
                    return StateLayout(type: StateType.empty);
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _tabController?.animateTo(index);
    provider.setIndex(index);
  }

  @override
  bool get wantKeepAlive => true;
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
            Consumer<OthersPageProvider>(
              builder: (_, provider, child) {
                return Visibility(
                  visible: !(provider.countList[index] == 0 ||
                      provider.index != index),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      ' (${provider.countList[index]})',
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
