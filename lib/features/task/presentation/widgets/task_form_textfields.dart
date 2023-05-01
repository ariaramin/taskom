import 'package:flutter/material.dart';
import 'package:taskom/core/components/app_textfield.dart';
import 'package:taskom/core/constants/assets_manager.dart';
import 'package:taskom/core/constants/constants.dart';

class TaskFormTextFields extends StatelessWidget {
  final TextEditingController titleEditingController;
  final TextEditingController noteEditingController;
  final bool titleHasError;

  const TaskFormTextFields({
    super.key,
    required this.titleEditingController,
    required this.noteEditingController,
    this.titleHasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          AppTextField(
            controller: titleEditingController,
            labelText: "عنوان",
            iconUrl: AssetsManager.text,
            errorText:
                titleHasError ? _getFieldError(titleEditingController) : null,
          ),
          const SizedBox(
            height: 24,
          ),
          AppTextField(
            controller: noteEditingController,
            labelText: "یادداشت",
            iconUrl: AssetsManager.pin,
          ),
        ],
      ),
    );
  }

  String? _getFieldError(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return Constants.BLANK_ERROR_MESSAGE;
    }
    return null;
  }
}
