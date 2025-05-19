import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable text input field widget.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isNumber;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.isNumber = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

/// A reusable dropdown input field widget.
class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final Function(String?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isValidValue = value != null && items.contains(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        value: isValidValue ? value : null,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
