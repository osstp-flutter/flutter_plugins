import 'package:plugins/app/utils/styles_utils.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/widgets/double_tap_back_exit_app.dart';
import 'package:plugins/app/widgets/load_image.dart';
import 'package:plugins/project_views/custom/custom_page.dart';
import 'package:plugins/project_views/others/others_page.dart';
import 'package:plugins/project_views/setting/setting_page.dart';
import 'package:plugins/r.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarStateProvider extends RestorableInt {
  BottomBarStateProvider() : super(0);
}

class BottomBarState extends StatefulWidget {
  const BottomBarState({Key? key}) : super(key: key);
  @override
  _BottomBarStateState createState() => _BottomBarStateState();
}

class _BottomBarStateState extends State<BottomBarState> with RestorationMixin {
  static const double _imageSize = 25.0;
  BottomBarStateProvider provider = BottomBarStateProvider();
  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  /// 模块分类
  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['others', 'custom', 'temp'];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const OthersPage(),
      CustomPage(),
      SettingPage(
        title: 'temp',
      ),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      final _tabImages = [
        [
          LoadAssetImage(
            R.assetsImagesIconOthers,
            width: _imageSize,
            color: Colours.text_gray_c,
          ),
          LoadAssetImage(
            R.assetsImagesIconOthers,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
        [
          LoadAssetImage(
            R.assetsImagesIconCustom,
            width: _imageSize,
            color: Colours.text_gray_c,
          ),
          LoadAssetImage(
            R.assetsImagesIconCustom,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
        [
          LoadAssetImage(
            R.assetsImagesIconSetting,
            width: _imageSize,
            color: Colours.text_gray_c,
          ),
          LoadAssetImage(
            R.assetsImagesIconSetting,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      final _tabImagesDark = [
        [
          LoadAssetImage(
            R.assetsImagesIconOthers,
            width: _imageSize,
            color: Colours.app_main,
          ),
          LoadAssetImage(
            R.assetsImagesIconOthers,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
        [
          LoadAssetImage(R.assetsImagesIconCustom,
              width: _imageSize, color: Colours.app_main),
          LoadAssetImage(
            R.assetsImagesIconCustom,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
        [
          LoadAssetImage(R.assetsImagesIconSetting,
              width: _imageSize, color: Colours.app_main),
          LoadAssetImage(
            R.assetsImagesIconSetting,
            width: _imageSize,
            color: Colours.orange,
          ),
        ],
      ];

      _listDark = List.generate(_tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImagesDark[i][0],
          activeIcon: _tabImagesDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeUtils.isDart();

    return ChangeNotifierProvider<BottomBarStateProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
            bottomNavigationBar: Consumer<BottomBarStateProvider>(
              builder: (_, provider, __) {
                return BottomNavigationBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  items: isDark
                      ? _buildDarkBottomNavigationBarItem()
                      : _buildBottomNavigationBarItem(),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: provider.value,
                  elevation: 5.0,
                  iconSize: 21.0,
                  selectedFontSize: Dimens.font_sp10,
                  unselectedFontSize: Dimens.font_sp10,
                  selectedItemColor: Colours.orange,
                  // unselectedItemColor: isDark
                  //     ? Colours.dark_unselected_item_color
                  //     : Colours.unselected_item_color,
                  onTap: (index) => _pageController.jumpToPage(index),
                );
              },
            ),
            // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
            body: PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
              controller: _pageController,
              onPageChanged: (int index) => provider.value = index,
              children: _pageList,
            )),
      ),
    );
  }

  @override
  String? get restorationId => 'BottomBarState';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}
