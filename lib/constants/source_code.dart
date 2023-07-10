List<String> code = [
  bisectionCode,
  falsiCode,
  newtonCode,
  secantCode,
  jacobiCode,
  ieee754Code,
];

String bisectionCode = '''import math

formula = ""
xL = 0
xR = 0
tolerance = 0.001

table = [
    ["Iteration", "Xl", "Xm", "Xr", "f(Xl)", "f(Xm)", "f(Xr)"],
]

def format_formula(f):
    f = f.replace("^", "**")
    f = f.replace(" ", "")
    return f

def f(num):
    return round_number(eval(formula, {"x": num, "e": math.e, "pi": math.pi}))

def round_number(num):
    return round(num, 4)

def test_xl_xr():
    return f(xL) * f(xR) < 0
    
def solve_bisection():
    i = 1
    
    _xl = xL
    _xr = xR
  
    while True:
        old_xl = _xl
        old_xr = _xr
        
        xm = 0.0
        yl = f(_xl)
        yr = f(_xr)
        
        xm = round_number((_xl + _xr) / 2)
      
        ym = f(xm)
        
        if(yl * ym < 0):
            _xr = xm
            table.append([str(i), str(old_xl), str(xm), str(old_xr), str(yl), str(ym), str(yr)])
        else:
            _xl = xm
            table.append([str(i), str(old_xl), str(xm), str(_xr), str(yl), str(ym), str(yr)])   
        
        if i == 100: # Prevent infinite loop
            print("Method failed after 100 iterations.")
            break
        if abs(ym) <= tolerance:
            break
        
        i += 1

def print_table(data):
    column_widths = [max(map(len, column)) for column in zip(*data)]
    total_width = sum(column_widths) + 3 * len(column_widths) + 1
    print('+' + '-' * (total_width - 2) + '+')
    for row in data:
        if row == data[1]:
            print('+' + '-' * (total_width - 2) + '+')
        for i, cell in enumerate(row):
            print('|', end='')
            print(cell.rjust(column_widths[i] + 2), end='')
        print('|')
    print('+' + '-' * (total_width - 2) + '+')
    

print("\nHello! Welcome to Bisection and False position Method Solver!")
print("Note: You can use 'e' and 'pi' as constants in your function. and use only X as variable.\n")
while True:
    try:
        formula = format_formula(input("Enter a formula: "))
        tolerance = float(input("Enter tolerance/precision: "))
        
        while True:
            xL = float(input("Enter Xl: "))
            xR = float(input("Enter Xr: "))
            if test_xl_xr():
                break
            print("Xl and Xr must have different signs. Try again.")
        
        print("\nBisection Method")
        solve_bisection()
        print("Root: " + str(table[-1][2]) + "\n")
        print_table(table)
        
        ask = input("Do you want to try again? (y/n): ")
        if ask.lower() == "n":
            break
    except ValueError:
        print("Invalid input. Try again.")
        continue

''';

