
class Circle{

  int column;
  int row = 0;
  int length;
  int el;
  bool crush;
  List<Coordinates> coordinates = [];

  Circle (this.length) {
    switch (length) {
      case 1: {
        column = row = 1;
        coordinates.add(Coordinates(0, 0));
      } break;
      
      case 2: {
        column = row = 3;
        coordinates.addAll([Coordinates(0, 1), Coordinates(2, 1)]);
      } break;
      
      case 3: {
        column = 3;
        row = 2;
        coordinates.addAll([Coordinates(0, 1), Coordinates(1, 2), Coordinates(1, 0)]);
      } break;
      
      default:
        build();
    }
  }

  void build() {
    int c = (length / 2).ceil();
    column = c % 2 == 1 ? c : c + 1;
    el = length;
    
    if(el % 2 == 1)
      el += 1;
    
    crush = (el / 2) % 2 == 1;
    int a = (column / 2).ceil() - 1;
    int b = a;
    List<Coordinates> tail = [];
    bool on = true;
    Coordinates sx, dx;
    
    while ((coordinates.length + tail.length) != length) {
      dx = Coordinates(row, b);
      sx = Coordinates(row, a);
      coordinates.add(dx);
      if (a != b) 
        tail.add(sx);
      if (a == 0) {
        if (crush) {
          row += 2;
          tail.add(Coordinates(row, a));
          coordinates.add(Coordinates(row, b));
        }
        on = false;
      }
      
      if (on) {
        a -= 1;
        b += 1;
      } else {
        a += 1;
        b -= 1;
      }
      row += 2;
    }
    
    coordinates.addAll(tail.reversed);
  }

  List<Coordinates> getCoordinates()=> coordinates;

  String toString(){
    String str = "";
    coordinates.forEach((c) => str += c.toString());
    return str;
  }

  int getRows() => row;
  int getColumns() => column;
}


class Coordinates{

  int _r;
  int _c;

  Coordinates(this._r, this._c);

  int getRow() => _r;
  int getColumn() => _c;
}


class ReportGraph{

  String _text;
  List<ReportGraphNode> _nodes;
  Circle _circle;
  int _score;

  ReportGraph(this._text) {
    _nodes = [];
    createNodeList(deleteCharacters(_text.toLowerCase()).split(" "));
    _score = _nodes.length;
    addCoordinates();
  }

  String deleteCharacters(String str){
    bool repl1, repl2;
    int c1, c2;
    Function isNumber = (int x) => x >= 48 && x <= 57;
    Function isLetter = (int x) => x >= 97 && x <= 122;
    Function isAccentedLetter = (int x) => [233, 232, 242, 224, 249].contains(x);
    Function isSymbol = (int x) => x == 32 || x == 39;
    Function toReplace = (int x) => !(isNumber(x) || isLetter(x) || isAccentedLetter(x) || isSymbol(x));

    for (int i = 0; i < str.length - 1; i++) {
      c1 = str.codeUnitAt(i);
      c2 = str.codeUnitAt(i + 1);
      repl1 = toReplace(c1);
      repl2 = toReplace(c2);
      if (repl1)
        str = str.replaceAll(String.fromCharCode(c1), " ");
      
      if (repl2)
        str = str.replaceAll(String.fromCharCode(c2), " ");
      
      if (repl1 && repl2)
        str = str.replaceFirst("  ", " ");
      
      if (str.startsWith(" "))
        str = str.substring(1);
      
      if (repl1 || repl2)
        i -= 1;
    }
    
    while (str.endsWith(" ")) {
      str = str.substring(0, str.length - 1);
    }
    
    return str;
  }

  
  void createNodeList(List<String> words) {
    String from, to;
    ReportGraphNode node;
    for (int i = 0; i < words.length - 1; i++) {
      from = words[i];
      to = words[i + 1];
      
      if (from != to) {
        if (!contains(from)) {
          node = ReportGraphNode(from);
          node.addAdj(to);
          _nodes.add(node);
        } else {
          addAdj(from, to);
        }
      }
    }
    if(!contains(to))
      _nodes.add(ReportGraphNode(to));
  }


  void addCoordinates(){
    _circle = Circle(_nodes.length);
    List<Coordinates> coordinate = _circle.getCoordinates();
    for(int i = 0; i < _nodes.length; i++) {
      _nodes[i].setCoordinate(coordinate[i]);
    }
  }


  void addAdj(String from, String to) {
    _nodes.firstWhere((n) => n.getText() == from ).addAdj(to);
  }

  bool contains(String str) {
    return _nodes.firstWhere((n) => n.getText() == str, orElse: ()=> null) != null;
  }

  String getText() => _text;
  List<ReportGraphNode> getNodes() => _nodes;
  Circle getCircle() => _circle;
  int getScore() => _score;
}


class ReportGraphNode{

  Set<String> _adj;
  Coordinates _coordinate;
  String _text;

  ReportGraphNode(this._text) {
    _adj = Set<String>();
  }

  List<String> getAdj()=> _adj.toList();
  Coordinates getCoordinate()=>_coordinate;
  String getText()=> _text;

  void addAdj(String str) => _adj.add(str);

  void setCoordinate(Coordinates coordinate) => _coordinate = coordinate;
}
