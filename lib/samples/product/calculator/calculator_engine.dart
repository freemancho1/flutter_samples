import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_state.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorEngine extends StateNotifier<CalculatorState> {
  CalculatorEngine(): super(
      const CalculatorState(
          buffer: '0',
          history: [],
          mode: CalculatorEngineMode.result,
          error: ''
      )
  );

  /// isContinue = 결과를 출력하면서 계속해서 연산도 수행
  void addToBuffer(String str, {bool isContinue = false}) {
    /// state는 현재 클래스의 state로 위에서 정의한
    /// StateNotifier<CalculatorState>에서 CalculatorState를 나타냄
    if (state.mode == CalculatorEngineMode.result) {
      /// 연산결과 출력 모드 처리
      state = state.copyWith(
        /// 계속해서 입력을 받는 경우에는 기존 연산버퍼를 포함해 전달
        buffer: (isContinue ? state.buffer : '') + str,
        mode: CalculatorEngineMode.input,
        error: ''
      );
    } else {
      /// 연산에 필요한 데이터 입력 모드
      /// 결과를 보여주는 모드가 아니니 계속 버퍼를 추가하기만 함.
      state = state.copyWith(
        buffer: state.buffer + str,
        error: '',
      );
    }
  }

  /// Buffer - BackSpace Key 처리
  void backSpace() {
    final List<String> cList = Characters(state.buffer).toList();
    if (cList.isNotEmpty) {
      /// cList가 비어있지 않으면 길이를 하나 줄임.
      cList.length--;
    }
    state = state.copyWith(buffer: cList.join());
  }

  /// Buffer - clear
  void clear() => state = state.copyWith(buffer: '');

  /// 연산 또는 오류 처리
  void evaluate() {
    try {
      final parser = Parser();
      final cm = ContextModel();
      final exp = parser.parse(state.buffer);
      /// 연산결과
      final result = exp.evaluate(EvaluationType.REAL, cm) as double;

      if (result.isInfinite) {
        state = state.copyWith(
          buffer: '',
          mode: CalculatorEngineMode.result,
          error: 'Result is Infinite',
        );
      } else if (result.isNaN) {
        state = state.copyWith(
          buffer: '',
          mode: CalculatorEngineMode.result,
          error: 'Result is Not a Number',
        );
      } else {
        /// 20.0과 같이 정수형 데이터의 '.0'을 제거
        final resultStr = result.ceil() == result
            ? result.toInt().toString() : result.toString();
        state = state.copyWith(
          buffer: resultStr,
          mode: CalculatorEngineMode.result,
          history: ['${state.buffer} = $resultStr', ...state.history,],
        );
      }
    } catch(e) {
      state = state.copyWith(
        buffer: '',
        mode: CalculatorEngineMode.result,
        error: e.toString(),
      );
    }
  }
}

