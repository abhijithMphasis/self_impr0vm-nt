import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';

class AddSublimitButton extends StatelessWidget {
  final int? serialNumber;
  final FacilitiesSummaryViewModel viewModel;
  final int customerFacilityListIndex;
  const AddSublimitButton(
      {super.key,
      required this.serialNumber,
      required this.viewModel,
      required this.customerFacilityListIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(serialNumber.toString()),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              height: 20,
              label: "facilitySummary.addSublimit".tr(),
              onPressed: () {
                viewModel.saveFacilitySubLimit(
                  customerFacilityListIndex,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
