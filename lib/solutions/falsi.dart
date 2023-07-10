import 'package:math_expressions/math_expressions.dart';

import './utils.dart';

class FalsePosition extends CustomUtils {
  final String function;
  final double xL;
  final double xR;
  final double tolerance;
  final int decimalPlaces;

  final List<List<String>> tableSolution = [];

  FalsePosition({
    required this.function,
    required this.xL,
    required this.xR,
    required this.tolerance,
    required this.decimalPlaces,
  });

  List<List<String>> solve() {
    tableSolution.add(["i", "xL", "xM", "xR", "f(xL)", "f(xM)", "f(xR)"]);

    if (_evaluate(xL) * _evaluate(xR) > 0) {
      throw Exception('The function does not change sign in the interval');
    }

    var i = 1;

    var _xL = xL;
    var _xR = xR;

    var oldXl = 0.0;
    var oldXr = 0.0;

    while (true) {
      oldXl = _xL;
      oldXr = _xR;

      var yl = roundNumber(_evaluate(_xL), decimalPlaces);
      var yr = roundNumber(_evaluate(_xR), decimalPlaces);

      // _xl + (_xr - _xl) * (yl / (yl - yr))
      var xM = roundNumber(_xL + (_xR - _xL) * (yl / (yl - yr)), decimalPlaces);
      var ym = roundNumber(_evaluate(xM), decimalPlaces);

      if (yl * ym < 0) {
        _xR = xM;
        tableSolution
            .add(["$i", "$oldXl", "$xM", "$oldXr", "$yl", "$ym", "$yr"]);
      } else {
        _xL = xM;
        tableSolution.add(["$i", "$oldXl", "$xM", "$_xR", "$yl", "$ym", "$yr"]);
      }

      if (ym.abs() <= tolerance || i == 100) {
        break;
      }

      i++;
    }

    return tableSolution;
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
