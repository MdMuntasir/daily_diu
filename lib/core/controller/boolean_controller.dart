class BooleanController {
  late bool _value;

  BooleanController({bool initialValue = false}) {
    _value = initialValue;
  }

  bool get value => _value;

  void toggle() {
    _value = !_value;
  }

  void setValue(bool newValue) {
    _value = newValue;
  }
}