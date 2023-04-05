class CalculatorState {
  final String buffer;
  final List<String> history;
  final CalculatorEngineMode mode;
  final String error;
  const CalculatorState({
    required this.buffer,
    required this.history,
    required this.mode,
    required this.error,
  });

  CalculatorState copyWith({
    String? buffer,
    List<String>? history,
    CalculatorEngineMode? mode,
    String? error,
  }) => CalculatorState(
    buffer: buffer ?? this.buffer,
    history: history ?? this.history,
    mode: mode ?? this.mode,
    error: error ?? this.error);
}

enum CalculatorEngineMode {
  input,
  result,
}