import 'dart:math' as math;
import 'package:flutter_application2/MyThings/demopage_things.dart';
import 'package:flutter_application2/MyThings/score.dart';
import 'package:flutter_application2/MyThings/userchoice.dart';
import 'package:flutter_application2/model/level.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// Tile
/// 
class Tile extends Object {
  TileType type;
  int row;
  int col;
  Level level;
  int depth;
  Widget _widget;
  double x;
  double y;
  bool visible;

  Tile({
    this.type,
    this.row: 0,
    this.col: 0,
    this.level,
    this.depth: 0,
    this.visible: true,
  });
  
  @override
  int get hashCode => row * level.numberOfRows + col;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || other.hashCode == this.hashCode;
  }

  @override
  String toString(){
    return '[$row][$col] => ${describeEnum(type)}';
  }

  //
  // Builds the tile in terms of "decoration" ( = image )
  //
  void build({bool computePosition = true}){
    if (depth > 0 && type != TileType.wall){
      _widget = Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.7, 
            child: Transform.scale(
              scale: 0.8,
              child: _buildDecoration(),
            ),
          ),
          _buildDecoration('deco/ice_02.png'),
        ],
      );
    } else if (type == TileType.empty) {
      _widget = Container();
    } else {
      _widget = _buildDecoration(); 
    }

    if (computePosition){
      setPosition();
    }
  }

  Widget _buildDecoration([String path = ""]){
    String imageAsset = path;
    if (imageAsset == ""){
      switch(type){
        case TileType.green:
          imageAsset = "mytiles/${describeEnum(type)}.png";
          break;
        case TileType.wall:
          imageAsset = "mytiles/${describeEnum(TileType.blue)}.png";
          break;

        case TileType.bomb:
                    imageAsset = "mytiles/${describeEnum(TileType.blue)}.png";
                    break;

        case TileType.flare:

          imageAsset = "mytiles/${describeEnum(TileType.green)}.png";
          break;
        case TileType.wrapped:
          imageAsset = "mytiles/${describeEnum(TileType.green)}.png";
          break;
        //
        case TileType.fireball:
          imageAsset = "mytiles/${describeEnum(TileType.green)}.png";
          break;

        default:
          try {
            imageAsset = "mytiles/${describeEnum(type)}.png";
          } catch(e){
            return Container();
          }
          break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$imageAsset'),
          fit: BoxFit.contain,
        )
      ),
    );
  }

  //
  // Returns the position of this tile in the checkerboard
  // based on its position in the grid (row, col) and
  // the dimensions of the board and a tile
  //
  void setPosition(){
    double bottom = level.boardTop + (level.numberOfRows - 1) * level.tileHeight;
    x = level.boardLeft + col * level.tileWidth;
    y = bottom - row * level.tileHeight;
  }

  //
  // Generate a tile to be used during the swap animations
  //
  Tile cloneForAnimation(){
    Tile tile = Tile(level: level, type: type, row: row, col: col);
    tile.build();

    return tile;
  }

  //
  // Swaps this tile (row, col) with the ones of another Tile
  //
  void swapRowColWith(Tile destTile){
    int tft = destTile.row;
    destTile.row = row;
    row = tft;

    tft = destTile.col;
    destTile.col = col;
    col = tft;
  }

  //
  // Returns the Widget to be used to render the Tile
  //
  Widget get widget => getWidgetSized(level.tileWidth, level.tileHeight);

  Widget getWidgetSized(double width, double height) => Container(
    width: width,
    height: height,
    child: _widget,
  );

  //
  // Can the Tile move?
  //
  bool get canMove => (depth == 0) && (canBePlayed(type));

  //
  // Can a Tile fall?
  //
  bool get canFall => type != TileType.wall && type != TileType.forbidden && type != TileType.empty;

  // ################  HELPERS  ######################
  //
  // Generate a random tile
  //
  static TileType random(math.Random rnd){
    int minValue = _firstNormalTile;
    int maxValue = _lastNormalTile;
    int value;

    if(UserChoice.remaining > 0){
      print("Remaining is=========================${UserChoice.remaining}");
      value = _userChoiseTile;
    }
    else if(DemoPageThings.demo){
        value = DemoPageThings.tiles[DemoPageThings.index].index;
        DemoPageThings.index+=1;
        if(DemoPageThings.tiles.length == DemoPageThings.index ) DemoPageThings.index=0;
        print("    ${TileType.values[value]}");
        print("============================================>${++DemoPageThings.itteration}");
    }
    else
      value = rnd.nextInt(maxValue - minValue) + minValue;

    if(UserChoice.remaining>0){
      print("Outer=============================${TileType.values[value]}");
      UserChoice.remaining-=1;
    }

    return TileType.values[value];
  }
  
  static int  get _firstNormalTile => TileType.red.index;
  static int  get _lastNormalTile => TileType.yellow.index;
  static int  get _firstBombTile => TileType.bomb.index;
  static int  get _lastBombTile => TileType.fireball.index;
  static int get _userChoiseTile =>TileType.green.index;

  static bool isNormal(TileType type){
    int index = type.index;
    return (index >= _firstNormalTile && index <= _lastNormalTile);
  }

  static bool isBomb(TileType type){
    int index = type.index;
    return (index >= _firstBombTile && index <= _lastBombTile);
  }
  static bool canBePlayed(TileType type) => (type != TileType.wall && type != TileType.forbidden);
}

//
// Types of tiles
//
enum TileType {
  forbidden,
  empty,
  red,
  green,
  blue,
  orange,
  purple,
  yellow,
  wall,
  bomb,
  flare,
  wrapped,
  fireball,
  last,
}