import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/models/user.dart';
import 'package:focial/screens/profile/edit_profile_controller.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/debouncer.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';

void main() => runApp(
      MaterialApp(
        home: EditProfileScreen(
          user: User(),
        ),
      ),
    );

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final contentPadding =
      EdgeInsets.only(left: 0.0, right: 8.0, top: 8.0, bottom: 8.0);
  final border = UnderlineInputBorder();

  final editProfileBloc = EditProfileBloc();
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    editProfileBloc.add(UpdateUser(widget.user));
    super.initState();
  }

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
      body: SafeArea(
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          cubit: editProfileBloc,
          buildWhen: (c, p) {
            print("State: ${c.status} ${p.status}");
            return c.status != p.status || c.usernameError != p.usernameError;
          },
          builder: (context, state) {
            return Form(
              key: editProfileBloc.formKey,
              child: _getUpdateProfileForm(state),
            );
          },
        ),
      ),
    );
  }

  void addUserUpdateEvent(User cu) {
    editProfileBloc.add(UpdateUser(cu));
  }

  Widget _getUpdateProfileForm(EditProfileState state) => ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 16.0),
          Text(
            'Basic details',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          TextFormField(
            initialValue: widget.user?.firstName,
            onSaved: (value) {
              state.currentUser.firstName = value;
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
            initialValue: widget.user?.lastName,
            onSaved: (value) {
              state.currentUser.lastName = value;
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Last name',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            validator: editProfileBloc.usernameValidation,
            initialValue: widget.user?.username,
            onSaved: (value) {
              state.currentUser.username = value;
            },
            keyboardType: TextInputType.name,
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) =>
                  newValue.copyWith(text: newValue.text.toLowerCase()))
            ],
            onChanged: (String value) {
              _debouncer.run(() => editProfileBloc.add(CheckUsername(value)));
            },
            decoration: InputDecoration(
                contentPadding: contentPadding,
                border: border,
                suffix: state.status == Status.Loading
                    ? SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: CircularProgressIndicator())
                    : SizedBox(),
                labelText: 'Username',
                prefixText: '@'),
          ),
          state.usernameChecked || state.usernameError
              ? Text(
                  '${state.usernameMessage}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: state.usernameError
                        ? AppTheme.errorColor
                        : state.usernameAvailable
                            ? Colors.green
                            : AppTheme.errorColor,
                  ),
                )
              : SizedBox(),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: widget.user?.bio,
            maxLines: 1,
            maxLength: 128,
            onSaved: (value) {
              state.currentUser.bio = value;
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              border: border,
              labelText: 'Bio',
            ),
          ),
          // SizedBox(height: 8.0),
          TextFormField(
            initialValue: widget.user?.age?.toString(),
            keyboardType: TextInputType.number,
            validator: editProfileBloc.validateAge,
            onSaved: (value) {
              state.currentUser.age = int.parse(value ?? "");
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
            initialValue: widget.user?.phone,
            validator: editProfileBloc.validatePhone,
            onSaved: (value) {
              state.currentUser.phone = value;
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
            initialValue: widget.user?.email,
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
            onPressed: () => editProfileBloc.add(ValidateForm(context)),
            text: 'UPDATE',
          ),
        ],
      );
}
