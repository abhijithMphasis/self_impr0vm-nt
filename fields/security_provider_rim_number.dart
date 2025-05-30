import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/scale.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class SecurityProviderRimNumber extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  bool? isMobile = false;
  SecurityProviderRimNumber(
      {super.key, required this.viewModel, this.isMobile});
  @override
  Widget build(BuildContext context) {
    final bool hasData =
        viewModel.securityProviderRimNo?.toString().isNotEmpty ?? false;
    return LabelWidget(
      label: 'createSecurity.securityProviderRimNo'.tr(),
      isRequired: true,
      showLabel: true,
      child: Row(
        spacing: 10,
        children: [
          CustomTextField(
            width: isMobile == true ? 600.w : 150.w,
            initialValue: viewModel.securityProviderRimNo?.toString(),
            readOnly: hasData,
            filled: hasData,
            fillColor: !hasData
                ? AppColors.textFieldDisabledFill
                : AppColors.accordionSecondary,
            validator: hasData ? null : CustomValidator.requiredField,
            onSaved: (String? value) {
              if (viewModel.securityProviderRimNo != null) {
                viewModel.securityProviderRimNo = value;
              }
            },
          ),
          CustomButton(
            width: isMobile == true ? 100.w : 40.w,
            label: "",
            leadingIcon: const Icon(
              Icons.search,
              color: AppColors.white,
            ),
            onPressed: () {
              viewModel.onPressedSearchSecurityRimNo();
            },
          ),
          CustomButton(
            width: isMobile == true ? 100.w : 40.w,
            label: "",
            leadingIcon: const Icon(
              Icons.edit_square,
              color: AppColors.white,
            ),
            onPressed: () {
              viewModel.onPressedEditSecurityRimNo();
            },
          ),
        ],
      ),
    );
  }
}
