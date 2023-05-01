import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/constants/assets_manager.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String iconUrl;
  final bool isPassword;
  final String? errorText;

  const AppTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.iconUrl,
    this.isPassword = false,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode focusNode = FocusNode();
  bool passwordVisible = false;
  bool focused = false;

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        focused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? !passwordVisible : false,
      focusNode: focusNode,
      decoration: InputDecoration(
        enabledBorder: _fieldBorder(),
        focusedBorder: _fieldFocusedBorder(),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(.5),
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primaryColor,
        ),
        errorBorder: _fieldErrorBorder(),
        focusedErrorBorder: _fieldErrorBorder(),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.errorColor,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 14),
          child: SvgPicture.asset(
            widget.iconUrl,
            width: 20,
            color: focused
                ? AppColors.primaryColor
                : Theme.of(context).colorScheme.onPrimary.withOpacity(.5),
          ),
        ),
        errorText: widget.errorText,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: passwordVisible
                      ? SvgPicture.asset(
                          AssetsManager.show,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(.5),
                        )
                      : SvgPicture.asset(
                          AssetsManager.hidden,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(.5),
                        ),
                ),
              )
            : null,
      ),
    );
  }

  OutlineInputBorder _fieldErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        width: 2,
        color: AppColors.errorColor.withOpacity(.8),
      ),
    );
  }

  OutlineInputBorder _fieldFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.primaryColor,
      ),
    );
  }

  OutlineInputBorder _fieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(.5),
      ),
    );
  }
}
