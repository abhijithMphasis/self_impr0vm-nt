import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/components/button.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/radiobutton.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/core/utils/validators.dart';
import 'package:wcas_frontend/features/request/facilities_securities/linked_facilities_dialog/model.dart';
import 'package:wcas_frontend/features/request/facilities_securities/linked_facilities_dialog/widget/linked_facility_table.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

import 'state.dart';

class ViewDesktop extends StatelessWidget {
  const ViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    LinkedFacilitiesDialogViewModel viewModel =
        context.read<LinkedFacilitiesDialogViewModel>();
    return BlocBuilder<LinkedFacilitiesDialogViewModel,
        LinkedFacilitiesDialogState>(builder: (context, state) {
      return _body(context, state, viewModel);
    });
  }

  Widget _body(BuildContext context, LinkedFacilitiesDialogState state,
      LinkedFacilitiesDialogViewModel viewModel) {
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

  Widget buildView(LinkedFacilitiesDialogViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          LabelWidget(
              label: "Link to all Facilities",
              child: CustomRadioButton<Reference>(
                options: viewModel.linkFacilityOptions,
                selectedValue: viewModel.selectedFacilityOption,
                onChanged: viewModel.selectOptions,
                itemBuilder: (context, item, isSelected, isEnabled) =>
                    Text(item.name ?? ''),
                validator: (value) =>
                    CustomValidator.requiredField(value?.name ?? ""),
                isRequired: true,
                scrollDirection: Axis.horizontal,
                textStyle: const TextStyle(fontSize: 12),
              )),
          const Align(
            alignment: Alignment.centerRight,
            child: SelectableText(
              "AED 000's",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          LinkedFacilityTable(
            viewModel: viewModel,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
                label: "Save",
                onPressed: () {
                  viewModel.saveFacilitySecurityLinkDetails();
                }),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
