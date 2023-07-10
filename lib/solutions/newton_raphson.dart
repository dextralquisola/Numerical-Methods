import 'package:math_expressions/math_expressions.dart';

import './utils.dart';

class NewtonRaphson extends CustomUtils {
  final String function;
  final double xo;
  final double tolerance;
  final int decimalPlaces;

  List<List<String>> solutionTable = [];

  NewtonRaphson({
    required this.function,
    required this.xo,
    required this.tolerance,
    required this.decimalPlaces,
  });

  List<List<String>> solve() {
    solutionTable.add(["i", "xO", "xN", "f(xO)", "f(xN)"]);

    var xOld = xo;
    var i = 1;

    while (true) {
      var yOld = roundNumber(_evaluate(xOld), decimalPlaces);
      var x_new = roundNumber(
        xOld - ( yOld / roundNumber(_evaluateDerivative(xOld), decimalPlaces)),
        decimalPlaces,
      );


      var y_new = roundNumber(_evaluate(x_new), decimalPlaces);

      solutionTable.add(["$i", "$xOld", "$x_new", "$yOld", "$y_new"]);

      xOld = x_new;
      if (y_new.abs() <= tolerance || i > 100) {
        break;
      }

      i++;
    }

    return solutionTable;
  }

  double _evaluateDerivative(double number) {
    var h = 0.0001;
    return (_evaluate(number + h) - _evaluate(number - h)) / (2 * h);
  }

  double _evaluate(double number) {
    Parser p = Parser();
    Expression exp = p.parse(function);

    Variable varX = Variable('x');
    Number x = Number(number);
    ContextModel cm = ContextModel()..bindVariable(varX, x);
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
