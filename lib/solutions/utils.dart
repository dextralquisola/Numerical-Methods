import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class CustomUtils {
  double roundNumber(double number, int decimals) {
    return double.parse(number.toStringAsFixed(decimals));
  }

  double evaluate(String function, {
    double number = 0.0,
    double x = 0.0,
    double y = 0.0,
    double z = 0.0,
  }) {
    Parser p = Parser();
    Expression exp = p.parse(function);

    Variable varX = Variable('x');
    Variable varY = Variable('y');
    Variable varZ = Variable('z');

    Number numX = Number(x);
    Number numY = Number(y);
    Number numZ = Number(z);

    Variable e = Variable('e');
    ContextModel cm = ContextModel()
      ..bindVariable(varX, numX)
      ..bindVariable(varY, numY)
      ..bindVariable(varZ, numZ)
      ..bindVariable(e, Number(math.e));
    return exp.evaluate(EvaluationType.REAL, cm);
  }
}
