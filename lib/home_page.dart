import 'package:flutter/material.dart';
import 'package:quizz_app/quizz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    final height = Size.height;
    final width = Size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz Flutter'),
      ),
      body: Center(
        child: Card(
          color: Colors.deepPurple.shade100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/cover.jpg',
                  height: height / 2,
                  width: width * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext ctx) {
                    return QuizzPage();
                  }));
                },
                child: Text("Commencez le Quizz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
