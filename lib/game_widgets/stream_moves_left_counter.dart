import 'package:flutter_application2/MyThings/score.dart';
import 'package:flutter_application2/bloc/bloc_provider.dart';
import 'package:flutter_application2/bloc/game_bloc.dart';
import 'package:flutter/material.dart';

///
/// StreamMovesLeftCounter
/// 
/// Displays the number of moves left for the game.
/// Listens to the "movesLeftCount" stream.
///
class StreamMovesLeftCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.swap_horiz, color: Colors.black,),
        SizedBox(width: 8.0),
        StreamBuilder<int>(
          initialData: gameBloc.gameController.level.maxMoves,
          stream: gameBloc.movesLeftCount,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if(gameBloc.gameController.level.maxMoves== gameBloc.movesLeftCount){
              Score.myscore = 0;
            }
            return Text('${snapshot.data}', style: TextStyle(color: Colors.black, fontSize: 16.0,),);
          }
        ),
      ],
    );
  }
}