import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focial/utils/theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(home: CropPicture()));

class CropPicture extends StatefulWidget {
  @override
  _CropPictureState createState() => _CropPictureState();
}

class _CropPictureState extends State<CropPicture> {
  var pp;

  void _updateProfilePicture() async {
    ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80)
        .then((value) {
      // setState(() {
      //   pp = value;
      // });
      _cropAndUploadImage(value.path);
    });

    // if (pp != null) {
    //   final response = await APIService.api.storePicture(pp.path);
    //   if (response.isSuccessful) {
    //     print(response.body);
    //   } else {
    //     print('Unable to update user picture, please try later');
    //   }
    // }
  }

  bool cropped = false;

  _cropAndUploadImage(String path) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      pp = croppedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pp == null
            ? FlatButton(
                onPressed: () {
                  _updateProfilePicture();
                },
                child: Text("upload"))
            : Image.file(
                File(pp.path),
              ),
      ),
    );
  }
}
