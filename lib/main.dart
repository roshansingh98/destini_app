import 'package:destini_app/story.dart';
import 'package:flutter/material.dart';
import 'story_brain.dart';

StoryBrain story = StoryBrain();

void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}


class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  bool choiceButton = true, restartButton = true;

  getChoice(int choiceNum) {
    var val = story.storyLogic(choiceNum);
    if (val == true) {
      story.restart();
    } else {
      setState(() {
        story.getStory();
        story.getChoiceOne();
        story.getChoiceTwo();
      });
    }
    setState(() {
      if (story.buttonVisibility()) {
        choiceButton = true;
        restartButton = true;
      } else {
        choiceButton = false;
        restartButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 16, 82, 1),
      appBar: AppBar(
        title: Center(
          child: Text('Destini App'),
        ),
        backgroundColor: Color.fromRGBO(166, 23, 23, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    story.getStory(), //Question text widget
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: restartButton,
                  child: FlatButton(
                    onPressed: () {
                      getChoice(1);
                      //Choice 1 made by user.
                    },
                    color: Colors.red,
                    child: Text(
                      story.getChoiceOne(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: choiceButton,
                  child: FlatButton(
                    onPressed: () {
                      getChoice(2);
                      //Choice 2 made by user.
                    },
                    color: Colors.blue,
                    child: Text(
                      story.getChoiceTwo(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
