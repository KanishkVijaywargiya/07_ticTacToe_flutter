import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //linking the images
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

  bool isCross = true;
  String message;
  List<String> gameState;

  //initialize the state of box with empty array with all empty values
  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }
  
  //playGame method
  playGame(int index){
    if (this.gameState[index] == "empty"){
      setState(() {
        if(this.isCross){
          this.gameState[index] = "cross";
        } else{
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross; // ! here makes true to false nd vice-versa
        this.checkWin();
      });
    }
  }

  //Reset Game method
  resetGame(){
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  //get Image Method
  AssetImage getImage(String value){
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
      default:
    }
  }

  //check for win logic
  checkWin(){
    //check for row wins
    if((gameState[0] != 'empty') && (gameState[0] == gameState[1]) && (gameState[1] == gameState[2])){
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if((gameState[3] != 'empty') && (gameState[3] == gameState[4]) && (gameState[4] == gameState[5])){
      setState(() {
        this.message = '${this.gameState[3]} Wins';
      });
    } else if((gameState[6] != 'empty') && (gameState[6] == gameState[7]) && (gameState[7] == gameState[8])){
      setState(() {
        this.message = '${this.gameState[6]} Wins';
      });
    }
    //check for column wins 
    else if((gameState[0] != 'empty') && (gameState[0] == gameState[3]) && (gameState[3] == gameState[6])){
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if((gameState[1] != 'empty') && (gameState[1] == gameState[4]) && (gameState[4] == gameState[7])){
      setState(() {
        this.message = '${this.gameState[1]} Wins';
      });
    } else if((gameState[2] != 'empty') && (gameState[2] == gameState[5]) && (gameState[5] == gameState[8])){
      setState(() {
        this.message = '${this.gameState[2]} Wins';
      });
    }
    //check for diagonal wins 
    else if((gameState[0] != 'empty') && (gameState[0] == gameState[4]) && (gameState[4] == gameState[8])){
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if((gameState[2] != 'empty') && (gameState[2] == gameState[4]) && (gameState[4] == gameState[6])){
      setState(() {
        this.message = '${this.gameState[2]} Wins';
      });
    }
    //check for draw of match 
    else if(!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
        backgroundColor: Color(0xFF45CE30),
      ),
      backgroundColor: Color(0xFFEAF0F1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: MaterialButton(
                      onPressed: (){
                        this.playGame(i); 
                      },
                      child: Image(
                        image: this.getImage(this.gameState[i]),
                      ),
                    ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message, 
              style: TextStyle(
                fontSize: 20.0, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            color: Color(0xFF45CE30),
            minWidth: 300.0,
            height: 50.0,
            child: Text(
              "Reset Game", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: (){
              this.resetGame();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            splashColor: Color(0xFF019031)
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Kanishk Vijaywargiya",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway', fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 90.0,
            child: Linkify(
                onOpen: (link) => print("Clicked ${link.url}!"),
                text: "www.androwebios.epizy.com",
                style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
            ),
            // child: Text(
            //   '${www.androwebios.epizy.com.url}',
            //   style: TextStyle(fontSize: 18.0, fontFamily: 'Raleway', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
            // ),
          )
        ],
      ),
    );
  }
}