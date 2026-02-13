import 'package:flutter/material.dart';

/// A stateful [TextField] with a managed controller.
class TextFieldEditor extends StatefulWidget {
  /// Creates a [TextFieldEditor].
  const TextFieldEditor({
    required void Function(String) onChanged,
    String? initialValue,
    String? labelText,
    super.key,
  }) : _initialValue = initialValue,
       _labelText = labelText,
       _onChanged = onChanged;

  final String? _initialValue;
  final String? _labelText;
  final void Function(String) _onChanged;

  @override
  State<TextFieldEditor> createState() => _TextFieldEditorState();
}

class _TextFieldEditorState extends State<TextFieldEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget._initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget._onChanged,
      decoration: InputDecoration(labelText: widget._labelText),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
