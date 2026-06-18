// ignore_for_file: deprecated_member_use

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomContainerFilter extends StatefulWidget {
  final String title;
  final Map<String, String> options;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const CustomContainerFilter({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomContainerFilter> createState() => _CustomContainerFilterState();
}

class _CustomContainerFilterState extends State<CustomContainerFilter> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _barrierFocusNode = FocusNode();
  bool _isOpen = false;
  bool _isHovered = false;
  late String _selectedKey;

  @override
  void initState() {
    super.initState();
    assert(
      widget.options.isNotEmpty,
      'options يجب أن تحتوي عنصراً واحداً على الأقل وهو "الكل"',
    );
    _selectedKey = widget.initialValue ?? widget.options.keys.first;
  }

  @override
  void didUpdateWidget(covariant CustomContainerFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // يزامن الاختيار مع القيمة القادمة من الأب (الـ Cubit/الصفحة الأم)
    // دون الحاجة لإعادة بناء الـ widget من الصفر.
    final newValue = widget.initialValue;
    if (newValue != null &&
        newValue != _selectedKey &&
        widget.options.containsKey(newValue)) {
      setState(() => _selectedKey = newValue);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _barrierFocusNode.dispose();
    super.dispose();
  }

  String get _selectedLabel => widget.options[_selectedKey] ?? '';
  bool get _isAllSelected => _selectedKey == widget.options.keys.first;

  void _toggleDropdown() => _isOpen ? _removeOverlay() : _showOverlay();

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final dropdownMaxHeight = context.height(320);
    final minWidth = context.width(220);
    final dropdownWidth = size.width < minWidth ? minWidth : size.width;
    final gap = context.height(8);
    final spaceBelow = screenHeight - offset.dy - size.height;
    final openUpward =
        spaceBelow < dropdownMaxHeight && offset.dy > dropdownMaxHeight;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final targetAnchor = openUpward
        ? (isRtl ? Alignment.topRight : Alignment.topLeft)
        : (isRtl ? Alignment.bottomRight : Alignment.bottomLeft);
    final followerAnchor = openUpward
        ? (isRtl ? Alignment.bottomRight : Alignment.bottomLeft)
        : (isRtl ? Alignment.topRight : Alignment.topLeft);

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: KeyboardListener(
                focusNode: _barrierFocusNode,
                autofocus: true,
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.escape) {
                    _removeOverlay();
                  }
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _removeOverlay,
                ),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              offset: Offset(0, openUpward ? -gap : gap),
              child: _DropdownList(
                width: dropdownWidth,
                maxHeight: dropdownMaxHeight,
                options: widget.options,
                selectedKey: _selectedKey,
                onSelected: (key) {
                  setState(() => _selectedKey = key!);
                  widget.onChanged(key!);
                  _removeOverlay();
                },
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpen = false);
    } else {
      _isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
              horizontal: context.width(18),
              vertical: context.height(8),
            ),
            margin: EdgeInsets.only(right: context.width(12)),
            decoration: BoxDecoration(
              color: _isOpen
                  ? ColorConstant.greyLight.withOpacity(0.6)
                  : _isHovered
                  ? ColorConstant.greyLight.withOpacity(0.85)
                  : ColorConstant.greyLight,
              borderRadius: BorderRadius.circular(context.width(50)),
              border: Border.all(
                color: _isOpen ? ColorConstant.deepGreen : Colors.transparent,
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: _isAllSelected
                      ? widget.title
                      : '${widget.title}: $_selectedLabel',
                  color: ColorConstant.black,
                  size: context.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: context.width(2),
                    top: context.height(1.5),
                  ),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 150),
                    turns: _isOpen ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: context.iconSize(18),
                      color: ColorConstant.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownList extends StatelessWidget {
  final double width;
  final double maxHeight;
  final Map<String?, String> options;
  final String selectedKey;
  final ValueChanged<String?> onSelected;

  const _DropdownList({
    required this.width,
    required this.maxHeight,
    required this.options,
    required this.selectedKey,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(context.width(16)),
      color: ColorConstant.white,
      shadowColor: Colors.black.withOpacity(0.25),
      child: Container(
        width: width,
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.width(16)),
          border: Border.all(color: ColorConstant.greyLight, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.width(16)),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: context.height(6)),
            itemCount: options.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              color: ColorConstant.greyLight.withOpacity(0.6),
            ),
            itemBuilder: (context, index) {
              final key = options.keys.elementAt(index);
              final label = options.values.elementAt(index);
              return _DropdownItem(
                label: label,
                isSelected: key == selectedKey,
                onTap: () => onSelected(key),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DropdownItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DropdownItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<_DropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.width(16),
            vertical: context.height(10),
          ),
          color: widget.isSelected
              ? ColorConstant.deepGreen.withOpacity(0.08)
              : _isHovered
              ? ColorConstant.greyLight.withOpacity(0.5)
              : Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  text: widget.label,
                  color: widget.isSelected
                      ? ColorConstant.deepGreen
                      : ColorConstant.black,
                  size: context.fontSize(14),
                  fontWeight: widget.isSelected
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
              if (widget.isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: context.iconSize(18),
                  color: ColorConstant.deepGreen,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
