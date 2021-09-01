import 'package:flutter_application2/MyThings/score.dart';
import 'package:flutter_application2/MyThings/userchoice.dart';
import 'package:flutter_application2/bloc/bloc_provider.dart';
import 'package:flutter_application2/bloc/game_bloc.dart';
import 'package:flutter_application2/game_widgets/stream_moves_left_counter.dart';
import 'package:flutter_application2/model/level.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  var currentSelectedValue;
  var deviceTypes = ['10','20','30', '40','50','60','70', '80','90', '100'];

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    final Level level = gameBloc.gameController.level;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final EdgeInsets paddingTop = EdgeInsets.only(top: (orientation == Orientation.portrait ? 10.0 : 0.0));

    return Padding(
      padding: paddingTop,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300].withOpacity(0.7),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 5.0, color: Colors.black.withOpacity(0.5)),
        ),
        width: 200.0,
        height: 40.0,
        child: DropdownButton<String>(
          hint: Text("Select Device"),
          value: currentSelectedValue,
          isDense: true,
          onChanged: (newValue) {
            setState(() {
              currentSelectedValue = newValue;
              var v = int.parse(newValue);
              UserChoice.choice = int.parse(currentSelectedValue);
              UserChoice.for3 = ((v/100)*3).toInt() < 0? 1: ((v/100)*3).toInt();
              UserChoice.for4 = ((v/100)*4).toInt() < 0? 1: ((v/100)*4).toInt();
              UserChoice.for5 = ((v/100)*5).toInt() < 0? 1: ((v/100)*5).toInt();
              UserChoice.for6 = ((v/100)*6).toInt() < 0? 1: ((v/100)*6).toInt();
            });
            print('$currentSelectedValue\n${UserChoice.for3}\n${UserChoice.for4}\n${UserChoice.for5}\n${UserChoice.for6}');
          },
          items: deviceTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

      ),
    );
  }
}