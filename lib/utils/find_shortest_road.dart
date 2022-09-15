
import 'package:homework/utils/point.dart';

import '../models/incoming_data_model.dart';


class PathFinder {
  List<List<String>> grid;
  int gridWidth = 0;
  int gridHeight = 0;

  late List<Point> solution;
  late bool solutionExists;


  PathFinder(this.grid, characterPosition, characterDestination) {
    List<int> frontier = <int>[];
    List<int> cameFrom = List.generate(
      grid[0].length * grid.length,
          (int index) => -1,
      growable: false,
    );

    gridWidth = grid[0].length;
    gridHeight = grid.length;

    frontier.add(_convert2dto1d(characterPosition));

    while (frontier.isNotEmpty) {
      int current = frontier.first;
      frontier.removeAt(0);
      List<Point> neighbors = _neighbors(_convert1dto2d(current));

      for (Point node in neighbors) {
        int node1d = _convert2dto1d(node);
        if (cameFrom[node1d] == -1) {
          frontier.add(node1d);
          cameFrom[node1d] = current;
        }
      }
    }

    solutionExists = true;

    solution = <Point>[];
    Point endNode = characterDestination;
    print('end point coord y=${endNode.y} x= ${endNode.x}');
    solution.add(endNode);
    while (
    endNode.x != characterPosition.x || endNode.y != characterPosition.y) {
      int endNode1d = _convert2dto1d(endNode);

      if (cameFrom[endNode1d] == -1) {
        solutionExists = false;
        break;
      }

      endNode = _convert1dto2d(cameFrom[endNode1d]);
      solution.insert(0,endNode);
    }

    return;
  }


  int _convert2dto1d(Point node) {
    return node.y * gridWidth + node.x;
  }


  Point _convert1dto2d(int node1d) {
    if (gridWidth == 0) {
      return Point(y: -1, x: -1);
    }

    int y = node1d ~/ gridWidth;
    int x = node1d - y * gridWidth;

    return Point(y: y, x: x);
  }

  // ---------------------------------------------------------------------------
  List<Point> _neighbors(Point node) {
    List<Point> neighbors = <Point>[];
    for (int dy = -1; dy <= 1; dy += 2) {
      Point neighborNode = Point(y: node.y + dy, x: node.x + dy);
      if (_isValidNode(neighborNode)) {
        neighbors.add(neighborNode);
      }
    }
    for (int dy = -1; dy <= 1; dy += 2) {
      Point neighborNode = Point(y: node.y + dy, x: node.x - dy);
      if (_isValidNode(neighborNode)) {
        neighbors.add(neighborNode);
      }
    }
    for (int dx = -1; dx <= 1; dx += 2) {
      Point neighborNode = Point(y: node.y, x: node.x + dx);
      if (_isValidNode(neighborNode)) {
        neighbors.add(neighborNode);
      }
    }
    for (int dy = -1; dy <= 1; dy += 2) {
      Point neighborNode = Point(y: node.y + dy, x: node.x);
      if (_isValidNode(neighborNode)) {
        neighbors.add(neighborNode);
      }
    }


    return neighbors;
  }

  bool _isValidNode(Point node) {
    if (node.x >= 0 &&
        node.y >= 0 &&
        node.x < gridWidth &&
        node.y < gridHeight &&
        grid[node.y][node.x] != 'X') {
      return true;
    }
    return false;
  }
}

// ---------------------------------------------------------------------------
List<List<Point>?> findShortestRoad(List<Task> data) {
  List<List<Point>?> result =[];
for(var item in data) {
  List<Point> pointsForTask = <Point>[];
  var list1 = List.generate(item.field.length,(i) => List.generate(item.field.length, (j) =>item.field[i].substring(j,j+1)));

  var startPosition = Point(y: item.start.y, x: item.start.x);
  var finishPosition = Point(y: item.end.y, x: item.end.x);
  PathFinder pathFinder =
  PathFinder(list1, startPosition, finishPosition);
  if (pathFinder.solutionExists) {
    for (Point point in pathFinder.solution) {
     pointsForTask.add(point);
    }
    result.add(pointsForTask);
  } else {
   //TODO 'No solution exists.'
    result.add(null);
  }

}
  return result;

}
