import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../theme/app_palette.dart' as palette;
import '../theme/app_text_styles.dart';

class AppSearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final String label;
  final String Function(T)? itemAsString;
  final ValueChanged<T?> onChanged;
  final bool compareByValue;

  const AppSearchableDropdown({
    super.key,
    required this.items,
    required this.label,
    this.initialValue,
    this.itemAsString,
    required this.onChanged,
    this.compareByValue = false,
  });

  @override
  State<AppSearchableDropdown<T>> createState() =>
      _AppSearchableDropdownState<T>();
}

class _AppSearchableDropdownState<T> extends State<AppSearchableDropdown<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        widget.initialValue ??
        (widget.items.isNotEmpty ? widget.items.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: palette.AppPalette.raisinBlack,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: palette.AppPalette.magnolia,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownSearch<T>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: palette.AppPalette.tropicalIndigo,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                ),
              ),
              menuProps: MenuProps(
                backgroundColor: palette.AppPalette.magnolia,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownBuilder:
                (context, selectedItem) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    selectedItem != null
                        ? (widget.itemAsString?.call(selectedItem) ??
                            selectedItem.toString())
                        : '',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
            items: (String filter, LoadProps? loadProps) async {
              return widget.items.where((item) {
                final displayString =
                    widget.itemAsString?.call(item) ?? item.toString();
                return displayString.toLowerCase().contains(
                  filter.toLowerCase(),
                );
              }).toList();
            },
            itemAsString:
                (T item) => widget.itemAsString?.call(item) ?? item.toString(),
            selectedItem: _selectedValue,
            compareFn:
                (item1, item2) =>
                    widget.compareByValue
                        ? widget.itemAsString?.call(item1) ==
                            widget.itemAsString?.call(item2)
                        : item1 == item2,
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedValue = value);
                widget.onChanged(value);
              }
            },
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: palette.AppPalette.periwinkle,
                    width: 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: palette.AppPalette.resolutionBlue,
                    width: 0.8,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: palette.AppPalette.periwinkle,
                    width: 0.8,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                filled: true,
                fillColor: palette.AppPalette.magnolia,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
