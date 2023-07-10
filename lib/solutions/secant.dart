import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_project/solutions/utils.dart';

class Secant extends CustomUtils {
  final String function;
  final double inputXA;
  final double inputXB;
  final double tolerance;
  final int decimalPlaces;

  List<List<String>> solutionsTable = [];

  Secant({
    required this.function,
    required this.inputXA,
    required this.inputXB,
    required this.tolerance,
    required this.decimalPlaces,
  });

  List<List<String>> solve() {
    solutionsTable.add(["i", "xA", "xB", "xN", "f(xA)", "f(xB)", "f(xN)"]);

    var xA = inputXA;
    var xB = inputXB;
    var xN = 0.0;
    var i = 1;

    while (true) {
      var ya = roundNumber(_evaluate(xA), decimalPlaces);
      var yb = roundNumber(_evaluate(xB), decimalPlaces);

      xN = roundNumber((xA - ((ya * (xA - xB)) / (ya - yb))), decimalPlaces);
      var yn = roundNumber(_evaluate(xN), decimalPlaces);

      solutionsTable.add([
        "$i",
        "$xA",
        "$xB",
        "$xN",
        "$ya",
        "$yb",
        "$yn",
      ]);

      xA = xB;
      xB = xN;

      if (yn.abs() <= tolerance || i > 100) {
        break;
      }

      i++;
    }
    return solutionsTable;
  }

  double _evaluate(double number) {
    Parser p = Parser();
    Expression exp = p.parse(function);

    Variable varX = Variable('x');
    Number x = Number(number);
    Variable e = Variable('e');
    ContextModel cm = ContextModel()
      ..bindVariable(varX, x)
      ..bindVariable(e, Number(2.718281828459045));
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