String falsiCode = '''import math

formula = ""
xL = 0
xR = 0
tolerance = 0.001

table = [
    ["Iteration", "Xl", "Xm", "Xr", "f(Xl)", "f(Xm)", "f(Xr)"],
]

def format_formula(f):
    f = f.replace("^", "**")
    f = f.replace(" ", "")
    return f

def f(num):
    return round_number(eval(formula, {"x": num, "e": math.e, "pi": math.pi}))

def round_number(num):
    return round(num, 4)

def test_xl_xr():
    return f(xL) * f(xR) < 0
    
def solve_falsi():
    i = 1
    
    _xl = xL
    _xr = xR
  
    while True:
        old_xl = _xl
        old_xr = _xr
        
        xm = 0.0
        yl = f(_xl)
        yr = f(_xr)
        
        
        xm = round_number(_xl + (_xr - _xl) * (yl / (yl - yr)))
            
        ym = f(xm)
        
        if(yl * ym < 0):
            _xr = xm
            table.append([str(i), str(old_xl), str(xm), str(old_xr), str(yl), str(ym), str(yr)])
        else:
            _xl = xm
            table.append([str(i), str(old_xl), str(xm), str(_xr), str(yl), str(ym), str(yr)])   
        
        if i == 100: # Prevent infinite loop
            print("Method failed after 100 iterations.")
            break
        if abs(ym) <= tolerance:
            break
        
        i += 1

def print_table(data):
    column_widths = [max(map(len, column)) for column in zip(*data)]
    total_width = sum(column_widths) + 3 * len(column_widths) + 1
    print('+' + '-' * (total_width - 2) + '+')
    for row in data:
        if row == data[1]:
            print('+' + '-' * (total_width - 2) + '+')
        for i, cell in enumerate(row):
            print('|', end='')
            print(cell.rjust(column_widths[i] + 2), end='')
        print('|')
    print('+' + '-' * (total_width - 2) + '+')
    

print("\nHello! Welcome to Bisection and False position Method Solver!")
print("Note: You can use 'e' and 'pi' as constants in your function. and use only X as variable.\n")
while True:
    try:
        formula = format_formula(input("Enter a formula: "))
        tolerance = float(input("Enter tolerance/precision: "))
        
        while True:
            xL = float(input("Enter Xl: "))
            xR = float(input("Enter Xr: "))
            if test_xl_xr():
                break
            print("Xl and Xr must have different signs. Try again.")
           
        print("False Position Method")
        solve_falsi()
        print("Root: " + str(table[-1][2]) + "\n")
        print_table(table)
        
        ask = input("Do you want to try again? (y/n): ")
        if ask.lower() == "n":
            break
    except ValueError:
        print("Invalid input. Try again.")
        continue''';

String newtonCode = '''import math

formula = ""
tolerance = 0.0001
table = []

def f(num):
    return eval(formula, {"x": num, "e": math.e, "pi": math.pi})
def f_prime(f, num, h=0.0001):
    return (f(num + h) - f(num - h)) / (2 * h)

def format_formula(f):
    f = f.replace("^", "**")
    f = f.replace(" ", "")
    return f

def round_number(num):
    return round(num, 4)

def print_table(data):
    column_widths = [max(map(len, column)) for column in zip(*data)]
    total_width = sum(column_widths) + 3 * len(column_widths) + 1
    print('+' + '-' * (total_width - 2) + '+')
    for row in data:
        if row == data[1]:
            print('+' + '-' * (total_width - 2) + '+')
        for i, cell in enumerate(row):
            print('|', end='')
            print(cell.rjust(column_widths[i] + 2), end='')
        print('|')
    print('+' + '-' * (total_width - 2) + '+')
    table.clear()

def solve_x_new_rhapson(xo):
    return round_number(xo - (f(xo) / f_prime(f, xo)))

def solve_newton_raphson(x):
    x_old = x
    i = 1
    while True:
        y_old = round_number(f(x_old))
        x_new = round_number(x_old - (y_old / round_number(f_prime(f, x_old))))
        
        y_new = round_number(f(x_new))
        
        table.append([str(i), str(x_new), str(x_old), str(y_new), str(y_old)])
        x_old = x_new
        
        if i == 100: # Prevent infinite loop
            print("Method failed after 100 iterations.")
            break
        if abs(y_new) <= tolerance:
            break
        
        i += 1

        
print("\nHello! Welcome to Newton-Raphson Solver!")
print("Note: You can use 'e' and 'pi' as constants in your function. and use only X as variable.\n")
print("Enter 0 to exit")    
while True:
    try:
        ask = int(input("#: "))
        if ask == 0:
            print("Thank you for using this program!")
            break
        else:
            print("You have chosen Newton-Raphson Method!")
            formula = format_formula(input("Enter your function: "))
            tolerance = float(input("Enter tolerance/precision: "))
            x = float(input("Enter xO: "))
            table.append(["i", "xN", "xO", "f(xN)", "f(xO)"])
            solve_newton_raphson(x)
            print("Root is: " + table[-1][2])
            print_table(table)
            
        ask = input("Do you want to continue? (y/n): ")
        
        if ask.lower() == "n":
            print("Thank you for using this program!")
            break
    except ValueError:
        print("Invalid input!")
        continue''';

