import 'package:easy_localization/easy_localization.dart';
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

class ViewMobile extends StatelessWidget {
  const ViewMobile({super.key});

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
      case LoadingStatus.empty:
        return Center(
          child: Text('Empty State'.tr()),
        );
      default:
        return buildView(viewModel);
    }
  }

  Widget buildView(FacilitiesSummaryViewModel viewModel) {
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
                  children: [
                    GeneralWorkingCapitalLimitTable(
                      customerListIndex: i,
                      viewModel: viewModel,
                      generalWorkingCapitalLimits: viewModel
                              .customerFacilities?[i]
                              .generalWorkingCapitalLimits ??
                          GeneralWorkingCapitalLimits(),
                    ),
                    LoansTable(
                      customerListIndex: i,
                      viewModel: viewModel,
                      loans: viewModel.customerFacilities?[i].loans ?? Loans(),
                    ),
                    PfeLimitsTable(
                      customerListIndex: i,
                      viewModel: viewModel,
                      ppeLimits: viewModel.customerFacilities?[i].ppeLimits ??
                          PPELimits(),
                    ),
                    ProjectStandbyLimitsTable(
                      viewModel: viewModel,
                      projectStandbyLimits: viewModel
                              .customerFacilities?[i].projectStandbyLimits ??
                          ProjectStandbyLimits(),
                      customerListIndex: i,
                    ),
                    ProjectSpecificLimitTable(
                        customerListIndex: i,
                        viewModel: viewModel,
                        projectSpecificLimit: viewModel
                                .customerFacilities?[i].projectSpecificLimit ??
                            ProjectSpecificLimit()),
                    OverallTotalTable(
                        viewModel: viewModel,
                        overallTotal:
                            viewModel.customerFacilities?[i].overallTotal ??
                                OverallTotal()),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: CustomButton(
                              label: "admin.save".tr(), onPressed: () {})),
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
