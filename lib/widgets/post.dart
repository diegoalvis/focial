import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focial/models/author_data.dart';
import 'package:focial/models/post_feed.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PostWidget(
              postFeed: PostFeed(
                  type: 1,
                  likes: 0,
                  liked: false,
                  images: [
                    "https://images.pexels.com/photos/755405/pexels-photo-755405.jpeg"
                    // "https://images.pexels.com/photos/189349/pexels-photo-189349.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    // "https://images.pexels.com/photos/552779/pexels-photo-552779.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    // "https://images.pexels.com/photos/33545/sunrise-phu-quoc-island-ocean.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                  ],
                  caption: "Hacktober fest 2020 is back",
                  authorData: AuthorData(
                    id: "asdf",
                    photoUrl:
                        "https://media-exp1.licdn.com/dms/image/C5103AQFacJu5TAdLbA/profile-displayphoto-shrink_200_200/0?e=1606348800&v=beta&t=bZgzIv5SaWMbasnBOo_3Kx7yGwqYCfUklgWvZkfQqO4",
                    username: "fayaz07",
                  )),
            ),
          ),
        ),
      ),
    );

class PostWidget extends StatelessWidget {
  final PostFeed postFeed;

  const PostWidget({Key key, this.postFeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 8.0),
              CircleAvatar(
                radius: 16.0,
                backgroundImage:
                    CachedNetworkImageProvider(postFeed.authorData.photoUrl),
              ),
              SizedBox(width: 12.0),
              Text(
                postFeed.authorData.username,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          postFeed.images != null && postFeed.images.length > 0
              ? getImages(context)
              : SizedBox(),
          // : Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Text(
              postFeed.caption,
            ),
          ),
          Divider(
            height: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 32.0,
                  child: Row(
                    children: [
                      LikeButton(
                        initiallyLiked: postFeed.liked,
                      ),
                      SizedBox(width: 16.0),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Icon(FontAwesomeIcons.commentAlt),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      "${postFeed.likes} likes",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getImages(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0),
        SizedBox(
          height: 300.0,
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: postFeed.images.length,
            itemBuilder: (context, i) => _getStackedImageWithButton(i),
          ),
        ),
      ],
    );
  }

  Widget _getStackedImageWithButton(int i) {
    return Stack(
      children: [
        Positioned.fill(
          child: _getImage(i),
        ),
        // Positioned(
        //   bottom: 0.0,
        //   right: 0.0,
        //   child: IconButton(
        //     onPressed: (){
        //
        //     },
        //     icon: Icon(
        //       Icons.fullscreen,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 12.0,
          right: 12.0,
          child: Text(
            "${i + 1}/${postFeed.images.length}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 12.0,
          child: Text(
            "@${postFeed.authorData.username}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _getImage(int i) {
    return CachedNetworkImage(
      imageUrl: postFeed.images[i],
      fit: BoxFit.cover,
      repeat: ImageRepeat.noRepeat,
      progressIndicatorBuilder: (context, data, progress) {
        return Center(
          child: CircularProgressIndicator(
            // value: (progress.downloaded > 0 ? progress.downloaded : 100.0) /
            //     (progress.totalSize ?? 100.0),
            value: progress.progress ?? 100.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.grey.withOpacity(0.3),
          ),
        );
      },
    );
  }
}

class LikeButton extends StatefulWidget {
  final bool initiallyLiked;
  final Function(bool) onChanged;

  const LikeButton({Key key, this.initiallyLiked = false, this.onChanged})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool _liked;
  AnimationController _likeAnimController;
  Animation<double> _likeAnimation;

  @override
  void initState() {
    _liked = widget.initiallyLiked;
    _likeAnimController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _likeAnimation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: _likeAnimController,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack));
    _likeAnimController.forward(from: 0.98);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _likeAnimation,
      builder: (context, child) => Transform.scale(
        scale: _likeAnimation.value,
        child: InkWell(
          splashColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _liked
                ? Icon(FontAwesomeIcons.solidHeart, color: Colors.red)
                : Icon(
                    FontAwesomeIcons.heart,
                  ),
          ),
          onTap: () {
            setState(() {
              _liked = !_liked;
            });
            _likeAnimController.forward(from: 0.4);
            if (widget.onChanged != null) widget.onChanged(_liked);
          },
        ),
      ),
    );
  }
}
