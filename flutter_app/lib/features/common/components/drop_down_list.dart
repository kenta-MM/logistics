import 'package:flutter/material.dart';

class DropDownList<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String Function(T) itemLabelBuilder;

  DropDownList({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.label = '',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items.map((item) { 
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemLabelBuilder(item)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}