import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class SecurityNumber extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const SecurityNumber({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final bool hasData = viewModel.securityNumber?.toString().isNotEmpty ?? false;
    return LabelWidget(
      label: 'createSecurity.securityNumber'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomTextField(
        initialValue: viewModel.securityNumber?.toString(),
        readOnly: hasData,
        filled: hasData,
        fillColor: !hasData
            ? AppColors.textFieldDisabledFill
            : AppColors.accordionSecondary,
        validator: hasData ? null : CustomValidator.requiredField,
        onSaved: (String? value) {
          if (viewModel.securityNumber != null) {
            viewModel.securityNumber = value;
          }
        },
      ),
    );
  }
}
