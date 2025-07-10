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
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/add_sublimit_button.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';

class ProjectStandbyLimitsTable extends StatelessWidget {
  final FacilitiesSummaryViewModel viewModel;
  final FacilityGroup? projectStandbyLimits;
  final CustomerFacility customer;
  const ProjectStandbyLimitsTable(
      {super.key,
      required this.viewModel,
      required this.projectStandbyLimits,
      required this.customer});

  @override
  Widget build(BuildContext context) {
    return CustomAccordion(
      title: "facilities.facilitySummary.projectStandBy".tr(),
      children: [
        const SizedBox(
          height: 20,
        ),
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
                  label: "facilities.facilitySummary.addProjectButton".tr(),
                  onPressed: () {}), // TODO redirect to new page after merge
              CustomButton(
                label: "facilities.facilitySummary.createProjectButton".tr(),
                onPressed: () {}, // TODO redirect to new page after merge
              )
            ],
          ),
        ),
      ],
    );
  }

  List<List<Widget>> getTableRows() {
    List<List<Widget>> rows = [];
    final facilities = projectStandbyLimits?.facilities ?? [];

    for (int index = 0; index < facilities.length; index++) {
      rows.add(
        [
          AddSublimitButton(
            facility: facilities[index],
            viewModel: viewModel,
            facilityGroup: projectStandbyLimits,
          ),
          Text((facilities[index].facilityDetails ?? "")),
          SustanabilityClassificationField(
            viewModel: viewModel,
            sustanabilityClassification: projectStandbyLimits
                    ?.facilities?[index].sustainabilityClassification ??
                [],
            facility: (facilities)[index],
          ),
          ExistingLimits(
            viewModel: viewModel,
            customer: customer,
            facility: facilities[index],
          ),
          ProposedLimits(
            viewModel: viewModel,
            facility: facilities[index],
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
                serialNumber: projectStandbyLimits?.facilities?[index].sNo,
                typeID: projectStandbyLimits?.typeId,
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
        label: Text('facilities.facilitySummary.action'.tr()),
      ),
    ];
  }

  List<List<Widget>> getProjectRelateTableRows() {
    List<List<Widget>> rows = [];

    for (int index = 0;
        index < (projectStandbyLimits?.facilities ?? []).length;
        index++) {
      rows.add(
        [
          Text((projectStandbyLimits?.facilities?[index].sNo).toString()),
          Text((projectStandbyLimits?.facilities?[index].facilityDetails)
              .toString()),
          SustanabilityClassificationField(
              viewModel: viewModel,
              sustanabilityClassification: projectStandbyLimits
                      ?.facilities?[index].sustainabilityClassification ??
                  [],
              facility: projectStandbyLimits?.facilities?[index]),
          ExistingLimits(
            viewModel: viewModel,
            customer: customer,
            facility: projectStandbyLimits?.facilities?[index],
          ),
          ProposedLimits(
            viewModel: viewModel,
            facility: projectStandbyLimits?.facilities?[index],
            customer: customer,
          ),
          OutstandingAmount(
            facility: projectStandbyLimits?.facilities?[index],
            customer: customer,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.overdueColor),
            onPressed: () {
              viewModel.deleteFacilityDetails(
                serialNumber: projectStandbyLimits?.facilities?[index].sNo,
                typeID: projectStandbyLimits?.typeId,
              );
            },
          ),
        ],
      );
    }
    return rows;
  }
}
