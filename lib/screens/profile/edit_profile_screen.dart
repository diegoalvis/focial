import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/profile/edit_profile_viewmodel.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/debouncer.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:stacked/stacked.dart';

class EditProfileScreen extends StatelessWidget {
  final contentPadding =
      EdgeInsets.only(left: 0.0, right: 8.0, top: 8.0, bottom: 8.0);
  final border = UnderlineInputBorder();

  final _debouncer = Debouncer(milliseconds: 300);

  EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          'Edit profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        onModelReady: (m) => m.init(context),
        builder: (context, model, child) => SafeArea(
          child: Form(
            key: model.formKey,
            child: _getUpdateProfileForm(model, context),
          ),
        ),
      ),
    );
  }

  Widget _getUpdateProfileForm(
          EditProfileViewModel controller, BuildContext context) =>
      ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 16.0),
          Text(
            'Basic details',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          TextFormField(
            initialValue: controller.currentUser?.firstName,
            onSaved: (value) {
              controller.currentUser.firstName = value;
            },
            validator: (v) {
              return null;
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'First name',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: controller.currentUser?.lastName,
            onSaved: (value) {
              controller.currentUser.lastName = value;
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Last name',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            validator: controller.usernameValidation,
            initialValue: controller.currentUser?.username,
            onSaved: (value) {
              controller.currentUser.username = value;
            },
            keyboardType: TextInputType.name,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) =>
                  newValue.copyWith(text: newValue.text.toLowerCase()))
            ],
            onChanged: (String value) {
              _debouncer.run(() => controller.checkUsername(value));
            },
            decoration: InputDecoration(
                contentPadding: contentPadding,
                border: border,
                suffix: controller.status == Status.Loading
                    ? SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: CircularProgressIndicator())
                    : SizedBox(),
                labelText: 'Username',
                prefixText: '@'),
          ),
          controller.usernameChecked || controller.usernameError
              ? Text(
                  '${controller.usernameMessage}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: controller.usernameError
                        ? AppTheme.errorColor
                        : controller.usernameAvailable
                            ? Colors.green
                            : AppTheme.errorColor,
                  ),
                )
              : SizedBox(),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: controller.currentUser?.bio,
            maxLines: 1,
            maxLength: 128,
            onSaved: (value) {
              controller.currentUser.bio = value;
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Bio',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: controller.currentUser?.age?.toString(),
            keyboardType: TextInputType.number,
            validator: controller.validateAge,
            onSaved: (value) {
              controller.currentUser.age = int.parse(value ?? "");
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Age',
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Contact details',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          TextFormField(
            initialValue: controller.currentUser?.phone,
            validator: controller.validatePhone,
            onSaved: (value) {
              controller.currentUser.phone = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Phone',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: controller.currentUser?.email,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 32.0),
          AppPlatformButton(
            height: 44.0,
            width: double.infinity,
            onPressed: () => controller.validateForm(context),
            text: 'UPDATE',
          ),
        ],
      );
}
