import 'package:flutter/material.dart';
import 'package:quizzler/Questionlib.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

    List <Widget> scoreicon = [];
    Questionlib q_lib = Questionlib();
    int score=0;

    void chekanswer(bool answer){
      bool correctAnswer = q_lib.getanswer();
      if(!q_lib.isfinish()){   
        if(correctAnswer == answer){
          score++;
          scoreicon.add(
          Icon(
            Icons.check,
            color: Colors.green,
              )
          );
          } 
          else{
            scoreicon.add(
              Icon(
                Icons.close,
                color: Colors.red,
              )
            );
          }
      }
      else{
        Alert(
      context: context,
      type: AlertType.success,
      title: "Your Score Is: $score ",
      desc: "Reset the quiz",
      buttons: [
        DialogButton(
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () { 
            setState(() {
            
            scoreicon=[];
            score=0;
            });
            q_lib.reset();
            Navigator.pop(context);
          
            },
          width: 120,
        )
      ],
    ).show();
      }

    }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                q_lib.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  chekanswer(true);
                  q_lib.nextquestion();
                  
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  chekanswer(false);

                  q_lib.nextquestion();
                });

                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreicon,
        )
      ],
    );
  }
}


