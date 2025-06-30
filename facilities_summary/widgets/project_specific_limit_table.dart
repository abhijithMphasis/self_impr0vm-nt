import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/accordion.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/custom_table/table.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/existing_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/outstanding.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/proposed_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sub_limits.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/fields/sustanability_classification.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/model.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class ProjectSpecificLimitTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final ProjectSpecificLimit? projectSpecificLimit;
  final int customerListIndex;
  const ProjectSpecificLimitTable(
      {super.key,
      required this.viewModel,
      this.projectSpecificLimit,
      required this.customerListIndex});

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilitySummary.projectSpecificLimit".tr(),
      children: [
        if (projectSpecificLimit == null)
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: LimitsDropDownField(
                    viewModel: viewModel,
                  )),
              Expanded(
                  flex: 2,
                  child: SubLimitsDropDownField(
                    viewModel: viewModel,
                  )),
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
    List<List<Widget>> rows = [];

    for (int index = 0;
        index < (projectSpecificLimit?.project?.facilities ?? []).length;
        index++) {
      rows.add(
        [
          Text((projectSpecificLimit?.project?.facilities ?? [])[index]
              .sNo
              .toString()),
          Text(projectSpecificLimit?.project?.projectName ?? ""),
          Text((projectSpecificLimit?.project?.facilities ?? [])[index]
                  .facilityDetails ??
              ""),
          SustanabilityClassificationField(
            viewModel: viewModel,
            sustanabilityClassification:
                (projectSpecificLimit?.project?.facilities ?? [])[index]
                        .sustainabilityClassification ??
                    [],
          ),
          ExistingLimits(
            viewModel: viewModel,
            customerListIndex: customerListIndex,
            facilityListIndex: index,
            typeID: projectSpecificLimit?.typeId,
          ),
          ProposedLimits(
            viewModel: viewModel,
            typeID: projectSpecificLimit?.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
          ),
          OutstandingAmount(
            viewModel: viewModel,
            typeID: projectSpecificLimit?.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
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
    return rows;
  }

  List<TableColumn> getTableColumns() {
    return [
      TableColumn(
        label: Text('facilitySummary.sNo'.tr()),
      ),
      TableColumn(
        label: Text('facilitySummary.projectName'.tr()),
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
        label: Text('facilitySummary.action'.tr()),
      ),
    ];
  }
}
