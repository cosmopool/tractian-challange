import 'package:flutter/material.dart';

import '../entities/company.dart';

class CompanyWidget extends StatefulWidget {
  const CompanyWidget({
    super.key,
    required this.company,
    required this.onTap,
  });

  final Company company;
  final VoidCallback onTap;

  @override
  State<CompanyWidget> createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fgColor = colors.onPrimary;

    final title = Text(
      widget.company.name,
      style:
          TextStyle(color: fgColor, fontWeight: FontWeight.w500, fontSize: 18),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: 78,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(child: title),
        ),
      ),
    );
  }
}
