import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class OverlayControls extends StatefulWidget {
  final String position;
  final String duration;
  final VideoPlayerController control;
  final double ratio;

  const OverlayControls(
      {Key? key,
      required this.position,
      required this.control,
      required this.ratio,
      required this.duration})
      : super(key: key);

  @override
  State<OverlayControls> createState() => _OverlayControlsState();
}

class _OverlayControlsState extends State<OverlayControls>
    with TickerProviderStateMixin {
  AnimationController? _control;
  AnimationController? _opacity;
  AnimationController? _right;
  AnimationController? _left;
  bool offstage = false;

  @override
  void initState() {
    _control = AnimationController(
        vsync: this, duration: const Duration(microseconds: 500));
    _opacity = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _right = AnimationController(
        vsync: this, duration: const Duration(microseconds: 150));
    _left = AnimationController(
        vsync: this, duration: const Duration(microseconds: 150));
    _opacity!.forward();
    Timer.periodic(const Duration(seconds: 9), (time) {
      _opacity!.reverse().then((value) => setState(() {
            offstage = true;
          }));
    });
    super.initState();
  }

  @override
  void dispose() {
    _control!.dispose();
    _opacity!.dispose();
    _right!.dispose();
    _left!.dispose();
    widget.control.dispose();
    reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var settings = SettingsHandler();

    bool landscape = Provider.of<StateManager>(context).setLandscape;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        widget.control.value.isBuffering
            ? const CircularProgressIndicator(color: Colors.white)
            : const SizedBox(),
        GestureDetector(
          //takes care of the hiding and showing the overlay
          onTap: () {
            setState(() {
              offstage = false;
            });
            _opacity!.forward();
            Timer(const Duration(seconds: 9), () {
              _opacity!.reverse().then((value) => setState(() {
                    offstage = true;
                  }));
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: OrientationBuilder(builder: (context, orientation) {
              return AspectRatio(
                aspectRatio: orientation == Orientation.portrait
                    ? widget.ratio
                    : MediaQuery.of(context).devicePixelRatio,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onDoubleTap: () {
                              //seeking backward function
                              _left!.forward();
                              Timer.periodic(const Duration(seconds: 1),
                                  (time) {
                                _left!.reverse();
                              });
                              widget.control.seekTo(
                                  widget.control.value.position -
                                      const Duration(seconds: 3));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 100),
                              alignment: Alignment.center,
                              color: Colors.black.withOpacity(0),
                              width: double.maxFinite,
                              child: AnimatedOpacity(
                                opacity: _left!.value,
                                duration: _left!.duration ??
                                    const Duration(seconds: 1),
                                child: const Icon(
                                  Icons.replay_5,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _opacity!.value,
                          duration: _opacity!.duration ??
                              const Duration(milliseconds: 1000),
                          child: Stack(
                            children: [
                              IconButton(
                                splashColor: Colors.black.withOpacity(0.5),
                                splashRadius: 10,
                                onPressed: () {
                                  Provider.of<StateManager>(context,
                                          listen: false)
                                      .changebool(_control, widget.control);
                                },
                                icon: AnimatedIcon(
                                    icon: AnimatedIcons.pause_play,
                                    progress: _control!,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onDoubleTap: () {
                              _right!.forward();
                              Timer.periodic(const Duration(seconds: 1),
                                  (time) {
                                _right!.reverse();
                              });

                              widget.control.seekTo(
                                  widget.control.value.position +
                                      const Duration(seconds: 3));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 100),
                              alignment: Alignment.center,
                              color: Colors.black.withOpacity(0),
                              width: double.maxFinite,
                              child: AnimatedOpacity(
                                opacity: _right!.value,
                                duration: _right!.duration ??
                                    const Duration(milliseconds: 1000),
                                child: const Icon(
                                  Icons.forward_5,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    //progress indicator, timer , settings, flip_screen widget
                    Offstage(
                      offstage: offstage,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 11,
                              child: VideoProgressIndicator(
                                widget.control,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                    playedColor: settings.accentColor),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<StateManager>(context,
                                                listen: false)
                                            .changebool(
                                                _control, widget.control);
                                      },
                                      icon: AnimatedIcon(
                                          icon: AnimatedIcons.pause_play,
                                          progress: _control!,
                                          color: Colors.white),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        "${widget.position} / ${widget.duration}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            wordSpacing: -2,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: PopupMenuButton<String>(
                                          tooltip: "settings",
                                          offset: const Offset(4, -150),
                                          itemBuilder: (_) {
                                            return <PopupMenuEntry<String>>[];
                                          },
                                          child: const Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setLanscape(landscape);
                                          Provider.of<StateManager>(context,
                                                  listen: false)
                                              .setOrientation(context);
                                        },
                                        icon: const Icon(
                                          Icons.fit_screen,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

Future setLanscape(bool setland) async {
  if (!setland) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  } else {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}

Future reset() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
