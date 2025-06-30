import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class LimitsDropDownField extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final List<Reference>? limits;
  const LimitsDropDownField({super.key, required this.viewModel, this.limits});

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: "Limits",
      child: CustomDropdown<Reference>(
        items: limits,
        selectedItems: [limits?.first],
        onSelected: (selectedValue) {
          if (selectedValue.isNotEmpty) {
            // viewModel.proposedSecurityAmountSelected(selectedValue.first);
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
