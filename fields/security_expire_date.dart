import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/datepicker.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class SecurityExpireDate extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const SecurityExpireDate({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(
          label: 'createSecurity.securityExpireDate'.tr(),
          isRequired: false,
          showLabel: true,
          child: CustomDatePicker(
            labelText: viewModel.securityExpireDate,
            blockedDates: const [],
            onSubmit: (date) {
              viewModel.securityExpireDate = date;
            },
            validator: CustomValidator.date,
          ),
        )
      ],
    );
  }
}
