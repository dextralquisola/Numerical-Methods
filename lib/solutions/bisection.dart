import 'package:numerical_project/solutions/utils.dart';

class Bisection extends CustomUtils {
  final String function;
  final double xL;
  final double xR;
  final double tolerance;
  final int decimalPlaces;

  final List<List<String>> tableSolution = [];

  Bisection({
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

      var xM = roundNumber(((_xL + _xR) / 2), decimalPlaces);

      var ym = roundNumber(_evaluate(xM), decimalPlaces);

      if (yl * ym < 0) {
        _xR = xM;
        tableSolution
            .add(["$i", "$oldXl", "$xM", "$oldXr", "$yl", "$ym", "$yr"]);
      } else {
        _xL = xM;
        tableSolution.add(["$i", "$oldXl", "$xM", "$_xR", "$yl", "$ym", "$yr"]);
      }

      if (ym.abs() <= tolerance || i > 100) {
        break;
      }

      i++;
    }

    return tableSolution;
  }

  double _evaluate(double number) {
    return evaluate(function, x: number);
  }
}
