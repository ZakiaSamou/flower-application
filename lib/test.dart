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
    return Center(
      child: Stack(
        children: List.generate(petals.length, (index) {
          final angle = 2 * pi * index / petals.length;
          final radius = 100; // Adjust the radius as needed
          final x = radius * cos(angle);
          final y = radius * sin(angle);
          return Positioned(
            left: x + MediaQuery.of(context).size.width / 2,
            top: y + MediaQuery.of(context).size.height / 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  petals.remove(petals[index]);
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
          );
        }),
      ),
    );
  }
}
