import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/components/accordion.dart';
import 'package:wcas_frontend/core/components/box_layout.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/section_header.dart';
import 'package:wcas_frontend/core/components/top_section/top_section_details.dart';
import 'package:wcas_frontend/core/globals.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/features/layout/view.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/general_working_capital_limit_table.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/loans_table.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/overall_total_table.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/pfe_limits_table.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/project_specific_limit_table.dart';
import 'package:wcas_frontend/features/request/facilities_securities/facilities_summary/widgets/project_standby_limits_table.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';
import 'package:wcas_frontend/models/request/request.dart';
import 'model.dart';
import 'state.dart';

class ViewDesktop extends StatelessWidget {
  const ViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    FacilitiesSummaryViewModel viewModel =
        context.read<FacilitiesSummaryViewModel>();
    return BlocBuilder<FacilitiesSummaryViewModel, FacilitiesSummaryState>(
        builder: (context, state) {
      return Layout(
        child: _body(context, state, viewModel),
      );
    });
  }

  Widget _body(BuildContext context, FacilitiesSummaryState state,
      FacilitiesSummaryViewModel viewModel) {
    switch (state.loaderStatus) {
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );

      default:
        return buildView(viewModel, state);
    }
  }

  Widget buildView(
    FacilitiesSummaryViewModel viewModel,
    FacilitiesSummaryState state,
  ) {
    return SingleChildScrollView(
      child: BoxLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            CustomSectionHeader(title: "facilitySummary.title".tr()),
            BoxLayout(
                child:
                    TopSectionDetails(request: Globals.request ?? Request())),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CustomAccordion(
                  title:
                      "${viewModel.customerFacilities?[i].custName} (${viewModel.customerFacilities?[i].rimNo})",
                  children: (state.tableLoaderStatus == LoadingStatus.loading)
                      ? [
                          const BoxLayout(
                              child: Center(
                            child: CupertinoActivityIndicator(
                              radius: 30,
                            ),
                          )),
                        ]
                      : [
                          GeneralWorkingCapitalLimitTable(
                            viewModel: viewModel,
                            generalWorkingCapitalLimits: viewModel
                                    .customerFacilities?[i]
                                    .generalWorkingCapitalLimits ??
                                GeneralWorkingCapitalLimits(),
                            customerListIndex: i,
                          ),
                          LoansTable(
                            viewModel: viewModel,
                            loans: viewModel.customerFacilities?[i].loans ??
                                Loans(),
                            customerListIndex: i,
                          ),
                          PfeLimitsTable(
                            viewModel: viewModel,
                            customerListIndex: i,
                            ppeLimits:
                                viewModel.customerFacilities?[i].ppeLimits ??
                                    PPELimits(),
                          ),
                          ProjectStandbyLimitsTable(
                            viewModel: viewModel,
                            projectStandbyLimits: viewModel
                                    .customerFacilities?[i]
                                    .projectStandbyLimits ??
                                ProjectStandbyLimits(),
                            customerListIndex: i,
                          ),
                          ProjectSpecificLimitTable(
                            viewModel: viewModel,
                            projectSpecificLimit: viewModel
                                    .customerFacilities?[i]
                                    .projectSpecificLimit ??
                                ProjectSpecificLimit(),
                            customerListIndex: i,
                          ),
                          OverallTotalTable(
                              viewModel: viewModel,
                              overallTotal: viewModel
                                      .customerFacilities?[i].overallTotal ??
                                  OverallTotal()),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: CustomButton(
                                    label: "admin.save".tr(),
                                    onPressed: () {
                                      viewModel.saveFacilityDetails(i);
                                    })),
                          )
                        ],
                ),
              ),
              itemCount: viewModel.customerFacilities?.length,
            ),
          ],
        ),
      ),
    );
  }
}
