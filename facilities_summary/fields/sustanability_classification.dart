import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SustanabilityClassificationField extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final List<Reference> sustanabilityClassification;
  const SustanabilityClassificationField(
      {super.key,
      required this.viewModel,
      required this.sustanabilityClassification});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Reference>(
      validationMessage: "validation.emptyField".tr(),
      items: sustanabilityClassification,
      selectedItems: sustanabilityClassification.isEmpty
          ? [Reference()] //TODO need separate variable for selected item
          : [sustanabilityClassification.first],
      onSelected: (selectedValue) {
        if (selectedValue.isNotEmpty) {
          //viewModel.changeSustanabilityClassification(selectedValue.first);
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
    );
  }
}
