import 'package:flutter/material.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/models/videomodel.dart';
import 'package:insight1/reusable/customtween.dart';
import 'package:insight1/reusable/overlay.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPalyer extends StatefulWidget {
  final VideoModel model;
  const VideoPalyer({Key? key, required this.model}) : super(key: key);

  @override
  State<VideoPalyer> createState() => _VideoPalyerState();
}

class _VideoPalyerState extends State<VideoPalyer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _video;

  String videourl = "";

  @override
  void initState() {
    _video = VideoPlayerController.network(widget.model.video[2].url)
      ..initialize().then((value) {
        _video!.play();
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _video!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Hero(
          tag: widget.model.title,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: _video!.value.isInitialized
                ? Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      OrientationBuilder(
                        builder: (context, orientation) {
                          return AspectRatio(
                            aspectRatio: orientation == Orientation.portrait ? _video!.value.aspectRatio : MediaQuery.of(context).size .width > MediaQuery.of(context).size .height ? MediaQuery.of(context).size .width / MediaQuery.of(context).size.height : MediaQuery.of(context).size.height / MediaQuery.of(context).size.width,
                            child: VideoPlayer(_video!),
                          );
                        }
                      ),
                      FutureBuilder(
                          future: Provider.of<StateManager>(context)
                              .getPosition(_video!),
                          builder: ((context, snapshot) {
                            // return Text(snapshot.data.toString());
                            return OverlayControls(
                              position: snapshot.data.toString(),
                              control: _video!,
                              ratio: _video!.value.aspectRatio,
                              duration: convertDuration(_video!.value.duration),
                            );
                          }))
                    ],
                  )
                : AspectRatio(
                    aspectRatio: _video!.value.aspectRatio,
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.model.imagePath),
                              fit: BoxFit.cover)),
                    ),
                  ),
          )),
    );
  }
}
String convertDuration(Duration pos) {
  var newposition = pos.inSeconds;

  var minString = "";
  var secString = "";

  var min = (newposition / 60).floor();
  if (min < 10) {
    minString = "0$min";
  } else {
    minString = "$min";
  }
  if (newposition < 10) {
    secString = "0$newposition";
  } else {
    secString = "$newposition";
  }

  return "$minString : $secString";
}

