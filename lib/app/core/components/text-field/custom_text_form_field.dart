import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final int minLines;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final bool isSearch;
  final VoidCallback? onSubmit;
  final void Function(String?)? onSaved;
  final bool isEnabled;
  final bool isReadOnly;
  final TextCapitalization capitalization;
  final String? errorText;
  final VoidCallback? onEditingComplete;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.minLines = 1,
    this.maxLines = 1,
    this.onSuffixTap,
    this.validator,
    this.fillColor = Colors.white,
    this.onSaved,
    this.onSubmit,
    this.onChanged,
    this.onTap,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.inputFormatters,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.isSearch = false,
    this.onEditingComplete,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  Widget? _getSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.isPassword) {
      return IconButton(
        iconSize:25.sp,
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).hintColor,
        ),
        onPressed: _toggle,
      );
    }

    if (widget.isIcon) {
      return IconButton(
        onPressed: widget.onSuffixTap,
        iconSize:25.sp,
        icon: Icon(
          widget.isSearch
              ? Icons.search_outlined
              : widget.isCountryPicker
                  ? Icons.arrow_drop_down_outlined
                  : Icons.camera_alt_outlined,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.black,
      ),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      inputFormatters: widget.inputFormatters,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly,
      validator: widget.validator,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        labelText: widget.labelText,
        filled: true,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 48.sp),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: _getSuffixIcon(),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 48.sp),
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        errorText: widget.errorText,
      ),
      onTap: widget.onTap,
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!()
              : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      initialValue: widget.controller != null ? null : widget.initialValue,
      onEditingComplete: widget.onEditingComplete,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
