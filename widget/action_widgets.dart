import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class ActionWidgets extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  final bool isMobile;

  ActionWidgets({
    super.key,
    required this.viewModel,
    this.isMobile = false,
  });

  List<Widget> _buildButtons() {
    return [
      CustomButton(
        onPressed: viewModel.onSaveButtonPress,
        label: "createSecurity.save".tr(),
      ),
      CustomButton(
        onPressed: viewModel.onSaveContinueButtonPress,
        label: "createSecurity.saveAndContinue".tr(),
      ),
      CustomButton(
        onPressed: viewModel.onCancelButtonPress,
        label: "createSecurity.cancel".tr(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildButtons()
          .map((button) => Padding(
                padding: EdgeInsets.only(
                  right: isMobile ? 0 : 20,
                  bottom: isMobile ? 10 : 0,
                ),
                child: button,
              ))
          .toList(),
    );
  }
}
