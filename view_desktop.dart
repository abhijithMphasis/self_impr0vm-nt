import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/accordion.dart';
import 'package:wcas_frontend/core/components/custom_table/table.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/applicable_pricing.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/existing_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/margin.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/outstanding.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/proposed_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sustanability_classification.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/tenor_days.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/add_facility_button.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/add_sublimit_button.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

import 'package:wcas_frontend/core/services/route_service.dart';

class GeneralWorkingCapitalLimitTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final FacilityGroup? generalWorkingCapitalLimits;
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
      title: "facilities.facilitySummary.generalWorking".tr(),
      children: [
        const SizedBox(height: 20),
        CustomRawTable(
          columns: getTableColumns(),
          rows: getTableRows(),
        ),
      ],
    );
  }

  List<TableColumn> getTableColumns() {
    return [
      TableColumn(label: Text('facilities.facilitySummary.sNo'.tr())),
      TableColumn(label: Text("Add sublimit".tr())),
      TableColumn(label: Text('Limit No'.tr())),
      TableColumn(label: Text('facilities.facilitySummary.details'.tr())),
      TableColumn(
          label: Text('facilities.facilitySummary.classification'.tr())),
      TableColumn(
          label: Text('facilities.facilitySummary.existingLimits'.tr())),
      TableColumn(
          label: Text('facilities.facilitySummary.proposedLimits'.tr())),
      TableColumn(label: Text('facilities.facilitySummary.os'.tr())),
      TableColumn(label: Text('facilities.facilitySummary.tenorDays'.tr())),
      TableColumn(
          label: Text('facilities.facilitySummary.applicablePricing'.tr())),
      TableColumn(label: Text('facilities.facilitySummary.margin'.tr())),
      TableColumn(label: Text('Linked Facilities'.tr())),
      TableColumn(label: Text('Delete'.tr())),
    ];
  }

  List<List<Widget>> getTableRows() {
    List<Facility> facilities = generalWorkingCapitalLimits?.facilities ?? [];

    List<List<Widget>> tableRows = [];

    int totalExistingLimit = 0;
    int totalProposedLimit = 0;
    int totalOutstandingAmount = 0;

    for (Facility facility in facilities) {
      totalExistingLimit += facility.existingLimits ?? 0;
      totalProposedLimit += facility.proposedLimits ?? 0;
      totalOutstandingAmount += facility.outstanding ?? 0;

      tableRows.add([
        AddSublimitButton(
          facility: facility,
          viewModel: viewModel,
          facilityGroup: generalWorkingCapitalLimits,
        ),
        AddFacilityButton(
          facility: facility,
          viewModel: viewModel,
          facilityGroup: generalWorkingCapitalLimits,
        ),
        TextButton(
          onPressed: () {
            router.go(Routes.createFacility); //TODO need to view only data
          },
          child: Text(
            facility.facilityId.toString(),
            style: const TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.darkBlue,
            ),
          ),
        ),
        Text(facility.facilityDetails ?? ""),
        SustanabilityClassificationField(
          viewModel: viewModel,
          sustanabilityClassification:
              facility.sustainabilityClassification ?? [],
          facility: facility,
        ),
        ExistingLimits(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
        ),
        ProposedLimits(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
        ),
        OutstandingAmount(
          customer: customer,
          facility: facility,
        ),
        TenorDays(
          facility: facility,
          customer: customer,
        ),
        ApplicablePricing(
          facility: facility,
          customer: customer,
        ),
        Margin(
          customer: customer,
          facility: facility,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: const Icon(
            Icons.link,
            color: AppColors.buttonBackground,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete,
            color: AppColors.buttonBackground,
          ),
        ),
      ]);
    }

    tableRows.add([
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      Text("facilities.facilitySummary.total".tr()),
      Text((generalWorkingCapitalLimits?.total).toString()),
      Text(totalExistingLimit.toString()),
      Text(totalProposedLimit.toString()),
      Text(totalOutstandingAmount.toString()),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ]);

    return tableRows;
  }
}
