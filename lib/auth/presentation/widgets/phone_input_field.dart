import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInputField extends StatelessWidget {
  late final TextEditingController controller;
  late final ValueChanged<PhoneNumber> onChanged;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: onChanged,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
    );
  }
}