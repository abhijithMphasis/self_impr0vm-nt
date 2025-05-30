import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/label.dart';
import 'package:wcas_frontend/core/components/radiobutton.dart';
import 'package:wcas_frontend/core/constants/constants.dart';
import 'package:wcas_frontend/features/request/facilities_securities/create_security/model.dart';

class TangibleSecurity extends StatefulWidget {
  final CreateSecurityViewModel viewModel;
  const TangibleSecurity({super.key, required this.viewModel});

  @override
  State<TangibleSecurity> createState() => _TangibleSecurityState();
}

class _TangibleSecurityState extends State<TangibleSecurity> {
  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: 'createSecurity.tangibleSecurity'.tr(),
      isRequired: false,
      showLabel: true,
      child: CustomRadioButton(
        validator: (value) {
          if (widget.viewModel.tangibleSecurity.contains(value?.trim())) {
            return null;
          }
          return "createSecurity.selectTangibleSecurity".tr();
        },
        options: widget.viewModel.tangibleSecurity,
        selectedValue: widget.viewModel.selectedTangibleSecurityValue,
        onChanged: (value) {
          setState(() {
            widget.viewModel.selectedTangibleSecurityValue = value;
          });
        },
        selectedColor: AppColors.primary,
        unselectedColor: AppColors.tableBorderColor,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
