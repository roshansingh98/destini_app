import 'package:destini_app/story.dart';
import 'package:flutter/material.dart';
import 'story_brain.dart';

//TODO: Step 15 - Run the app and see if you can see the screen update with the first story. Delete this TODO if it looks as you expected.
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

//TODO: Step 9 - Create a new storyBrain object from the StoryBrain class.

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

//TODO: Step 24 - Run the app and try to figure out what code you need to add to this file to make the story change when you press on the choice buttons.

//TODO: Step 29 - Run the app and test it against the Story Outline to make sure you've completed all the steps. The code for the completed app can be found here: https://github.com/londonappbrewery/destini-challenge-completed/
