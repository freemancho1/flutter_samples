import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_app.dart';

import 'calculator_engine.dart';

enum CalcButtonType { outlined, elevated }

typedef CalculatorEngineCallback = void Function(CalculatorEngine engine);

class ButtonDefinition {
  const ButtonDefinition({
    required this.areaName,
    required this.label,
    required this.op,
    this.type = CalcButtonType.outlined,
  });

  final String areaName;
  final String label;
  final CalculatorEngineCallback op;
  final CalcButtonType type;
}

final buttonDefinitions = <ButtonDefinition>[
  ButtonDefinition(
    areaName: 'clear',
    op: (engine) => engine.clear(),
    label: 'AC',
  ),
  ButtonDefinition(
    areaName: 'bkspc',
    op: (engine) => engine.backSpace(),
    label: '⌫',
  ),
  ButtonDefinition(
    areaName: 'lparen',
    op: (engine) => engine.addToBuffer('('),
    label: '(',
  ),
  ButtonDefinition(
    areaName: 'rparen',
    op: (engine) => engine.addToBuffer(')'),
    label: ')',
  ),
  ButtonDefinition(
    areaName: 'sqrt',
    op: (engine) => engine.addToBuffer('sqrt('),
    label: '√',
  ),
  ButtonDefinition(
    areaName: 'pow',
    op: (engine) => engine.addToBuffer('^'),
    label: '^',
  ),
  ButtonDefinition(
    areaName: 'abs',
    op: (engine) => engine.addToBuffer('abs('),
    label: 'Abs',
  ),
  ButtonDefinition(
    areaName: 'sgn',
    op: (engine) => engine.addToBuffer('sgn('),
    label: 'Sgn',
  ),
  ButtonDefinition(
    areaName: 'ceil',
    op: (engine) => engine.addToBuffer('ceil('),
    label: 'Ceil',
  ),
  ButtonDefinition(
    areaName: 'floor',
    op: (engine) => engine.addToBuffer('floor('),
    label: 'Floor',
  ),
  ButtonDefinition(
    areaName: 'e',
    op: (engine) => engine.addToBuffer('e('),
    label: 'e',
  ),
  ButtonDefinition(
    areaName: 'ln',
    op: (engine) => engine.addToBuffer('ln('),
    label: 'ln',
  ),
  ButtonDefinition(
    areaName: 'sin',
    op: (engine) => engine.addToBuffer('sin('),
    label: 'Sin',
  ),
  ButtonDefinition(
    areaName: 'cos',
    op: (engine) => engine.addToBuffer('cos('),
    label: 'Cos',
  ),
  ButtonDefinition(
    areaName: 'tan',
    op: (engine) => engine.addToBuffer('tan('),
    label: 'Tan',
  ),
  ButtonDefinition(
    areaName: 'fact',
    op: (engine) => engine.addToBuffer('!'),
    label: '!',
  ),
  ButtonDefinition(
    areaName: 'arcsin',
    op: (engine) => engine.addToBuffer('arcsin('),
    label: 'Arc Sin',
  ),
  ButtonDefinition(
    areaName: 'arccos',
    op: (engine) => engine.addToBuffer('arccos('),
    label: 'Arc Cos',
  ),
  ButtonDefinition(
    areaName: 'arctan',
    op: (engine) => engine.addToBuffer('arctan('),
    label: 'Arc Tan',
  ),
  ButtonDefinition(
    areaName: 'mod',
    op: (engine) => engine.addToBuffer('%'),
    label: 'Mod',
  ),
  ButtonDefinition(
    areaName: 'seven',
    op: (engine) => engine.addToBuffer('7'),
    label: '7',
  ),
  ButtonDefinition(
    areaName: 'eight',
    op: (engine) => engine.addToBuffer('8'),
    label: '8',
  ),
  ButtonDefinition(
    areaName: 'nine',
    op: (engine) => engine.addToBuffer('9'),
    label: '9',
  ),
  ButtonDefinition(
    areaName: 'four',
    op: (engine) => engine.addToBuffer('4'),
    label: '4',
  ),
  ButtonDefinition(
    areaName: 'five',
    op: (engine) => engine.addToBuffer('5'),
    label: '5',
  ),
  ButtonDefinition(
    areaName: 'six',
    op: (engine) => engine.addToBuffer('6'),
    label: '6',
  ),
  ButtonDefinition(
    areaName: 'one',
    op: (engine) => engine.addToBuffer('1'),
    label: '1',
  ),
  ButtonDefinition(
    areaName: 'two',
    op: (engine) => engine.addToBuffer('2'),
    label: '2',
  ),
  ButtonDefinition(
    areaName: 'three',
    op: (engine) => engine.addToBuffer('3'),
    label: '3',
  ),
  ButtonDefinition(
    areaName: 'zero',
    op: (engine) => engine.addToBuffer('0'),
    label: '0',
  ),
  ButtonDefinition(
    areaName: 'point',
    op: (engine) => engine.addToBuffer('.'),
    label: '.',
  ),
  ButtonDefinition(
    areaName: 'equals',
    op: (engine) => engine.evaluate(),
    label: '=',
    type: CalcButtonType.elevated,
  ),
  ButtonDefinition(
    areaName: 'plus',
    op: (engine) => engine.addToBuffer('+', isContinue: true),
    label: '+',
  ),
  ButtonDefinition(
    areaName: 'minus',
    op: (engine) => engine.addToBuffer('-', isContinue: true),
    label: '-',
  ),
  ButtonDefinition(
    areaName: 'multiply',
    op: (engine) => engine.addToBuffer('*', isContinue: true),
    label: '*',
  ),
  ButtonDefinition(
    areaName: 'divide',
    op: (engine) => engine.addToBuffer('/', isContinue: true),
    label: '/',
  ),
];

class CalcButton extends ConsumerWidget {
  final CalculatorEngineCallback op;
  final String label;
  final CalcButtonType type;
  const CalcButton({
    super.key,
    required this.op,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonConstructor = type == CalcButtonType.elevated
        ? ElevatedButton.new : OutlinedButton.new;
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: buttonConstructor(
          autofocus: false,
          clipBehavior: Clip.none,
          onPressed: () => op(ref.read(calculatorStateProvider.notifier)),
          child: AutoSizeText(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54
            ),
          )
        ),
      ),
    );
  }
}