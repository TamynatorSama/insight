import 'package:flutter/material.dart';
import 'package:insight1/logic/apicall.dart';
import 'package:insight1/logic/game_logic.dart';
import 'package:insight1/models/quiz_model.dart';
import 'package:insight1/screens/main_game_screen.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<QuizModel> model = [];
  List optionsedit = [];

  getQuiz() async {
    var list = await HttpReq.request.getquiz();
    for (int i = 0; i < list.length; i++) {
      List current = [];
      for (int j = 0; j < list[i].incorrectAnswers.length; j++) {
        current.add(list[i].incorrectAnswers[j]);
      }
      current.add(list[i].correctAnswers);
      current = current..shuffle();

      optionsedit.add(current);
    }
    setState(() {
      model = list;
    });
    // return list;
  }

  int play = 0;
  bool clicked = false;
  bool clickable = true;

  int question = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.cover)),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(create: (_)=> GameLogic(),child: const GameScreen(),)));
              },
              child: Text(
                "Play",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'game',
                  fontSize: MediaQuery.of(context).size.shortestSide / 6,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(content: Text('score board')));
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => const GameScreen()));
              },
              child: Text(
                "Score",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'game',
                  fontSize: MediaQuery.of(context).size.shortestSide / 6,
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
