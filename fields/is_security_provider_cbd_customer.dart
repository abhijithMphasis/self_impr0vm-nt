import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/radiobutton.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class IsSecurityProviderCbdCustomer extends StatefulWidget {
  final CreateSecurityViewModel viewModel;
  const IsSecurityProviderCbdCustomer({super.key, required this.viewModel});

  @override
  State<IsSecurityProviderCbdCustomer> createState() =>
      _IsSecurityProviderCbdCustomerState();
}

class _IsSecurityProviderCbdCustomerState
    extends State<IsSecurityProviderCbdCustomer> {
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.isSecurityProviderCbdCustomer'.tr(),
      isRequired: true,
      showLabel: true,
      child: CustomRadioButton(
        validator: (value) {
          if (widget.viewModel.isSecurityProviderCbdCustomer
              .contains(value?.trim())) {
            return null;
          }
          return "createSecurity.isSecurityProviderCbdCustomer".tr();
        },
        options: widget.viewModel.isSecurityProviderCbdCustomer,
        selectedValue:
            widget.viewModel.selectedIsSecurityProviderCbdCustomerValue,
        onChanged: (value) {
          setState(() {
            widget.viewModel.selectedIsSecurityProviderCbdCustomerValue = value;
          });
        },
        selectedColor: AppColors.primary,
        unselectedColor: AppColors.tableBorderColor,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
