import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;

  final TextEditingController? passwordController;

  final bool isLast;
  final VoidCallback? onSubmitted;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.isLast = false,
    this.onSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
      widget.inputType == InputFieldType.confirmPassword;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
        if (!reg.hasMatch(value)) {
          return 'Имя должно содержать только буквы и пробелы';
        }
        return null;

      case InputFieldType.email:
        final reg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!reg.hasMatch(value)) {
          return 'Введите корректный email, например example@mail.com';
        }
        return null;

      case InputFieldType.password:
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_\-]).{6,}$',
        );
        if (!reg.hasMatch(value)) {
          return 'Не менее 6 символов, должны быть буквы, цифры и символы +, _, -';
        }
        return null;

      case InputFieldType.confirmPassword:
        if (value != widget.passwordController?.text) {
          return 'Пароли не совпадают';
        }
        return null;
    }
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.isLast
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: (_) {
        if (widget.isLast) {
          widget.onSubmitted?.call();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _isPassword
            ? IconButton(
                icon: Icon(
                  _hidePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _hidePassword = !_hidePassword);
                },
              )
            : null,
        enabledBorder: _border(Colors.black),
        focusedBorder: _border(Colors.black),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
      ),
      validator: _validator,
    );
  }
}
