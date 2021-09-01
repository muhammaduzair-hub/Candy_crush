import 'dart:collection';
import 'package:flutter_application2/MyThings/score.dart';
import 'package:flutter_application2/MyThings/userchoice.dart';
import 'package:flutter_application2/model/chain.dart';
import 'package:flutter_application2/model/tile.dart';

///
/// Combo
///
///
class Combo {
  // List of all the tiles, part of the combo
  HashMap<int, Tile> _tiles = HashMap<int, Tile>();
  List<Tile> get tiles => UnmodifiableListView(_tiles.values.toList());

  // Type of combo
  ComboType _type = ComboType.none;
  ComboType get type => _type;

  // Type of tile that results from the combo
  TileType resultingTileType;

  // Which tile is responsible for the combo
  Tile commonTile;

  // Constructor
  Combo(Chain horizontalChain, Chain verticalChain, int row, int col){
    horizontalChain?.tiles?.forEach((Tile tile){
      _tiles.putIfAbsent(tile.hashCode, () => tile);
    });
    verticalChain?.tiles?.forEach((Tile tile){
      if (commonTile == null && _tiles.keys.contains(tile.hashCode)){
        commonTile = tile;
      }
      _tiles.putIfAbsent(tile.hashCode, () => tile);
    });

    int total = _tiles.length;
    _type = ComboType.values[total];

    // If the combo contains more than 3 tiles but is not the combination of both horizontal and vertical chains
    // we need to determine the tile which created the chain
    if (total > 3 && commonTile == null){
      _tiles.values.forEach((Tile tile){
        if (tile.row == row && tile.col == col){
          commonTile = tile;
        }
      });
    }

    // Determine the type of the resulting tile (case of more than 3 tiles)
    switch(total){
      case 3:
        if(Score.enablescore)
        {
          print(UserChoice.for3);
          UserChoice.current = UserChoice.for3;
          UserChoice.remaining = UserChoice.current;

          Score.myscore+=30;
          Score.enablescore = false;
        }

        break;
      case 4:
        if(Score.enablescore)
        {
          UserChoice.current = UserChoice.for4;
          UserChoice.remaining = UserChoice.current;
          Score.myscore+=40;
          Score.enablescore = false;
        }
        //resultingTileType = TileType.flare;
        resultingTileType = TileType.green;
        break;

      case 6:
        if(Score.enablescore)
        {
          UserChoice.current = UserChoice.for6;
          UserChoice.remaining = UserChoice.current;
          Score.myscore+=60;
          Score.enablescore = false;
        }
        //resultingTileType = TileType.bomb;
        resultingTileType = TileType.green;
        break;

      case 5:
        if(Score.enablescore)
        {
          UserChoice.current = UserChoice.for5;
          UserChoice.remaining = UserChoice.current;
          Score.myscore+=50;
          Score.enablescore = false;
        }
        //resultingTileType = TileType.wrapped;
        resultingTileType = TileType.green;
        break;

      case 7:

        if(Score.enablescore)
        {
          UserChoice.current = UserChoice.for6;
          UserChoice.remaining = UserChoice.current;
          Score.myscore+=70;
          Score.enablescore = false;
        }
        //resultingTileType = TileType.fireball;
        resultingTileType = TileType.green;
        break;

    }
  }
}

//
// All combo types
//
enum ComboType {
  none,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
}