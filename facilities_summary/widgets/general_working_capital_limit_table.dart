import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/accordion.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/custom_table/table.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/existing_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/outstanding.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/proposed_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sustanability_classification.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class GeneralWorkingCapitalLimitTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final GeneralWorkingCapitalLimits generalWorkingCapitalLimits;
  final CustomerFacility customer;

  const GeneralWorkingCapitalLimitTable({
    super.key,
    required this.viewModel,
    required this.generalWorkingCapitalLimits,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilitySummary.generalWorkingCapital".tr(),
      children: [
        const SizedBox(height: 20),
        CustomRawTable(
          columns: getTableColumns(),
          rows: getTableRows(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            spacing: 20,
            children: [
              CustomButton(
                label: "facilitySummary.addRow".tr(),
                onPressed: () {
                  // Handle add row
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<TableColumn> getTableColumns() {
    return [
      TableColumn(label: Text('facilitySummary.sNo'.tr())),
      TableColumn(label: Text('facilitySummary.details'.tr())),
      TableColumn(label: Text('facilitySummary.classification'.tr())),
      TableColumn(label: Text('facilitySummary.existingLimits'.tr())),
      TableColumn(label: Text('facilitySummary.proposedLimits'.tr())),
      TableColumn(label: Text('facilitySummary.os'.tr())),
      TableColumn(label: Text('facilitySummary.action'.tr())),
    ];
  }

  List<List<Widget>> getTableRows() {
    final facilities = generalWorkingCapitalLimits.facilities ?? [];
    return List.generate(facilities.length, (index) {
      final facility = facilities[index];
      return [
        Text((facility.sNo).toString()),
        Text((facility.facilityDetails ?? "")),
        SustanabilityClassificationField(
          viewModel: viewModel,
          sustanabilityClassification: facility.sustainabilityClassification ?? [],
        ),
        ExistingLimits(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
          typeID: generalWorkingCapitalLimits.typeId,
        ),
        ProposedLimits(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
          typeID: generalWorkingCapitalLimits.typeId,
        ),
        OutstandingAmount(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
          typeID: generalWorkingCapitalLimits.typeId,
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: AppColors.overdueColor),
          onPressed: () {
            viewModel.deleteFacilityDetails(
              serialNumber: facility.sNo,
              typeID: generalWorkingCapitalLimits.typeId,
            );
          },
        ),
      ];
    });
  }
}
