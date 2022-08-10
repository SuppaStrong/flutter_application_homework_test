

class GameLogic {
  final String fontImage = "assets/animalspics/quest.png";
  final int cardCount = 8;
  List<String>? cardGame;
  final List<String> backImage = [
    "assets/animalspics/dino.png",
    "assets/animalspics/fish.png",
    "assets/animalspics/frog.png",
    "assets/animalspics/octo.png",
  ];
  List<Map<int, String>> checkEqual = [];

  void initGame() {
    cardGame = List.generate(cardCount, (index) => fontImage);
  }
}

class BackItems {
  final String imgName;
  final String photo;
  BackItems({required this.imgName, required this.photo});

  
}

