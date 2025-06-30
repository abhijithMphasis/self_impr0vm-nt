import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/core/constants/_server_constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';

class ApplicablePricing extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final int? typeID;

  final int facilityListIndex;
  final int customerListIndex;
  const ApplicablePricing(
      {super.key,
      required this.viewModel,
      required this.typeID,
      required this.facilityListIndex,
      required this.customerListIndex});
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      initialValue: viewModel
          .customerFacilities?[customerListIndex]
          .generalWorkingCapitalLimits
          ?.facilities?[facilityListIndex]
          .applicablePricing,
      onSaved: (String? value) {
        switch (typeID) {
          case ServerConstants.generalWorkingCapitalLimitID:
            viewModel
                .customerFacilities?[customerListIndex]
                .generalWorkingCapitalLimits
                ?.facilities?[facilityListIndex]
                .applicablePricing = value;
            break;
          case ServerConstants.loansTypeID:
            viewModel.customerFacilities?[customerListIndex].loans
                ?.facilities?[facilityListIndex].applicablePricing = value;
            break;
          case ServerConstants.pfeLimitsID:
            viewModel.customerFacilities?[customerListIndex].ppeLimits
                ?.facilities?[facilityListIndex].applicablePricing = value;
            break;

          default:
            debugPrint("typeID not found");
        }
      },
    );
  }
}
