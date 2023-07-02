import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:flutter_todo_list/const/theme.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final String? updateValue;
  final TextEditingController? controller;
  final Widget? widget;
  final bool isNote;

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.updateValue,
    this.controller,
    this.widget,
    this.isNote = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (updateValue != null) {
      controller!.text = updateValue!;
    }
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: isNote ? 100 : 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 8.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: greyColor,
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget != null,
                    controller: controller,
                    autofocus: false,
                    maxLines: isNote ? 3 : null,
                    style: subTitleStyle,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: subTitleStyle,
                      hintText: hint,
                      alignLabelWithHint: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget != null)
                  Container(
                    child: widget,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
