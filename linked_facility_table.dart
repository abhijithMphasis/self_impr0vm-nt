import 'package:flutter/material.dart';
import 'package:wcas_frontend/core/components/checkbox.dart';
import 'package:wcas_frontend/core/components/custom_table/table.dart';
import 'package:wcas_frontend/core/components/selectable_text.dart';
import 'package:wcas_frontend/core/components/textfield.dart';
import 'package:wcas_frontend/features/request/facilities_securities/linked_facilities_dialog/model.dart';
import 'package:wcas_frontend/models/request/facility_security/security.dart';

class LinkedFacilityTable extends StatelessWidget {
  const LinkedFacilityTable({super.key, required this.viewModel});
  final LinkedFacilitiesDialogViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return CustomRawTable(
      columns: getColumns(),
      showPagination: true,
      rowsPerPage: 5,
      rows: buildRows(),
    );
  }

  List<List<Widget>> buildRows() {
    final List<SecuritySummary>? facilitySummaryList = viewModel.facilitiesList;
    final filerRow = <Widget>[
      const SizedBox.shrink(),
      _filterField(""),
      _filterField(""),
      _filterField(""),
      _filterField(""),
      const SizedBox.shrink(),
    ];
    List<List<Widget>> dataRows =
        List.generate(facilitySummaryList?.length ?? 0, (index) {
      return [
        (viewModel.selectedFacilityOption.name == viewModel.noOption.name)
            ? CustomCheckbox(
                value: viewModel.selectToLinkFacility,
                onChange: (value) =>
                    viewModel.selectLinkFacility(value ?? false),
              )
            : const SizedBox.shrink(),
        CustomSelectableText(
            text: facilitySummaryList?[index].rimNo.toString()),
        CustomSelectableText(text: facilitySummaryList?[index].limitNumber),
        CustomSelectableText(text: facilitySummaryList?[index].limitLabel),
        CustomSelectableText(text: facilitySummaryList?[index].limitLabel),
        CustomSelectableText(
            text: facilitySummaryList?[index].proposedLimit.toString()),
      ];
    });

    return [
      filerRow,
      ...dataRows,
    ];
  }

  Widget _filterField(String? text) {
    return SizedBox(
      child: CustomTextField(
        initialValue: text,
        onSubmitted: (String value) {},
      ),
    );
  }

  List<TableColumn> getColumns() {
    return [
      (viewModel.selectedFacilityOption.name == viewModel.noOption.name)
          ? TableColumn(
              label: CustomCheckbox(
                  value: viewModel.selectToLinkFacility,
                  onChange: (value) =>
                      viewModel.selectLinkFacility(value ?? false)),
            )
          : const TableColumn(label: SizedBox.shrink()),
      const TableColumn(label: Text("RIM No")),
      const TableColumn(label: Text("Limit Number")),
      const TableColumn(label: Text("Project Name")),
      const TableColumn(label: Text("Limit Description")),
      const TableColumn(label: Text("Proposed Limit")),
    ];
  }
}
