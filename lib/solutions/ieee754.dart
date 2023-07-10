import './utils.dart';

class IEEE754 extends CustomUtils {
  final double decimal;
  bool is32Bit;

  IEEE754(
    this.decimal, {
    this.is32Bit = true,
  });

  String solve() {
    String binary = _convertToBinary(decimal: decimal);
    String normalizedBinary = _normalizeBinary(decimal, binary);

    double bias = _normalizedExponent(decimal, binary) + (is32Bit ? 127 : 1023);
    String exponent = _fillExponent(
      _convertToBinary(decimal: bias, isWhole: true),
      is32Bit ? 8 : 11,
    );

    String mantissa = _fillMantissa(
      normalizedBinary.split('.')[1],
      is32Bit ? 24 : 52,
    );

    String sign = decimal < 0 ? '1' : '0';

    return '$sign $exponent $mantissa';
  }

  String _normalizeBinary(double decimal, String binary) {
    if (decimal < 1) {
      return _insertAtIndex(
          binary.substring(binary.split('').indexOf('1')), '.', 1);
    } else {
      return _insertAtIndex(binary.replaceAll('.', ''), '.', 1);
    }
  }

  int _normalizedExponent(double decimal, String binary) {
    return decimal < 1
        ? binary.split('').indexOf('1') * -1
        : binary.indexOf('.') - 1;
  }

  String _fillMantissa(String str, int bits) {
    if (str.length < bits) {
      return _fillMantissa('${str}0', bits);
    }
    return str.substring(0, bits);
  }

  String _fillExponent(String str, int bits) {
    if (str.length < bits) {
      return _fillExponent('0$str', bits);
    }
    return str.substring(0, bits);
  }

  String _insertAtIndex(String str, String substring, int index) {
    return str.substring(0, index) + substring + str.substring(index);
  }

  String _convertToBinary({
    required double decimal,
    bool isWhole = false,
  }) {
    int whole = decimal.toInt();
    List<int> binaryWhole = [];
    List<int> binaryFraction = [];

    String binary = '';

    while (whole > 0) {
      binaryWhole.insert(0, whole % 2);
      whole = whole ~/ 2;
    }

    if (isWhole) return binaryWhole.join();

    double fraction = decimal - decimal.toInt();
    while (fraction > 0) {
      if (binaryFraction.length > 25) break;

      fraction *= 2;
      if (fraction >= 1) {
        binaryFraction.add(1);
        fraction -= 1;
      } else {
        binaryFraction.add(0);
      }
    }

    binary = '${binaryWhole.join()}.${binaryFraction.join()}';

    return binary;
  }
}
