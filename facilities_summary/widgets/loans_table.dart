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
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class LoansTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final Loans loans;
  final int customerListIndex;
  const LoansTable({
    super.key,
    required this.viewModel,
    required this.loans,
    required this.customerListIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilitySummary.loans".tr(),
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
    List<List<Widget>> rows = [];

    for (int index = 0; index < (loans.facilities ?? []).length; index++) {
      rows.add([
        Text((index + 1).toString()),
        Text((loans.facilities ?? [])[index].facilityDetails ?? ""),
        SustanabilityClassificationField(
          viewModel: viewModel,
          sustanabilityClassification:
              loans.facilities?[index].sustainabilityClassification ?? [],
        ),
        ExistingLimits(
          viewModel: viewModel,
          customerListIndex: customerListIndex,
          facilityListIndex: index,
          typeID: loans.typeId,
        ),
        ProposedLimits(
          viewModel: viewModel,
          typeID: loans.typeId,
          facilityListIndex: index,
          customerListIndex: customerListIndex,
        ),
        OutstandingAmount(
          viewModel: viewModel,
          typeID: loans.typeId,
          facilityListIndex: index,
          customerListIndex: customerListIndex,
        ),
        TenorDays(
          viewModel: viewModel,
          typeID: loans.typeId,
          facilityListIndex: index,
          customerListIndex: customerListIndex,
        ),
        ApplicablePricing(
          viewModel: viewModel,
          typeID: loans.typeId,
          facilityListIndex: index,
          customerListIndex: customerListIndex,
        ),
        Margin(
          viewModel: viewModel,
          customerListIndex: customerListIndex,
          facilityListIndex: index,
          typeID: loans.typeId,
        ),
      ]);
    }

    return rows;
  }

  List<TableColumn> getTableColumns() {
    return [
      TableColumn(
        label: Text('facilitySummary.sNo'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.details'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.classification'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.existingLimits'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.proposedLimits'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.os'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.tenorDays'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.applicablePricing'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.margin'.tr()),
      ),
    ];
  }
}
