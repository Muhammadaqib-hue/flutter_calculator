import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '0';
  String _operator = '';
  double? _firstOperand;
  String _currentEquation = '';

  String _formatNumber(dynamic number) {
    if (number == null) return '';
    return number.toString().endsWith('.0')
        ? number.toStringAsFixed(0)
        : number.toString();
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _input = '';
        _output = '0';
        _operator = '';
        _firstOperand = null;
        _currentEquation = '';
      } else if (value == '+/-') {
        if (_input.isNotEmpty && _input != '0') {
          if (_input.startsWith('-')) {
            _input = _input.substring(1);
          } else {
            _input = '-$_input';
          }
        }
      } else if (value == '↺') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if ('+-×÷%'.contains(value)) {
        if (_input.isNotEmpty) {
          _firstOperand = double.tryParse(_input);
          _operator = value;
          _currentEquation = '${_formatNumber(_firstOperand)} $value';
          _input = '';
        }
      } else if (value == '=') {
        if (_firstOperand != null &&
            _operator.isNotEmpty &&
            _input.isNotEmpty) {
          final secondOperand = double.tryParse(_input);
          if (secondOperand != null) {
            switch (_operator) {
              case '+':
                _output = (_firstOperand! + secondOperand).toString();
                break;
              case '-':
                _output = (_firstOperand! - secondOperand).toString();
                break;
              case '×':
                _output = (_firstOperand! * secondOperand).toString();
                break;
              case '÷':
                if (secondOperand != 0) {
                  _output = (_firstOperand! / secondOperand).toString();
                } else {
                  _output = 'Error';
                }
                break;
              case '%':
                _output = (_firstOperand! % secondOperand).toString();
                break;
            }
            _currentEquation =
                '${_formatNumber(_firstOperand)} $_operator ${_formatNumber(secondOperand)} =';
            _input = _output;
            _operator = '';
            _firstOperand = null;
          }
        }
      } else {
        if (value == '.' && _input.contains('.')) return;
        _input += value;
        if (_operator.isNotEmpty) {
          _currentEquation =
              '${_formatNumber(_firstOperand)} $_operator $_input';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wb_sunny, color: Colors.grey.shade500),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.nights_stay, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _currentEquation.isEmpty ? _input : _currentEquation,
                  style: const TextStyle(
                    color: Color(0xFFE4E4E4),
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _output.endsWith('.0')
                      ? _output.substring(0, _output.length - 2)
                      : _output,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalculatorButton(
                              text: "AC",
                              textColor: const Color(0xFF35E7B8),
                              onTap: () => _onButtonPressed("AC")),
                          CalculatorButton(
                              text: "+/-",
                              textColor: const Color(0xFF35E7B8),
                              onTap: () => _onButtonPressed("+/-")),
                          CalculatorButton(
                              text: "%",
                              textColor: const Color(0xFF35E7B8),
                              onTap: () => _onButtonPressed("%")),
                          CalculatorButton(
                              text: "÷",
                              textColor: Colors.red,
                              textSize: 30,
                              onTap: () => _onButtonPressed("÷")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalculatorButton(
                              text: "7", onTap: () => _onButtonPressed("7")),
                          CalculatorButton(
                              text: "8", onTap: () => _onButtonPressed("8")),
                          CalculatorButton(
                              text: "9", onTap: () => _onButtonPressed("9")),
                          CalculatorButton(
                              text: "×",
                              textColor: Colors.red,
                              textSize: 30,
                              onTap: () => _onButtonPressed("×")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalculatorButton(
                              text: "4", onTap: () => _onButtonPressed("4")),
                          CalculatorButton(
                              text: "5", onTap: () => _onButtonPressed("5")),
                          CalculatorButton(
                              text: "6", onTap: () => _onButtonPressed("6")),
                          CalculatorButton(
                              text: "-",
                              textColor: Colors.red,
                              textSize: 35,
                              onTap: () => _onButtonPressed("-")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalculatorButton(
                              text: "1", onTap: () => _onButtonPressed("1")),
                          CalculatorButton(
                              text: "2", onTap: () => _onButtonPressed("2")),
                          CalculatorButton(
                              text: "3", onTap: () => _onButtonPressed("3")),
                          CalculatorButton(
                              text: "+",
                              textColor: Colors.red,
                              textSize: 30,
                              onTap: () => _onButtonPressed("+")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CalculatorButton(
                              text: "↺", onTap: () => _onButtonPressed("↺")),
                          CalculatorButton(
                              text: "0", onTap: () => _onButtonPressed("0")),
                          CalculatorButton(
                              text: ".", onTap: () => _onButtonPressed(".")),
                          CalculatorButton(
                              text: "=",
                              textSize: 30,
                              textColor: Colors.red,
                              onTap: () => _onButtonPressed("=")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onTap;
  final Color? textColor;
  final double? textSize;

  const CalculatorButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.textSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize ?? 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
