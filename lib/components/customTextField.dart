import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_track/controller/themeController.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final obscureText;
  final String? errorText;
  final Function()? visibilityFunction;
  final Function(String value) updateValue;
  CustomTextField(
      {super.key,
      required this.hintText,
      this.obscureText,
      this.errorText,
      this.visibilityFunction,
      required this.updateValue});

  final ThemeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(
          () => TextField(
            obscureText: obscureText,
            cursorColor:
                _controller.isDarkMode.value ? Colors.black : Colors.white,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                suffixIcon: hintText == "Password"
                    ? IconButton(
                        onPressed: () {
                          visibilityFunction!();
                        },
                        icon: obscureText
                            ? Icon(
                                Icons.visibility_off,
                                color: _controller.isDarkMode.value
                                    ? Colors.black
                                    : Colors.white,
                              )
                            : Icon(Icons.visibility,
                                color: _controller.isDarkMode.value
                                    ? Colors.black
                                    : Colors.white))
                    : null,
                errorText: errorText == "" ? null : errorText,
                fillColor: _controller.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: _controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white
                        )
                        ),
            style: TextStyle(
                color:
                    _controller.isDarkMode.value ? Colors.black : Colors.white),
            onChanged: (value) {
              updateValue(value);
            },
          ),
        ));
  }
}
