import 'package:flutter/material.dart';

/// リポジトリ詳細画面で「ラベル + 値」を横並びで表示するウィジェット
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
        Text(value, style: textStyle),
      ],
    );
  }
}