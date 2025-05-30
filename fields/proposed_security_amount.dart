import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class ProposedSecurityAmount extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const ProposedSecurityAmount({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final bool hasData =
        viewModel.proposedSecurityAmount?.toString().isNotEmpty ?? false;
    return LabelWidget(
      label: 'createSecurity.proposedSecurityAmount'.tr(),
      isRequired: true,
      showLabel: true,
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: CustomDropdown<Reference>(
              validationMessage: "validation.emptyField".tr(),
              items: viewModel.proposedSecurityAmountItems,
              selectedItems: viewModel.proposedSecurityAmountValue == null
                  ? null
                  : [viewModel.proposedSecurityAmountValue],
              onSelected: (selectedValue) {
                if (selectedValue.isNotEmpty) {
                  viewModel.proposedSecurityAmountSelected(selectedValue.first);
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
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextField(
              initialValue: viewModel.proposedSecurityAmount?.toString(),
              readOnly: hasData,
              filled: hasData,
              fillColor: !hasData
                  ? AppColors.textFieldDisabledFill
                  : AppColors.accordionSecondary,
              validator: hasData ? null : CustomValidator.requiredField,
              onSaved: (String? value) {
                if (viewModel.proposedSecurityAmount != null) {
                  viewModel.proposedSecurityAmount = value;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
