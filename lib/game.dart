import 'package:flutter/material.dart';
import 'package:flutter_application_home_work_final/game_logic.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  GameLogic gameLogic = GameLogic();

  @override
  void initState() {
    super.initState();
    gameLogic.initGame();
  }

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cards"),
        
      ),
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue,
                      image: const DecorationImage(
                        image: AssetImage('assets/animals/quest.png'),
                        fit: BoxFit.fill ),
                    

                    ),
                    child: Center(child: Text("Hello $index")),
                  );
                }),
          )),
    );
  }
}
