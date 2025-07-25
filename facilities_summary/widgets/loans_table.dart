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
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/add_sublimit_button.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class LoansTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final FacilityGroup? loans;
  final CustomerFacility customer;
  const LoansTable({
    super.key,
    required this.viewModel,
    required this.loans,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilities.facilitySummary.loans".tr(),
      textColor: AppColors.primary,
      children: [
        CustomRawTable(
          columns: getTableColumns(),
          rows: getTableRows(),
        )
      ],
    );
  }

  List<List<Widget>> getTableRows() {
    List<List<Widget>> tableRows = [];
    int totalExistingLimit = 0;
    int totalProposedLimit = 0;
    int totalOutstandingAmount = 0;
    List<Facility>? facilities = loans?.facilities ?? [];
    for (int index = 0; index < facilities.length; index++) {
      Facility facility = facilities[index];
      totalExistingLimit += facility.existingLimits ?? 0;
      totalProposedLimit += facility.proposedLimits ?? 0;
      totalOutstandingAmount += facility.outstanding ?? 0;
      tableRows.add([
        AddSublimitButton(
          facility: facility,
          viewModel: viewModel,
          facilityGroup: loans,
        ),
        Text(facility.facilityDetails ?? ""),
        SustanabilityClassificationField(
          viewModel: viewModel,
          facility: facility,
          sustanabilityClassification:
              facility.sustainabilityClassification ?? [],
        ),
        ExistingLimits(
          viewModel: viewModel,
          customer: customer,
          facility: facility,
        ),
        ProposedLimits(
          viewModel: viewModel,
          facility: facility,
          customer: customer,
        ),
        OutstandingAmount(
          facility: facility,
          customer: customer,
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
      ]);
    }
    tableRows.add([
      const SizedBox.shrink(),
      Text("facilities.facilitySummary.total".tr()),
      Text((loans?.total).toString()),
      Text(totalExistingLimit.toString()),
      Text(totalProposedLimit.toString()),
      Text(totalOutstandingAmount.toString()),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ]);
    return tableRows;
  }

  List<TableColumn> getTableColumns() {
    return [
      TableColumn(
        label: Text('facilities.facilitySummary.sNo'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.details'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.classification'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.existingLimits'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.proposedLimits'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.os'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.tenorDays'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.applicablePricing'.tr()),
      ),
      TableColumn(
        label: Text('facilities.facilitySummary.margin'.tr()),
      ),
    ];
  }
}
