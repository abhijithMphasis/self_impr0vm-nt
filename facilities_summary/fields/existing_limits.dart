import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/dropdown/dropdown.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/_server_constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

class ExistingLimits extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;

  final int? typeID;
  final int customerListIndex;
  final int facilityListIndex;
  const ExistingLimits(
      {super.key,
      required this.viewModel,
      required this.typeID,
      required this.customerListIndex,
      required this.facilityListIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomDropdown<Reference>(
            validationMessage: "validation.emptyField".tr(),
            items: viewModel.currencyCodes,
            selectedItems: viewModel.currencyCodes.isEmpty
                ? [Reference()] // for handle null issue
                : [viewModel.currencyCodes.first],
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
        ),
        Expanded(
          flex: 2,
          child: CustomTextField(
            keyboardType: TextInputType.number,
            initialValue: viewModel
                .customerFacilities?[customerListIndex]
                .generalWorkingCapitalLimits
                ?.facilities?[facilityListIndex]
                .existingLimits
                .toString(),
            validator: CustomValidator.requiredField,
            onSaved: (String? value) {
              switch (typeID) {
                case ServerConstants.generalWorkingCapitalLimitID:
                  viewModel
                      .customerFacilities?[customerListIndex]
                      .generalWorkingCapitalLimits
                      ?.facilities?[facilityListIndex]
                      .existingLimits = (value) as int?;
                  break;
                case ServerConstants.loansTypeID:
                  viewModel
                      .customerFacilities?[customerListIndex]
                      .loans
                      ?.facilities?[facilityListIndex]
                      .existingLimits = value as int?;
                  break;
                case ServerConstants.pfeLimitsID:
                  viewModel
                      .customerFacilities?[customerListIndex]
                      .ppeLimits
                      ?.facilities?[facilityListIndex]
                      .existingLimits = value as int?;
                  break;

                default:
                  debugPrint("typeID not found");
              }
            },
          ),
        ),
      ],
    );
  }
}
