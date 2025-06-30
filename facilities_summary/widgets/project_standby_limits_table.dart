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

class ProjectStandbyLimitsTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final ProjectStandbyLimits projectStandbyLimits;
  final int customerListIndex;
  const ProjectStandbyLimitsTable(
      {super.key,
      required this.viewModel,
      required this.projectStandbyLimits,
      required this.customerListIndex});

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilitySummary.projectStandBy".tr(),
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomRawTable(
          columns: getTableColumns(false),
          rows: getTableRows(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            spacing: 20,
            children: [
              CustomButton(
                  label: "facilitySummary.addProjectButton".tr(),
                  onPressed: () {}), // TODO redirect to new page after merge
              CustomButton(
                label: "facilitySummary.createProjectButton".tr(),
                onPressed: () {}, // TODO redirect to new page after merge
              )
            ],
          ),
        ),
        CustomRawTable(
          columns: getTableColumns(true),
          rows: getProjectRelateTableRows(),
        ),
      ],
    );
  }

  List<List<Widget>> getTableRows() {
    List<List<Widget>> rows = [];

    for (int index = 0;
        index < (projectStandbyLimits.facilities ?? []).length;
        index++) {
      rows.add(
        [
          Text((projectStandbyLimits.facilities?[index].sNo).toString()),
          Text((projectStandbyLimits.facilities?[index].facilityDetails ?? "")),
          SustanabilityClassificationField(
            viewModel: viewModel,
            sustanabilityClassification: projectStandbyLimits
                    .facilities?[index].sustainabilityClassification ??
                [],
          ),
          ExistingLimits(
            viewModel: viewModel,
            customerListIndex: customerListIndex,
            facilityListIndex: index,
            typeID: projectStandbyLimits.typeId,
          ),
          ProposedLimits(
            viewModel: viewModel,
            typeID: projectStandbyLimits.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
          ),
          OutstandingAmount(
            viewModel: viewModel,
            typeID: projectStandbyLimits.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.overdueColor),
            onPressed: () {
              viewModel.deleteFacilityDetails(
                serialNumber: projectStandbyLimits.facilities?[index].sNo,
                typeID: projectStandbyLimits.typeId,
              );
            },
          ),
        ],
      );
    }
    return rows;
  }

  List<TableColumn> getTableColumns(bool isProjectTableColumn) {
    return [
      TableColumn(
        label: Text(isProjectTableColumn
            ? 'facilitySummary.projectName'.tr()
            : 'facilitySummary.sNo'.tr()),
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

  List<List<Widget>> getProjectRelateTableRows() {
    List<List<Widget>> rows = [];

    for (int index = 0;
        index < (projectStandbyLimits.project?.facilities ?? []).length;
        index++) {
      rows.add(
        [
          Text((projectStandbyLimits.project?.projectName ?? "")),
          Text(
              (projectStandbyLimits.project?.facilities?[index].facilityDetails)
                  .toString()),
          SustanabilityClassificationField(
            viewModel: viewModel,
            sustanabilityClassification: projectStandbyLimits
                    .facilities?[index].sustainabilityClassification ??
                [],
          ),
          ExistingLimits(
            viewModel: viewModel,
            customerListIndex: customerListIndex,
            facilityListIndex: index,
            typeID: projectStandbyLimits.typeId,
          ),
          ProposedLimits(
            viewModel: viewModel,
            typeID: projectStandbyLimits.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
          ),
          OutstandingAmount(
            viewModel: viewModel,
            typeID: projectStandbyLimits.typeId,
            facilityListIndex: index,
            customerListIndex: customerListIndex,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.overdueColor),
            onPressed: () {
              viewModel.deleteFacilityDetails(
                serialNumber:
                    projectStandbyLimits.project?.facilities?[index].sNo,
                typeID: projectStandbyLimits.typeId,
              );
            },
          ),
        ],
      );
    }
    return rows;
  }
}
