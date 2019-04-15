import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:coffeebreak/dto/game/maze_game_dto.dart';
import 'package:coffeebreak/game/components/enemy.dart';
import 'package:coffeebreak/game/components/player.dart';
import 'package:coffeebreak/game/components/types.dart';
import 'package:coffeebreak/game/grid.dart';
import 'package:coffeebreak/game/simple_contact_listener.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:vector_math/vector_math_64.dart';

class MazeWorld extends Box2DComponent {
  MazeGameDto gameDto;
  Player player;
  Enemy enemy;
  Grid grid;

  bool resetWorld = false;

  MazeWorld({this.gameDto}) : super(scale: 1.0) {
    grid = new Grid(width: viewport.width, height: viewport.height, box2dComponent: this);
    buildGame();
  }

  void initializeWorld() {
    world.setGravity(new Vector2(0, 0));
    world.setContactListener(new SimpleContactListener(
      collision: handleCollision
    ));
  }

  void stopPlayer() {
    player.body.linearVelocity = new Vector2(0, 0);
  }

  void movePlayer(Vector2 force) {
    force.multiply(new Vector2(100, 100));
    player.body.linearVelocity = force;
  }

  void handleCollision(Contact contact) {
    if ((contact.fixtureA.getBody().userData == ComponentType.PLAYER && contact.fixtureB.getBody().userData == ComponentType.ENEMY) || 
        (contact.fixtureA.getBody().userData == ComponentType.ENEMY && contact.fixtureB.getBody().userData == ComponentType.PLAYER)) {
        print("Collision Player -> Enemy");
        player.paint.color = Color.fromARGB(255, 255, 255, 255);
        resetWorld = true;
    }
  }

  @override
  void update(t) {
    super.update(t);
    
    if (resetWorld) {
      for (int i = 0; i < components.length; i++) {
        world.destroyBody(components.elementAt(i).body);
      }
      
      while(components.isNotEmpty) {
        print("Removing Object");
        components.removeLast();
      }

      buildGame();
      resetWorld = false;
    }
  }

  void buildGame() {
    // TODO Eventually parse via JSON
    // Player
    player = grid.createPlayerAt(0, 0);
    add(player);

    // Enemy
    add(grid.createEnemyAt(2, -4));
    add(grid.createEnemyAt(10, -4));
    add(grid.createEnemyAt(-13, 18));
    add(grid.createEnemyAt(-20, -1));
    add(grid.createEnemyAt(4, 20));
    add(grid.createEnemyAt(-22, -25));
    add(grid.createEnemyAt(-21, -25));
    add(grid.createEnemyAt(-20, -25));
    add(grid.createEnemyAt(-19, -25));
    add(grid.createEnemyAt(-18, -25));
    add(grid.createEnemyAt(-17, -25));
    add(grid.createEnemyAt(-16, -25));
    add(grid.createEnemyAt(-15, -25));
    add(grid.createEnemyAt(-14, -25));
    add(grid.createEnemyAt(-13, -25));
    add(grid.createEnemyAt(-12, -25));
    add(grid.createEnemyAt(-11, -25));
    add(grid.createEnemyAt(-10, -25));
    add(grid.createEnemyAt(-9, -25));
    add(grid.createEnemyAt(-8, -25));
    add(grid.createEnemyAt(-7, -25));
    add(grid.createEnemyAt(-6, -25));
    add(grid.createEnemyAt(-5, -25));
    add(grid.createEnemyAt(-4, -25));
    add(grid.createEnemyAt(-3, -25));
    add(grid.createEnemyAt(-2, -25));
    add(grid.createEnemyAt(-1, -25));
    add(grid.createEnemyAt(0, -25));
    add(grid.createEnemyAt(1, -25));
    add(grid.createEnemyAt(2, -25));
    add(grid.createEnemyAt(3, -25));
    add(grid.createEnemyAt(4, -25));
    add(grid.createEnemyAt(5, -25));
    add(grid.createEnemyAt(6, -25));
    add(grid.createEnemyAt(7, -25));
    add(grid.createEnemyAt(8, -25));
    add(grid.createEnemyAt(9, -25));
    add(grid.createEnemyAt(10, -25));
    add(grid.createEnemyAt(11, -25));
    add(grid.createEnemyAt(12, -25));
    add(grid.createEnemyAt(13, -25));
    add(grid.createEnemyAt(14, -25));
    add(grid.createEnemyAt(15, -25));
    add(grid.createEnemyAt(16, -25));
    add(grid.createEnemyAt(17, -25));
    add(grid.createEnemyAt(18, -25));
    add(grid.createEnemyAt(19, -25));
    add(grid.createEnemyAt(20, -25));
    add(grid.createEnemyAt(21, -25));
    add(grid.createEnemyAt(22, -25));
    add(grid.createEnemyAt(23, -25));
    add(grid.createEnemyAt(24, -25));
    add(grid.createEnemyAt(25, -25));

    // Goal
    add(grid.createGoalAt(-25, -25));
    add(grid.createGoalAt(-24, -25));
    add(grid.createGoalAt(-23, -25));
    add(grid.createGoalAt(-25, -25));
    add(grid.createGoalAt(-25, -24));
    add(grid.createGoalAt(-25, -23));

    // Barriers
    // Left
    add(grid.createBarrierAt(25, 5));
    add(grid.createBarrierAt(25, 4));
    add(grid.createBarrierAt(25, 3));
    add(grid.createBarrierAt(25, 2));
    add(grid.createBarrierAt(25, 1));
    add(grid.createBarrierAt(25, 0));
    add(grid.createBarrierAt(25, -1));
    add(grid.createBarrierAt(25, -2));
    add(grid.createBarrierAt(25, -3));
    add(grid.createBarrierAt(25, -4));
    add(grid.createBarrierAt(25, -5));
    
    // Right
    add(grid.createBarrierAt(-25, 5));
    add(grid.createBarrierAt(-25, 4));
    add(grid.createBarrierAt(-25, 3));
    add(grid.createBarrierAt(-25, 2));
    add(grid.createBarrierAt(-25, 1));
    add(grid.createBarrierAt(-25, 0));
    add(grid.createBarrierAt(-25, -1));
    add(grid.createBarrierAt(-25, -2));
    add(grid.createBarrierAt(-25, -3));
    add(grid.createBarrierAt(-25, -4));
    add(grid.createBarrierAt(-25, -5));

    // Top
    add(grid.createBarrierAt(5, 5));
    add(grid.createBarrierAt(4, 5));
    add(grid.createBarrierAt(3, 5));
    add(grid.createBarrierAt(2, 5));
    add(grid.createBarrierAt(1, 5));
    add(grid.createBarrierAt(0, 5));
    add(grid.createBarrierAt(-1, 5));
    add(grid.createBarrierAt(-2, 5));
    add(grid.createBarrierAt(-3, 5));
    add(grid.createBarrierAt(-4, 5));
    add(grid.createBarrierAt(-5, 5));

    // Bottom
    add(grid.createBarrierAt(5, -5));
    add(grid.createBarrierAt(4, -5));
    add(grid.createBarrierAt(3, -5));
    add(grid.createBarrierAt(2, -5));
    add(grid.createBarrierAt(1, -5));
    add(grid.createBarrierAt(0, -5));
    add(grid.createBarrierAt(-1, -5));
    add(grid.createBarrierAt(-2, -5));
    add(grid.createBarrierAt(-3, -5));
    add(grid.createBarrierAt(-4, -5));
    add(grid.createBarrierAt(-5, -5));
  }
}
