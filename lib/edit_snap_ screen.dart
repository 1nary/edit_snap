import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as image_lib;

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key, required this.imageBitmap});

  final Uint8List imageBitmap;

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends State<ImageEditScreen> {
  late Uint8List _imageBitmap;

  @override
  void initState() {
    super.initState();
    _imageBitmap = widget.imageBitmap;
  }

  void _rotateImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    final rotateImage = image_lib.copyRotate(image, angle: 90);
    setState(() {
      _imageBitmap = image_lib.encodeBmp(rotateImage);
    });
  }

  void _flipImage() {
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    final flipImage = image_lib.copyFlip(image,
        direction: image_lib.FlipDirection.horizontal);
    setState(() {
      _imageBitmap = image_lib.encodeBmp(flipImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.imageEditScreenTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(_imageBitmap),
            /* ◆ IconButton
            アイコンを表示するボタン */
            IconButton(
              onPressed: () => _rotateImage(),
              icon: const Icon(Icons.rotate_left), // フレームワーク組み込みのアイコンを設定
            ),
            IconButton(
              onPressed: () => _flipImage(),
              icon: const Icon(Icons.flip), // フレームワーク組み込みのアイコンを設定
            ),
          ],
        ),
      ),
    );
  }
}
