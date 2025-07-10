import 'package:flutter/widgets.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class AddSublimitButton extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final FacilityGroup? facilityGroup;
  final Facility? facility;
  const AddSublimitButton({
    super.key,
    required this.facility,
    required this.viewModel,
    required this.facilityGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${facility?.sNo}"),
        const SizedBox(width: 10),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 5.0),
        //   child: Align(
        //     alignment: Alignment.bottomRight,
        //     child: CustomButton(
        //       height: 20,
        //       label: "facilities.facilitySummary.addSublimit".tr(),
        //       onPressed: () {
        //         viewModel.saveFacilitySubLimit(
        //           facilityGroup: facilityGroup,
        //           facility: facility,
        //         );
        //       },
        //       textStyle: const TextStyle(
        //           fontSize: 10, color: AppColors.accordionPrimary),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
