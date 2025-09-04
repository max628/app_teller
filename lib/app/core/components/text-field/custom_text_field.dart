import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final Color? hintColor;
  final int minLines;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final IconData? prefixIcon;
  final bool isSearch;
  final bool isDropDown;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final String? errorText;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? enableOutlineColor;
  final double borderWidth;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.controller,
    this.borderWidth = 1,
    this.borderRadius = 10,
    this.focusNode,
    this.nextFocus,
    this.hintColor,
    this.isDropDown = false,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.minLines = 1,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    required this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIcon,
    this.errorText,
    this.verticalPadding = 16,
    this.horizontalPadding = 22,
    this.enableOutlineColor,
    this.isSearch = false,
    this.onEditingComplete,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: /*BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)) :*/
            BorderRadius.circular(6),
        /*boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
        ],*/
      ),
      child: TextField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: Theme.of(context).textTheme.labelMedium,
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: widget.capitalization,
        enabled: widget.isEnabled,
        autofocus: false,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.inputType == TextInputType.phone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp('[0-9+]'),
                ),
              ]
            : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius.r),
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: Theme.of(context).hintColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius.r),
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: Theme.of(context).primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius.r),
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: widget.enableOutlineColor ?? Colors.transparent,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius.r),
            ),
            borderSide: BorderSide(width: widget.borderWidth, color: Theme.of(context).colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius.r),
            ),
            borderSide: BorderSide(width: widget.borderWidth, color: Theme.of(context).colorScheme.error),
          ),
          isDense: true,
          hintText: widget.hintText,
          fillColor: widget.fillColor?.withValues(alpha: 0.03),
          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
          filled: true,
          prefixIcon: widget.isShowPrefixIcon
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 20,
                  ),
                  child: Icon(
                    widget.isPassword ? Icons.lock_outline : Icons.email_outlined,
                    color: Theme.of(context).hintColor,
                  ),
                )
              : const SizedBox.shrink(),
          prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
          suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor,
                      ),
                      onPressed: _toggle,
                    )
                  : widget.isIcon
                      ? IconButton(
                          onPressed: widget.onSuffixTap,
                          icon: Icon(
                            widget.isSearch
                                ? Icons.search_outlined
                                : widget.isDropDown
                                    ? Icons.arrow_drop_down_sharp
                                    : Icons.expand_more,
                            size: 25,
                            color: widget.hintColor,
                          ),
                        )
                      : null
              : null,
        ),
        onTap: widget.onTap,
        onSubmitted: (text) => widget.nextFocus != null
            ? FocusScope.of(context).requestFocus(widget.nextFocus)
            : widget.onSubmit != null
                ? widget.onSubmit!()
                : null,
        onChanged: (text) => widget.onChanged!(text),
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
