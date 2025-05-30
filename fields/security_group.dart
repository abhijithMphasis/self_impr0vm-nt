import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SecurityGroup extends StatelessWidget {
  final CreateSecurityViewModel viewModel;
  const SecurityGroup({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.securityGroup'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomDropdown<Reference>(
        validationMessage: "validation.emptyField".tr(),
        items: viewModel.securityReferenceData,
        selectedItems: viewModel.securityGroupValue == null
            ? null
            : [viewModel.securityGroupValue],
        onSelected: (selectedValue) {
          if (selectedValue.isNotEmpty) {
            viewModel.securityGroupSelected(selectedValue.first);
          }
        },
        itemBuilder: (context, item, isDisabled, isSelected) {
          return ListTile(
            title: Text(item.reference4 ?? ""),
          );
        },
        dropdownBuilder: (context, data) {
          return Text(
            data?.reference4 ?? "",
            style: const TextStyle(fontSize: 14),
          );
        },
      ),
    );
  }
}
