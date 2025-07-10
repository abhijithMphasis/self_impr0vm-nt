import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class SubLimitsDropDownField extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;

  const SubLimitsDropDownField({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: "Limit description",
      child: CustomDropdown<Reference>(
        items: viewModel.subLimitTypes,
        selectedItems: [
          viewModel.subLimitTypes.first,
        ],
        validationMessage: "validation.emptyField".tr(),
        onSelected: (selectedValue) {
          if (selectedValue.isNotEmpty) {
            viewModel.customerFacilities?.first.subLimitType =
                selectedValue.first;
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
