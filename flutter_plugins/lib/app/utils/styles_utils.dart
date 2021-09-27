import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// 颜色
class Colours {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color orange = Color(0xFFFF8547);
}

class Dimens {
  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;

  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp24 = 24;
  static const double gap_dp32 = 32;
  static const double gap_dp50 = 50;
}


class Constant {

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;

  static bool isDriverTest  = false;
  static bool isUnitTest  = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

}

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {

  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap32 = SizedBox(width: Dimens.gap_dp32);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_dp32);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();

/// 补充一种空Widget实现 https://github.com/letsar/nil
/// https://github.com/flutter/flutter/issues/78159
}


class TextStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 =
  TextStyle(fontSize: Dimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
  TextStyle(fontSize: Dimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
  TextStyle(fontSize: Dimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
  TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 =
  TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.text_gray,
      fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.dark_text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_sp14, color: Colours.dark_line);
}
