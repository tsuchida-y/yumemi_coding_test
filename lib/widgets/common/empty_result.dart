import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 検索結果が空の場合に表示するウィジェット
class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({super.key});

  // 定数定義
  static const double _padding = 16.0;
  static const double _landscapeSpacing = 24.0;
  static const double _portraitImageSize = 300.0;
  static const double _landscapeImageSize = 150.0;
  // Removed static _message; the localized string will be obtained using the provided context in build()



  /// 縦向きレイアウト構築メソッド
  Widget _buildPortraitLayout(
      Widget messageText, Widget Function(double) imageWidget) {
    return SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageWidget(_portraitImageSize),
              messageText,
            ],
          ),
        ),
    );
  }

  /// 横向きレイアウト構築メソッド
 Widget _buildLandscapeLayout(
      Widget messageText, Widget Function(double) imageWidget) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
           padding: EdgeInsets.symmetric(horizontal: (_padding + _landscapeSpacing) * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: imageWidget(_landscapeImageSize),
              ),
              const SizedBox(width: _landscapeSpacing),
              Flexible(
                flex: 3,
                child: messageText,
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {

    // 共通のテキストウィジェット
    final messageText = Text(
      AppLocalizations.of(context)!.no_results,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );

    // 共通の画像ウィジェット生成関数
    Widget imageWidget(double size) => Image.asset(
      'assets/not_found.png',
      width: size,
      height: size,
    );

    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? _buildPortraitLayout (messageText, imageWidget)// 縦向きレイアウト
            : _buildLandscapeLayout(messageText, imageWidget);// 横向きレイアウト
      },
    );
  }

}