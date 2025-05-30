import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/components/box_layout.dart';
import 'package:wcas_frontend/core/components/section_background.dart';
import 'package:wcas_frontend/core/components/section_header.dart';
import 'package:wcas_frontend/core/components/top_section/top_section_details.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/globals.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/features/layout/view.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/country_of_incorporation.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/is_security_expiry_open_ended.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/is_security_provider_cbd_customer.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/limit_controlling_security.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/present_security_amount.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/proposed_security_amount.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/remarks.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_code.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_description.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_expire_date.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_group.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_held_by.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_number.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_provider_name.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_provider_rim_number.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/security_status.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/fields/tangible_security.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/widget/action_widgets.dart';
import 'package:wcas_frontend/models/request/request.dart';

import 'model.dart';
import 'state.dart';

class ViewDesktop extends StatelessWidget {
  const ViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    CreateSecurityViewModel viewModel = context.read<CreateSecurityViewModel>();
    return BlocBuilder<CreateSecurityViewModel, CreateSecurityState>(
        builder: (context, state) {
      return Layout(
        child: _body(context, state, viewModel),
      );
    });
  }

  Widget _body(BuildContext context, CreateSecurityState state,
      CreateSecurityViewModel viewModel) {
    switch (state.loaderStatus) {
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.empty:
        return Center(
          child: Text('common.emptyState'.tr()),
        );
      case LoadingStatus.error:
        return Center(
          child: Text('common.emptyState'.tr()),
        );
      default:
        return _buildView(context, state, viewModel);
    }
  }

  Widget _buildView(BuildContext context, CreateSecurityState state,
      CreateSecurityViewModel viewModel) {
    return SingleChildScrollView(
      child: BoxLayout(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              CustomSectionHeader(title: "createSecurity.title".tr()),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.tableBorderColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(spacing: 10, children: [
                      SectionBackground(
                        child: TopSectionDetails(
                          request: Request(
                            groupName: Globals.request?.groupName ?? "",
                            customerName: Globals.request?.customerName ?? "",
                            applicationType: Globals.request?.applicationType,
                            requestType: Globals.request?.requestType,
                          ),
                        ),
                      ),
                      if (!viewModel.isSecurityDescriptionSelected)
                        SectionBackground(
                            child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Row(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                          SecurityGroup(viewModel: viewModel),
                                    ),
                                    viewModel.isSecurityGroupSelected
                                        ? Expanded(
                                            flex: 1,
                                            child: SecurityDescription(
                                                viewModel: viewModel,
                                                isDropDown: true),
                                          )
                                        : const SizedBox.shrink(),
                                    const Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 5,
                                        ))
                                  ])
                            ])),
                      viewModel.isSecurityDescriptionSelected
                          ? SectionBackground(
                              child: Column(
                                  spacing: 15,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SecurityDescription(
                                            viewModel: viewModel,
                                            isDropDown: false,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SecurityCode(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SecurityNumber(
                                              viewModel: viewModel),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: TangibleSecurity(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: LimitControllingSecurity(
                                              viewModel: viewModel),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: PresentSecurityAmount(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ProposedSecurityAmount(
                                              viewModel: viewModel),
                                        ),
                                        const Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 5,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: IsSecurityProviderCbdCustomer(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IsSecurityExpiryOpenEnded(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SecurityExpireDate(
                                              viewModel: viewModel),
                                        )
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SecurityProviderRimNumber(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SecurityProviderName(
                                              viewModel: viewModel),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: CountryOfIncorporation(
                                              viewModel: viewModel),
                                        )
                                      ],
                                    ),
                                    Row(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              spacing: 10,
                                              children: [
                                                SecurityHeldBy(
                                                    viewModel: viewModel),
                                                SecurityStatus(
                                                    viewModel: viewModel)
                                              ],
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Remarks(viewModel: viewModel),
                                        ),
                                      ],
                                    ),
                                    Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: ActionWidgets(
                                          viewModel: viewModel,
                                        ))
                                  ]),
                            )
                          : const SizedBox.shrink(),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
