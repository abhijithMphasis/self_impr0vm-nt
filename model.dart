import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/constants/_reference_data_keys.dart';
import 'package:wcas_frontend/core/services/reference_data_service.dart';
import 'package:wcas_frontend/core/utils/logger.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/models/admin/reference.dart';

import 'package:wcas_frontend/repositories/request_repository.dart';
import 'state.dart';

enum TangibleSecurities { yes, no }

enum LimitControllingSecurities { yes, no }

enum IsSecurityProviderCbdCustomers { yes, no }

enum IsSecurityExpiryOpenEndeds { yes, no }

class CreateSecurityViewModel extends Cubit<CreateSecurityState> {
  CreateSecurityViewModel()
      : super(CreateSecurityState(loaderStatus: LoadingStatus.loading));
  late RequestRepository repository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? securityCode,
      securityNumber,
      presentSecurityAmount,
      proposedSecurityAmount,
      securityExpireDate,
      securityProviderRimNo,
      securityProviderName,
      countryOfIncorporation,
      remarks,
      securityDescription;
  Reference? securityGroupValue,
      securityDescriptionsValue,
      presentSecurityAmountValue,
      proposedSecurityAmountValue,
      securityHeldByValue,
      securitStatusValue;
  bool isSecurityGroupSelected = false;
  List<Reference> proposedSecurityAmountItems = [Reference(name: "AED")];
  List<Reference> presentSecurityAmountItems = [Reference(name: "AED")];
  List<Reference> securityHeldByItems = [Reference(name: "AED")];
  List<Reference> securityStatusItems = [Reference(name: "Held")];

  String selectedTangibleSecurityValue = TangibleSecurities.no.name;
  List<String> tangibleSecurity = [
    TangibleSecurities.yes.name,
    TangibleSecurities.no.name
  ];

  String selectedLimitControllingSecurityValue =
      LimitControllingSecurities.no.name;
  List<String> limitControllingSecurity = [
    LimitControllingSecurities.yes.name,
    LimitControllingSecurities.no.name
  ];

  String selectedIsSecurityProviderCbdCustomerValue =
      IsSecurityProviderCbdCustomers.no.name;
  List<String> isSecurityProviderCbdCustomer = [
    IsSecurityProviderCbdCustomers.yes.name,
    IsSecurityProviderCbdCustomers.no.name
  ];

  String selectedIsSecurityExpiryOpenEndedValue =
      IsSecurityExpiryOpenEndeds.no.name;
  List<String> isSecurityExpiryOpenEnded = [
    IsSecurityExpiryOpenEndeds.yes.name,
    IsSecurityExpiryOpenEndeds.no.name
  ];

  List<Reference> securityDescriptionPropertyItems = [
    Reference(name: 'Assignment of Insurance')
  ];

  List<Reference> securityDescriptionInsuranceItems = [
    Reference(name: 'Notarised Commercial Mortgage'),
    Reference(name: 'Assignment of leasehold - Musataha'),
    Reference(name: 'Conditional assignment of SPA'),
    Reference(name: 'Hold on title deeds'),
    Reference(name: 'Mortgage of Properties'),
    Reference(name: 'Mortgage of Leasehold - Mustaha'),
    Reference(name: 'Mortgage with free zone authorities')
  ];

  List<Reference> securityDescriptionGuaranteeItems = [
    Reference(name: 'Personal Guarantee'),
    Reference(name: 'Bank Guarantee'),
    Reference(name: 'Corporate Guarantee')
  ];

  List<Reference> securityDescriptionReceivablesItems = [
    Reference(name: 'Assignement of receivables'),
    Reference(name: 'Security Cheque')
  ];

  List<Reference> securityDescriptionDepositeItems = [
    Reference(name: 'Pledge of Account'),
    Reference(name: 'Pledge of TD')
  ];

  List<Reference> securityDescriptionSharesItems = [
    Reference(name: 'Charge over CBDFS Portfolio'),
    Reference(name: 'Pledge of bonds'),
    Reference(name: 'Pledge of Investment products'),
    Reference(name: 'Pledge of JSC Shares'),
    Reference(name: 'Pledge of LLC')
  ];

  List<Reference> securityDescriptionCommoditiesItems = [
    Reference(name: 'Pledge of commodities'),
    Reference(name: 'Pledge of precious metals')
  ];

  List<Reference> securityDescriptionMovableAssetsItems = [
    Reference(name: 'Mortgage of Aircraft'),
    Reference(name: 'Pledge of Movable assets'),
    Reference(name: 'Mortgage of Vehicles'),
    Reference(name: 'Mortgage of Vessel')
  ];

  List<Reference> securityDescriptionFixedAssetsItems = [
    Reference(name: 'Pledge of Plant & Machinery/Fixed Assets')
  ];

  List<Reference> selectedSecurityDescriptions = [];

  List<Reference> securityReferenceData = [];

  void init(context) async {
    logger.i('initialising CreateSecurityViewModel');
    repository = RequestRepository.instance;
    await getReferenceDatas();
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  Future<void> getReferenceDatas() async {
    try {
      Map<String, List<Reference>> referenceData =
          await ReferenceDataService().getReferenceData([
        ReferenceDataKeys.securityType,
      ]);
      securityReferenceData =
          referenceData[ReferenceDataKeys.securityType] ?? [];

      emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
    } catch (e) {
      emit(state.copyWith(loaderStatus: LoadingStatus.error));
    }
  }

  void securityGroupSelected(Reference selectedGroup) {
    switch (selectedGroup.name) {
      case 'Insurance':
        selectedSecurityDescriptions = securityDescriptionInsuranceItems;
        break;
      case 'Property':
        selectedSecurityDescriptions = securityDescriptionPropertyItems;
        break;
      case 'Guarantee':
        selectedSecurityDescriptions = securityDescriptionGuaranteeItems;
        break;
      case 'Receivables':
        selectedSecurityDescriptions = securityDescriptionReceivablesItems;
        break;
      case 'Deposit':
        selectedSecurityDescriptions = securityDescriptionDepositeItems;
        break;
      case 'Shares':
        selectedSecurityDescriptions = securityDescriptionSharesItems;
        break;
      case 'Commodities':
        selectedSecurityDescriptions = securityDescriptionCommoditiesItems;
        break;
      case 'Movable Assets':
        selectedSecurityDescriptions = securityDescriptionMovableAssetsItems;
        break;
      case 'Fixed Assets':
        selectedSecurityDescriptions = securityDescriptionFixedAssetsItems;
        break;
      default:
        selectedSecurityDescriptions = [];
    }
    isSecurityGroupSelected = true;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
    // Now you can use `selectedDescriptions` to populate the second dropdown
    // For example, setState(() => _secondDropdownItems = selectedDescriptions);
  }

  bool isSecurityDescriptionSelected = false;
  void securityDescriptionsSelected(Reference selected) {
    securityDescriptionsValue = selected;
    securityDescription = selected.name;
    isSecurityDescriptionSelected = true;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void presentSecurityAmountSelected(Reference selected) {
    presentSecurityAmountValue = selected;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void proposedSecurityAmountSelected(Reference selected) {
    proposedSecurityAmountValue = selected;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void securityHeldBySelected(Reference selected) {
    securityHeldByValue = selected;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void securitStatusSelected(Reference selected) {
    securitStatusValue = selected;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void onPressedSearchSecurityRimNo() {}

  void onPressedEditSecurityRimNo() {}

  void onSaveButtonPress() {}

  void onSaveContinueButtonPress() {}

  void onCancelButtonPress() {}
}