String secantCode = '''import math

formula = ""
tolerance = 0.0001
table = []

def f(num):
    return eval(formula, {"x": num, "e": math.e, "pi": math.pi})

def format_formula(f):
    f = f.replace("^", "**")
    f = f.replace(" ", "")
    return f

def round_number(num):
    return round(num, 4)

def print_table(data):
    column_widths = [max(map(len, column)) for column in zip(*data)]
    total_width = sum(column_widths) + 3 * len(column_widths) + 1
    print('+' + '-' * (total_width - 2) + '+')
    for row in data:
        if row == data[1]:
            print('+' + '-' * (total_width - 2) + '+')
        for i, cell in enumerate(row):
            print('|', end='')
            print(cell.rjust(column_widths[i] + 2), end='')
        print('|')
    print('+' + '-' * (total_width - 2) + '+')
    table.clear()

def solve_secant(xa, xb):
    xn = 0.0
    i = 1
    while True:
        ya = (f(xa))
        yb = (f(xb))
        
        xn = (xa - ((ya * (xa - xb)) / (ya - yb)))
        yn = (f(xn))
        
        table.append([str(i), str(round_number(xa)), str(round_number(xb)), str(round_number(xn)), str(round_number(ya)), str(round_number(yb)), str(round_number(yn))])
        
        xa = xb
        xb = xn
        
        if i == 100: # Prevent infinite loop
            print("Method failed after 100 iterations.")
            break
        if abs(yn) <= tolerance:
            break
        
        i += 1
        
print("\nHello! Welcome to Secant Method Solver!")
print("Note: You can use 'e' and 'pi' as constants in your function. and use only X as variable.\n")
print("Enter 0 to exit")    
while True:
    try:
        ask = int(input("#: "))
        if ask == 0:
            print("Thank you for using this program!")
            break
        else:
            formula = format_formula(input("Enter your function: "))
            tolerance = float(input("Enter tolerance/precision: "))
            table.append(["i", "xA", "xB", "xN", "f(xA)", "f(xB)", "f(xN)"])
            solve_secant(float(input("Enter xA: ")), float(input("Enter xB: ")))
            print("Root is: " + table[-1][3])
            print_table(table)
        
        ask = input("Do you want to continue? (y/n): ")
        
        if ask.lower() == "n":
            print("Thank you for using this program!")
            break
    except ValueError:
        print("Invalid input!")
        continue''';

String jacobiCode = '''# libraries needed: sympy
# run: pip install sympy

from sympy import symbols, Eq, solve, expand
x, y, z = symbols('x y z')

tolerance = 0.001

def format_equation(equation):
    equation = equation.replace(" ", "")
    equation = equation.replace("^", "**")
    
    if(is_replace(equation, 'x')):
        equation = equation.replace("x", "*x")
    if(is_replace(equation, 'y')):
        equation = equation.replace("y", "*y")
    if(is_replace(equation, 'z')):
        equation = equation.replace("z", "*z")
        
    return equation

def is_replace(equation, variable):
    if(equation.find(variable) == -1):
        return False
    return equation.index(variable) > 0 and (equation[(equation.index(variable) - 1)] != '-' and equation[(equation.index(variable) - 1)] != '+' and equation[(equation.index(variable) - 1)] != '*')

def get_equations(eqns):
    equations=[]
    for i in range(len(eqns)):
        equation_str = format_equation(eqns[i])
        equation_parts = equation_str.replace(" ", "").split("=")
        
        left_side = equation_parts[0]
        right_side = equation_parts[1]

        equation = Eq(eval(left_side), eval(right_side))

        if i == 0:
          solutions = solve(equation, x)
          equations.append(solutions[0])
        if i == 1:
          solutions = solve(equation, y)
          equations.append(solutions[0])
        if i == 2:
          solutions = solve(equation, z)
          equations.append(solutions[0])
    return equations

def round_num(num):
    return round(num, 4)

def solve_jacobi(diagonal_eqn):
    counter = 0
            
    _x=0
    _y=0
    _z=0
    
    formulas = get_equations(diagonal_eqn)

    while True:
        _xf = round_num(eval(str(formulas[0]), {"y": _y, "z":_z}))
        _yf = round_num(eval(str(formulas[1]), {"x": _x, "z":_z}))
        _zf = round_num(eval(str(formulas[2]), {"x": _x, "y":_y}))
                
        print("Iteration", counter)
        
        print("x =", _x)
        print("y =", _y)
        print("z =", _z)
                
        print("")
                
        if(abs(_x - _xf) < tolerance and abs(_y - _yf) < tolerance and abs(_z - _zf) < tolerance):
            print("Solution found in", counter, "iterations")
            print("x =", round(_x, 3))
            print("y =", round(_y, 3))
            print("z =", round(_z, 3))
            break
                
        _x = _xf
        _y = _yf
        _z = _zf
                
        counter = counter + 1
                
print("\nWelcome to Jacobi iteration method")
print("This program solves a system of linear equations\n")
print("Note: Input the equations where it is diagonally dominant\n")

while True:
    try:
        inputted_equations = []
        tolerance = float(input("Enter tolerance: "))
        for i in range(3):
            eqn = input("Enter equation " + str(i + 1) + ": ")
            inputted_equations.append(eqn)
        solve_jacobi(inputted_equations)
        
        print("Do you want to solve another system of linear equations?")
        answer = input("Enter 'y' for yes or 'n' for no: ")
        
        if answer.lower() == "y":
            continue
        elif answer.lower() == "n":
            break
    except ValueError:
        print("Invalid input. Please try again.")''';

