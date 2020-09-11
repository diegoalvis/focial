import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/home/home_viewmodel.dart';
import 'package:focial/screens/stories/story_feed.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (m) => m.init(context),
        builder: (context, model, child) => SafeArea(
          child: _body(model),
        ),
      ),
    );
  }

  Widget _body(HomeViewModel model) {
    return ListView(
      children: [
        // New post & search button
        _newPostAndSearchButton(),
        // stories
        FocialStories(),
        SizedBox(height: 4.0),
        Divider(),
        // feed
      ],
    );
  }

  Widget _newPostAndSearchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.camera,
              color: Colors.grey,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.grey,
              size: 20.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
