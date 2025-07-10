import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/icon.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class AddFacilityButton extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final FacilityGroup? facilityGroup;
  final Facility? facility;
  const AddFacilityButton(
      {super.key, required this.viewModel, this.facilityGroup, this.facility});

  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      onTap: () {
        Facility newFacility = Facility(sNo: 2);
        viewModel.addFacility(
          group: facilityGroup,
          facility: newFacility,
        );
      },
      icon: Icons.add_circle_outline_sharp,
      iconColor: AppColors.buttonBackground,
    );
  }
}
