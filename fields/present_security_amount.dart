import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class PresentSecurityAmount extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const PresentSecurityAmount({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final bool hasData =
        viewModel.presentSecurityAmount?.toString().isNotEmpty ?? false;
    return LabelWidget(
      label: 'createSecurity.presentSecurityAmount'.tr(),
      isRequired: false,
      showLabel: true,
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: CustomDropdown<Reference>(
              validationMessage: "validation.emptyField".tr(),
              items: viewModel.presentSecurityAmountItems,
              selectedItems: viewModel.presentSecurityAmountValue == null
                  ? null
                  : [viewModel.presentSecurityAmountValue],
              onSelected: (selectedValue) {
                if (selectedValue.isNotEmpty) {
                  viewModel.presentSecurityAmountSelected(selectedValue.first);
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
              initialValue: viewModel.presentSecurityAmount?.toString(),
              readOnly: hasData,
              filled: hasData,
              fillColor: !hasData
                  ? AppColors.textFieldDisabledFill
                  : AppColors.accordionSecondary,
              validator: hasData ? null : CustomValidator.requiredField,
              onSaved: (String? value) {
                if (viewModel.presentSecurityAmount != null) {
                  viewModel.presentSecurityAmount = value;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
