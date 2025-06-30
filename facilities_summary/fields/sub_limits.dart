import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SubLimitsDropDownField extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final List<Reference>? sublimits;
  const SubLimitsDropDownField(
      {super.key, required this.viewModel, this.sublimits});

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: "Limit description",
      child: CustomDropdown<Reference>(
        items: sublimits,
        selectedItems: [sublimits?.first],
        onSelected: (selectedValue) {
          if (selectedValue.isNotEmpty) {}
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
