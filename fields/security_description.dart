import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SecurityDescription extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  final bool isDropDown;
  const SecurityDescription({
    super.key,
    required this.viewModel,
    required this.isDropDown,
  });
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.securityDescriptions'.tr(),
      isRequired: false,
      showLabel: true,
      child: isDropDown == true
          ? CustomDropdown<Reference>(
              validationMessage: "validation.emptyField".tr(),
              items: viewModel.securityReferenceData,
              selectedItems: viewModel.securityDescriptionsValue == null
                  ? null
                  : [viewModel.securityDescriptionsValue],
              onSelected: (selectedValue) {
                if (selectedValue.isNotEmpty) {
                  viewModel.securityDescriptionsSelected(selectedValue.first);
                }
              },
              itemBuilder: (context, item, isDisabled, isSelected) {
                return ListTile(
                  title: Text(item.name ?? ""),
                );
              },
              dropdownBuilder: (context, data) {
                return Text(
                  data?.name ?? "",
                  style: const TextStyle(fontSize: 14),
                );
              },
            )
          : CustomTextField(
              initialValue: viewModel.securityDescription?.toString(),
              readOnly: !isDropDown,
              filled: !isDropDown,
              fillColor: !isDropDown
                  ? AppColors.textFieldDisabledFill
                  : AppColors.accordionSecondary,
              validator: isDropDown ? null : CustomValidator.requiredField,
              onSaved: (String? value) {
                if (viewModel.securityDescription != null) {
                  viewModel.securityDescription = value;
                }
              },
            ),
    );
  }
}
