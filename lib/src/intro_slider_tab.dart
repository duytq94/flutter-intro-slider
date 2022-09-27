import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSliderTab extends StatelessWidget {
  const IntroSliderTab({
    super.key,
    required this.navigationBarConfig,
    this.contentConfig,
  });

  final NavigationBarConfig navigationBarConfig;
  final ContentConfig? contentConfig;

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      children: <Widget>[
        Container(
          // Title
          margin: contentConfig?.marginTitle ??
              const EdgeInsets.only(
                  top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
          child: contentConfig?.widgetTitle ??
              Text(
                contentConfig?.title ?? '',
                style: contentConfig?.styleTitle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                maxLines: contentConfig?.maxLineTitle ?? 1,
                textAlign: contentConfig?.textAlignTitle ?? TextAlign.center,
                overflow:
                    contentConfig?.textOverFlowTitle ?? TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: contentConfig?.onCenterItemPress,
          child: contentConfig?.pathImage != null
              ? Image.asset(
                  (contentConfig?.pathImage)!,
                  width: contentConfig?.widthImage ?? 200.0,
                  height: contentConfig?.heightImage ?? 200.0,
                  fit: contentConfig?.foregroundImageFit ?? BoxFit.contain,
                )
              : Center(
                  child:
                      contentConfig?.centerWidget ?? const SizedBox.shrink()),
        ),

        // Description
        Container(
          margin: contentConfig?.marginDescription ??
              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: contentConfig?.widgetDescription ??
              Text(
                contentConfig?.description ?? '',
                style: contentConfig?.styleDescription ??
                    const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign:
                    contentConfig?.textAlignDescription ?? TextAlign.center,
                maxLines: contentConfig?.maxLineTextDescription ?? 100,
                overflow: contentConfig?.textOverFlowDescription ??
                    TextOverflow.ellipsis,
              ),
        ),
      ],
    );
    Color? backgroundColor = contentConfig?.backgroundColor;
    String? backgroundImage = contentConfig?.backgroundImage;
    String? backgroundNetworkImage = contentConfig?.backgroundNetworkImage;
    Color? backgroundFilterColor = contentConfig?.backgroundFilterColor;
    ScrollbarBehavior? verticalScrollbarBehavior =
        contentConfig?.verticalScrollbarBehavior;
    double safeMarginContent =
        navigationBarConfig.padding.along(Axis.vertical) + 50;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage == null && backgroundNetworkImage == null
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        contentConfig?.colorBegin ?? Colors.transparent,
                        contentConfig?.colorEnd ?? Colors.transparent,
                      ],
                begin: contentConfig?.directionColorBegin ?? Alignment.topLeft,
                end: contentConfig?.directionColorEnd ?? Alignment.bottomRight,
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
              image: backgroundImage != null
                  ? AssetImage(backgroundImage)
                  : NetworkImage(backgroundNetworkImage!) as ImageProvider,
              fit: contentConfig?.backgroundImageFit ?? BoxFit.cover,
              colorFilter: ColorFilter.mode(
                backgroundFilterColor != null
                    ? backgroundFilterColor.withOpacity(
                        contentConfig?.backgroundFilterOpacity ?? 0.5)
                    : Colors.black.withOpacity(
                        contentConfig?.backgroundFilterOpacity ?? 0.5),
                contentConfig?.backgroundBlendMode ?? BlendMode.darken,
              ),
            )),
      child: Container(
        margin: EdgeInsets.only(
          top: navigationBarConfig.navPosition == NavPosition.top
              ? safeMarginContent
              : 0,
          bottom: navigationBarConfig.navPosition == NavPosition.bottom
              ? safeMarginContent
              : 0,
        ),
        child: verticalScrollbarBehavior != ScrollbarBehavior.hide
            ? Scrollbar(
                thumbVisibility:
                    verticalScrollbarBehavior == ScrollbarBehavior.alwaysShow,
                child: listView,
              )
            : listView,
      ),
    );
  }
}
