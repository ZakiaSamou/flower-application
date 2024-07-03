import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(FlowerApp());
}

class FlowerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Interactive Flower')),
        body: Flower(),
      ),
    );
  }
}

class Flower extends StatefulWidget {
  @override
  _FlowerState createState() => _FlowerState();
}

class _FlowerState extends State<Flower> {
  List<Color> petals = [];

  String love = "Love";
  String noLove = "Dosn't Love";
  String state = "test";
  int stateNumber = 0;
  bool restart = false;
  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  void initState() {
    for (int i = 0; i < 12; i++) petals.add(getRandomColor());
    super.initState();
  }

  double j = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text(
          "Love Check",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
      Text(
        "Tap on patel to remove it.",
        style: TextStyle(
            color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Expanded(
        child: Container(
          child: Stack(
            children: List.generate(petals.length, (index) {
              final angle = 2 * pi * index / petals.length;
              final radius = 50; // Adjust the radius as needed
              final x = radius * cos(angle);
              final y = radius * sin(angle);
              return Positioned(
                left: x + (MediaQuery.of(context).size.width - 50) / 2,
                top: y + MediaQuery.of(context).size.height / 6,
                child: Transform.rotate(
                  angle: pi / 6 * index + 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        petals.remove(petals[index]);
                        stateNumber = index;
                        (stateNumber.isEven) ? state = love : state = noLove;
                        (petals.length == 0) ? restart = true : false;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(60),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(60),
                            bottomStart: Radius.circular(10)),
                        shape: BoxShape.rectangle,
                        color: petals[index],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      Expanded(
        child: Column(children: [
          Text(
            "$state",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Visibility(
            visible: restart,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  petals = [];
                  for (int i = 0; i < 12; i++) petals.add(getRandomColor());
                  restart = false;
                });
              },
              child: Text("Restart"),
            ),
          )
        ]),
      ),
    ]);
  }
}
