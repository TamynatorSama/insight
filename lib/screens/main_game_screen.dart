import 'package:flutter/material.dart';
import 'package:insight1/logic/game_logic.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _widthSize;
  PageController? _questionController;

  @override
  void initState() {
    _questionController = PageController(initialPage: 0);

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _widthSize = Tween<double>(begin: 0, end: 1000).animate(_controller!);

    _controller!.forward();
    _controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _questionController!.dispose();
    super.dispose();
  }

  int answer = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/back.jpg'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          alignment: AlignmentDirectional.centerStart,
                          width: _widthSize!.value,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: SettingsHandler().accentColor,
                              borderRadius: BorderRadius.circular(50)),
                          duration: _controller!.duration ??
                              const Duration(seconds: 5),
                        ),
                        const Positioned(
                            right: 5,
                            child: Icon(
                              Icons.timer,
                              color: Color.fromARGB(255, 44, 44, 44),
                            )),
                      ],
                    ),
                  ),
                  Text(
                    "Question ${Provider.of<GameLogic>(context).question} / 10",
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _questionController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 30),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 15, 8, 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.07),
                                  child: const Text(
                                    "How many type of stacks are currently present in the programming world",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 26, 26, 26),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (index) {
                                        return Consumer<GameLogic>(
                                            builder: (context, value, child) {
                                          return !value.answered
                                              ? InkWell(
                                                  child: Container(
                                                    key: Key(index.toString()),
                                                    width: double.maxFinite,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 18,
                                                        horizontal: 15),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const FittedBox(
                                                            child:
                                                                Text("help")),
                                                        Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Provider.of<GameLogic>(
                                                            context,
                                                            listen: false)
                                                        .stopAnim(
                                                            _controller!);
                                                    Provider.of<GameLogic>(
                                                            context,
                                                            listen: false)
                                                        .choose(index,
                                                            _questionController!);
                                                  },
                                                )
                                              : Container(
                                                  key: Key(index.toString()),
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 18,
                                                      horizontal: 15),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: value.selected ==
                                                                  answer
                                                              ? index ==
                                                                      value
                                                                          .selected
                                                                  ? Colors.green
                                                                  : Colors.grey
                                                              : index ==
                                                                      value
                                                                          .selected
                                                                  ? Colors.red
                                                                  : index ==
                                                                          answer
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const FittedBox(
                                                          child: Text("help")),
                                                      Container(
                                                          // alignment: AlignmentDirectional.topCenter,
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.red,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          child: Icon(value
                                                                      .selected ==
                                                                  answer
                                                              ? index ==
                                                                      value
                                                                          .selected
                                                                  ? Icons
                                                                      .check_circle
                                                                  : null
                                                              : index ==
                                                                      value
                                                                          .selected
                                                                  ? Icons.cancel
                                                                  : index ==
                                                                          answer
                                                                      ? Icons
                                                                          .check_circle
                                                                      : null))
                                                    ],
                                                  ));
                                        });
                                      })),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
