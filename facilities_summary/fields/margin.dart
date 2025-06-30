import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/_server_constants.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';

class Margin extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;

  final int? typeID;
  final int customerListIndex;
  final int facilityListIndex;
  const Margin(
      {super.key,
      required this.viewModel,
      this.typeID,
      required this.customerListIndex,
      required this.facilityListIndex});
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        initialValue: viewModel.customerFacilities?[customerListIndex]
            .generalWorkingCapitalLimits?.facilities?[facilityListIndex].margin,
        validator: CustomValidator.requiredField,
        onSaved: (String? value) {
          switch (typeID) {
            case ServerConstants.generalWorkingCapitalLimitID:
              viewModel
                  .customerFacilities?[customerListIndex]
                  .generalWorkingCapitalLimits
                  ?.facilities?[facilityListIndex]
                  .margin = (value);
              break;
            case ServerConstants.loansTypeID:
              viewModel.customerFacilities?[customerListIndex].loans
                  ?.facilities?[facilityListIndex].margin = value;
              break;
            case ServerConstants.pfeLimitsID:
              viewModel.customerFacilities?[customerListIndex].ppeLimits
                  ?.facilities?[facilityListIndex].margin = value;
              break;

            default:
              debugPrint("typeID not found");
          }
        });
  }
}
