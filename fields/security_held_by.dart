import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SecurityHeldBy extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const SecurityHeldBy({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.securityHeldBy'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomDropdown<Reference>(
        validationMessage: "validation.emptyField".tr(),
        items: viewModel.securityHeldByItems,
        selectedItems: viewModel.securityHeldByValue == null
            ? null
            : [viewModel.securityHeldByValue],
        onSelected: (selectedValue) {
          if (selectedValue.isNotEmpty) {
            viewModel.securityHeldBySelected(selectedValue.first);
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
    );
  }
}
