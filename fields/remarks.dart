import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textarea.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class Remarks extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const Remarks({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    //final bool hasData = viewModel.remarks?.toString().isNotEmpty ?? false;
    return LabelWidget(
      label: 'createSecurity.remarks'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomTextArea(
        maxLines: 10,
        minLines: 4,
        initialValue: viewModel.remarks,
        validator: CustomValidator.requiredField,
        onSaved: (String? value) {
          viewModel.remarks = value;
        },
      ),
    );
  }
}
