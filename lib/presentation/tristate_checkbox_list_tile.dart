import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_project/presentation/tristate_checkbox.dart';

class TristateCheckboxListTile extends StatelessWidget {
  const TristateCheckboxListTile({
    Key? key,
    required this.title,
    required this.additionalInfo,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.tileColor,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.autofocus = false,
    this.contentPadding,
    this.shape,
    this.selectedTileColor,
  }) : super(key: key);

  final TristateEnum value;
  final ValueChanged<TristateEnum>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final Color? tileColor;
  final String title;
  final String additionalInfo;
  final Widget? subtitle;
  final Widget? secondary;
  final bool isThreeLine;
  final bool? dense;
  final bool selected;
  final ListTileControlAffinity controlAffinity;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final Color? selectedTileColor;

  void _handleValueChange() {
    assert(onChanged != null);
    switch (value) {
      case TristateEnum.notChosen:
        onChanged!(TristateEnum.chosen);
        break;
      case TristateEnum.chosen:
        onChanged!(TristateEnum.partiallyChosen);
        break;
      case TristateEnum.partiallyChosen:
        onChanged!(TristateEnum.notChosen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget control = TristateCheckbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      checkColor: checkColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      autofocus: autofocus,
    );
    Widget? leading, trailing;
    switch (controlAffinity) {
      case ListTileControlAffinity.leading:
        leading = control;
        trailing = secondary;
        break;
      case ListTileControlAffinity.trailing:
      case ListTileControlAffinity.platform:
        leading = secondary;
        trailing = control;
        break;
    }

    return MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? Theme.of(context).accentColor,
        child: ListTile(
          leading: leading,
          title: _buildTitle(context),
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: onChanged != null,
          onTap: onChanged != null ? _handleValueChange : null,
          selected: selected,
          autofocus: autofocus,
          contentPadding: contentPadding,
          shape: shape,
          selectedTileColor: selectedTileColor,
          tileColor: tileColor,
        ),
      ),
    );
  }

  Widget _buildTitle(context) {
    final selectedTextStyle = TextStyle(
      color: Theme.of(context).disabledColor,
      decoration: TextDecoration.lineThrough,
    );

    switch (value) {
      case TristateEnum.chosen:
        return Text(
          '$title',
          style: selectedTextStyle,
        );
      case TristateEnum.partiallyChosen:
        return Text(
          '$title ($additionalInfo)',
          style: selectedTextStyle,
        );
      case TristateEnum.notChosen:
        return Text(title);
    }
  }
}
