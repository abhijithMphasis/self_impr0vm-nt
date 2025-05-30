import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/radiobutton.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class IsSecurityExpiryOpenEnded extends StatefulWidget {
  final CreateSecurityViewModel viewModel;
  const IsSecurityExpiryOpenEnded({super.key, required this.viewModel});

  @override
  State<IsSecurityExpiryOpenEnded> createState() =>
      _IsSecurityExpiryOpenEndedState();
}

class _IsSecurityExpiryOpenEndedState extends State<IsSecurityExpiryOpenEnded> {
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.isSecurityExpiryOpenEnded'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomRadioButton(
        validator: (value) {
          if (widget.viewModel.isSecurityExpiryOpenEnded
              .contains(value?.trim())) {
            return null;
          }
          return "createSecurity.isSecurityExpiryOpenEnded".tr();
        },
        options: widget.viewModel.isSecurityExpiryOpenEnded,
        selectedValue: widget.viewModel.selectedIsSecurityExpiryOpenEndedValue,
        onChanged: (value) {
          setState(() {
            widget.viewModel.selectedIsSecurityExpiryOpenEndedValue = value;
          });
        },
        selectedColor: AppColors.primary,
        unselectedColor: AppColors.tableBorderColor,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
