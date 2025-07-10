import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/accordion.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/custom_table/table.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/existing_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/facility_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/outstanding.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/proposed_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sub_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sustanability_classification.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class ProjectSpecificLimitTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final ProjectSpecificLimit? projectSpecificLimit;
  final CustomerFacility customer;
  const ProjectSpecificLimitTable(
      {super.key,
      required this.viewModel,
      this.projectSpecificLimit,
      required this.customer});

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilities.facilitySummary.projectSpecificLimit".tr(),
      children: [
        if (projectSpecificLimit == null)
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Expanded(
                  flex: 2, child: LimitsDropDownField(viewModel: viewModel)),
              Expanded(
                  flex: 2, child: SubLimitsDropDownField(viewModel: viewModel)),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: CustomButton(
                  label: ("Add facility"),
                  onPressed:
                      () {}, // TODO redirect to create facility page after merge
                ),
              )
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        CustomRawTable(
          columns: getTableColumns(),
          rows: getTableRows(),
        ),
      ],
    );
  }

  List<List<Widget>> getTableRows() {
    List<List<Widget>> tableRows = [];
    List<Facility>? facilities =
        projectSpecificLimit?.project?.facilities ?? [];
    int totalExistingLimit = 0;
    int totalProposedLimit = 0;
    int totalOutstandingAmount = 0;
    for (int index = 0; index < (facilities).length; index++) {
      totalExistingLimit += facilities[index].existingLimits ?? 0;
      totalProposedLimit += facilities[index].proposedLimits ?? 0;
      totalOutstandingAmount += facilities[index].outstanding ?? 0;
      tableRows.add(
        [
          Text((facilities)[index].sNo.toString()),
          Text(projectSpecificLimit?.project?.projectName ?? ""),
          Text((facilities)[index].facilityDetails ?? ""),
          SustanabilityClassificationField(
            viewModel: viewModel,
            facility: (facilities)[index],
            sustanabilityClassification:
                (facilities)[index].sustainabilityClassification ?? [],
          ),
          ExistingLimits(
            viewModel: viewModel,
            customer: customer,
            facility: facilities[index],
          ),
          ProposedLimits(
            facility: facilities[index],
            viewModel: viewModel,
            customer: customer,
          ),
          OutstandingAmount(
            facility: facilities[index],
            customer: customer,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.overdueColor),
            onPressed: () {
              viewModel.deleteFacilityDetails(
                serialNumber:
                    projectSpecificLimit?.project?.facilities?[index].sNo,
                typeID: projectSpecificLimit?.typeId,
              );
            },
          ),
        ],
      );
    }
    tableRows.add([
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      Text("facilities.facilitySummary.total".tr()),
      Text((projectSpecificLimit?.project?.totalProjectStandbyLimits)
          .toString()),
      Text(totalExistingLimit.toString()),
      Text(totalProposedLimit.toString()),
      Text(totalOutstandingAmount.toString()),
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
        label: Text('facilities.facilitySummary.projectName'.tr()),
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
        label: Text('facilities.facilitySummary.action'.tr()),
      ),
    ];
  }
}