String ieee754Code = '''# methods for IEEE754 standard
    
def _normalize_binary(decimal, binary):
    if (decimal < 1):
        return _insert_at_index(binary[binary.find('1')::], '.', 1)
    else:
      return _insert_at_index(binary.replace('.', ''), '.', 1)

def _insert_at_index(str, substring, index):
    return str[:index] + substring + str[index:]

def fill_exponent(str, bits):
    if(len(str) < bits):
        return fill_exponent('0' + str, bits)
    return str[0:bits]

def fill_mantissa(str, bits):
    if(len(str) < bits):
        return fill_mantissa(str + '0', bits)
    return str[0:bits]

def normalize_binary(decimal, binary):
    if(decimal < 1):
        return _insert_at_index(
          binary[list(binary).index('1')], '.', 1)
    else:
      return _insert_at_index(binary.replace('.', ''), '.', 1)

def _normalized_exponent(decimal, binary):
    if(decimal < 1):
        return (binary.find('1') - 1 ) * -1
    else:
        return binary.find('.') - 1

def _convert_to_binary(decimal, is_whole=False):
    
    whole_number_part = int(decimal)
    fractional_part = decimal - whole_number_part
    
    # Convert whole number part to binary
    binary_whole_number = bin(whole_number_part)[2:]
    
    if(is_whole):
        return binary_whole_number
    
    # Convert fractional part to binary
    binary_fractional_part = ""
    while fractional_part != 0:
        # Limit the fractional part to 25 bits
        if(len(binary_fractional_part) >= 25):
            break
        fractional_part *= 2
        bit = int(fractional_part)
        binary_fractional_part += str(bit)
        fractional_part -= bit
    
    binary_number = binary_whole_number + "." + binary_fractional_part
    return binary_number

def solve(decimal, is32 = True):
    
    binary = _convert_to_binary(decimal)
    normalized_binary = _normalize_binary(decimal, binary)
    bias = _normalized_exponent(decimal, binary) + (127 if is32 else 1023)
    exponent = fill_exponent(_convert_to_binary(bias, True), 8 if is32 else 11)
    mantissa = fill_mantissa(normalized_binary.split('.')[1], 23 if is32 else 52)
    
    sign = '0' if decimal >= 0 else '1'
    
    return sign + " " + exponent + " " + mantissa
    
print("\nWelcome to IEEE754 Standard Solver!")
print("This program will convert a decimal number to its IEEE754 Standard representation.")
print("Enter 'q' to quit.\n")
print("Enter 1 to solve for 32-bit or 2 for 64-bit: ")

while True:
    try:
        inp = int(input("Enter your choice: "))
        decimal = float(input("Enter decimal number: "))
            
        if(inp == 1):
            print(solve(decimal))
        elif(inp == 2):
            print(solve(decimal, is32=False))
            
    except ValueError:
        print("Invalid input!")
        continue''';
