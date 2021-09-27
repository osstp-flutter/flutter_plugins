import 'package:plugins/r.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.holderImg = '',
    this.cacheWidth,
    this.cacheHeight,
  })  : assert(image != null, 'The [image] argument must not be null.'),
        super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String holderImg;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    if (image.startsWith('http')) {
      final Widget _image = LoadAssetImage(
          holderImg.isEmpty ? R.assetsImagesIconNone : holderImg,
          height: height,
          width: width,
          fit: fit);
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: (_, __) => _image,
        errorWidget: (_, __, dynamic error) => _image,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else {
      return LoadAssetImage(
        image,
        height: height,
        width: width,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.cacheWidth,
      this.cacheHeight,
      this.fit,
      this.color})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image.isEmpty ? R.assetsImagesIconNone : image,
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
