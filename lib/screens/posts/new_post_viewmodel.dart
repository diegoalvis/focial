import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ChangeNotifier,
        Colors,
        FocusScope,
        TextEditingController;
import 'package:focial/models/post_feed.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/post_feed.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ots/ots.dart';

class NewPostViewModel extends ChangeNotifier {
  BuildContext _context;
  var postPicture;
  List<String> _images = [];
  final TextEditingController captionController = TextEditingController();
  String _captionError;

  void init(BuildContext context) {
    _context = context;
    _listen();
  }

  void _listen() {
    captionController.addListener(() {
      if (captionController.text.length > 0) {
        captionError = null;
      } else {
        captionError = "Write something to post";
      }
    });
  }

  Future<void> post() async {
    if (images.length == 0 && captionController.text.length == 0) {
      captionError = "Write something to post";
    } else {
      FocusScope.of(_context).requestFocus(FocusNode());
      captionError = null;
      showLoader();
      final response = await find<PostFeedService>()
          .newPost(PostFeed(caption: captionController.text, images: images));
      if (response.isSuccessful) {
        // todo: update posts count in profile after successful post
        Navigator.of(_context).pop();
      } else {
        AppOverlays.showError(
            'Post failed', "Unable to publish your post, please try later");
      }
      hideLoader();
    }
  }

  Future<void> addImage() async {
    postPicture = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (postPicture != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: postPicture.path,
        // aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          // initAspectRatio: CropAspectRatioPreset.ratio3x2,
          // lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        showLoader();
        final response =
            await find<APIService>().api.uploadPostImage(croppedFile.path);
        hideLoader();
        if (response.isSuccessful) {
          _images.add(response.body["url"]);
          notifyListeners();
          print(images);
        }
      }
    }
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
    notifyListeners();
  }

  String get captionError => _captionError;

  set captionError(String value) {
    _captionError = value;
    notifyListeners();
  }
}
