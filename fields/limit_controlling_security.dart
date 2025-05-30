import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/radiobutton.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class LimitControllingSecurity extends StatefulWidget {
  final CreateSecurityViewModel viewModel;
  const LimitControllingSecurity({super.key, required this.viewModel});

  @override
  State<LimitControllingSecurity> createState() => _LimitControllingSecurityState();
}

class _LimitControllingSecurityState extends State<LimitControllingSecurity> {
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.limitControllingSecurity'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomRadioButton(
        validator: (value) {
          if (widget.viewModel.limitControllingSecurity.contains(value?.trim())) {
            return null;
          }
          return "createSecurity.selectLimitControllingSecurity".tr();
        },
        options: widget.viewModel.limitControllingSecurity,
        selectedValue: widget.viewModel.selectedLimitControllingSecurityValue,
        onChanged: (value) {
          setState(() {
            widget.viewModel.selectedLimitControllingSecurityValue = value;
          });
        },
        selectedColor: AppColors.primary,
        unselectedColor: AppColors.tableBorderColor,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
