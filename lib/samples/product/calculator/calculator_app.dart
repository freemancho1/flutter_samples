import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_button.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_engine.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_state.dart';

class CalculatorApp extends ConsumerWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('계산기'),),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: LayoutGrid(
            areas: gridTile,
            columnSizes: [1.fr, 1.fr, 1.fr, 1.fr, 2.fr],
            rowSizes: [2.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 2.fr, 2.fr, 2.fr, 2.fr],
            children: [
              NamedAreaGridPlacement(
                areaName: 'display',
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: state.error.isEmpty
                      ? AutoSizeText(
                          state.buffer,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                        )
                      : AutoSizeText(
                          state.error,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red
                          ),
                          maxLines: 2,
                        )
                  ),
                ),
              ),
              ...buttonDefinitions.map(
                  (definition) => NamedAreaGridPlacement(
                      areaName: definition.areaName,
                      child: CalcButton(
                        label: definition.label,
                        op: definition.op,
                        type: definition.type,
                      )
                  ),
              ),
              NamedAreaGridPlacement(
                areaName: 'history',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    children: [
                      const ListTile(
                        title: Text(
                          'history',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ...state.history.map((v) => ListTile(title: Text(v))),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

final calculatorStateProvider =
    StateNotifierProvider<CalculatorEngine, CalculatorState>(
        (_) => CalculatorEngine()
    );

const String gridTile = '''
              display display display display  history
              clear   bkspc   lparen  rparen   history
              sqrt    pow     abs     sgn      history
              ceil    floor   e       ln       history
              sin     cos     tan     fact     history
              arcsin  arccos  arctan  mod      history
              seven   eight   nine    divide   history
              four    five    six     multiply history
              one     two     three   minus    history
              zero    point   equals  plus     history
              ''';