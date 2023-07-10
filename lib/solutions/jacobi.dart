import 'package:numerical_project/solutions/utils.dart';

class Jacobi extends CustomUtils {
  final List<String> equations;
  final int decimalPlaces;
  final double tolerance;
  List<List<String>> tableSolution = [];

  Jacobi(
    this.equations, {
    required this.tolerance,
    required this.decimalPlaces,
  });

  List<List<String>> solve() {
    tableSolution.add(["i", "x", "y", "z", "f(x)", "f(y)", "f(z)"]);

    var formattedEquations = [
      formatEquation(_getFormula("x", (equations[0]))),
      formatEquation(_getFormula("y", (equations[1]))),
      formatEquation(_getFormula("z", (equations[2]))),
    ];

    var x = 0.0;
    var y = 0.0;
    var z = 0.0;
    var counter = 0;

    while (true) {
      var xf = roundNumber(
          evaluate(formattedEquations[0], y: y, z: z), decimalPlaces);
      var yf = roundNumber(
          evaluate(formattedEquations[1], x: x, z: z), decimalPlaces);
      var zf = roundNumber(
          evaluate(formattedEquations[2], x: x, y: y), decimalPlaces);

      tableSolution.add([
        "$counter",
        "$x",
        "$y",
        "$z",
        "$xf",
        "$yf",
        "$zf",
      ]);

      if (((x - xf).abs() < tolerance &&
              (y - yf).abs() < tolerance &&
              (z - zf).abs() < tolerance) ||
          counter == 100) {
        break;
      }

      x = xf;
      y = yf;
      z = zf;

      counter++;
    }

    return tableSolution;
  }

  String formatEquation(String equation) {
    if (isReplace(equation, 'x')) {
      equation = equation.replaceAll("x", "*x");
    }
    if (isReplace(equation, 'y')) {
      equation = equation.replaceAll("y", "*y");
    }
    if (isReplace(equation, 'z')) {
      equation = equation.replaceAll("z", "*z");
    }

    return equation;
  }

  bool isReplace(String equation, variable) {
    if (!equation.contains(variable)) return false;
    return equation.indexOf(variable) > 0 &&
        (equation[(equation.indexOf(variable) - 1)] != '-' &&
            equation[(equation.indexOf(variable) - 1)] != '+' &&
            equation[(equation.indexOf(variable) - 1)] != '*' &&
            equation[(equation.indexOf(variable) - 1)] != '/' &&
            equation[(equation.indexOf(variable) - 1)] != '(');
  }

  String _getFormula(String variable, String equation) {
    equation = equation.replaceAll(" ", "");

    var splitEq = equation.split("=");
    var left = splitEq[0];
    var right = splitEq[1];

    var varIndex = equation.indexOf(variable);

    // get the coefficient of the variable
    var coef = "";
    while (equation[varIndex] != '+' &&
        equation[varIndex] != '-' &&
        varIndex > 0) {
      coef = equation[varIndex - 1] + coef;
      varIndex--;
    }

    if (coef == "+" || coef == "-") {
      coef = "1";
    }

    coef = coef.replaceAll("+", "");

    if (coef.contains('-')) {
      coef = coef.replaceAll('-', '');
    } else {
      coef = "-$coef";
    }

    if (right.contains('-')) {
      right = right.replaceAll('-', '+');
    } else {
      right = '-$right';
    }

    left += right;

    left = left.substring(0, varIndex) +
        left.substring(left.indexOf(variable) + 1);

    return "($left)/$coef";
  }
}
