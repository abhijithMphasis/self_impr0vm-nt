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

  List<Reference> selectedSecurityDescriptions = [];

  List<Reference> securityReferenceData = [];
  List<Reference> securityHeldAsList = [];
  List<Reference> securityStatusList = [];
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
        ReferenceDataKeys.securityStatus,
        ReferenceDataKeys.securityHeldAs
      ]);
      securityReferenceData =
          referenceData[ReferenceDataKeys.securityType] ?? [];
      securityHeldAsList =
          referenceData[ReferenceDataKeys.securityHeldAs] ?? [];
      securityStatusList =
          referenceData[ReferenceDataKeys.securityStatus] ?? [];
      emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
    } catch (e) {
      emit(state.copyWith(loaderStatus: LoadingStatus.error));
    }
  }

  void securityGroupSelected(Reference selectedGroup) {
    isSecurityGroupSelected = true;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  bool isSecurityDescriptionSelected = false;
  void securityDescriptionsSelected(Reference selected) {
    securityDescriptionsValue = selected;
    securityDescription = selected.name;
    securityCode = selected.reference3;
    isSecurityDescriptionSelected = true;
    securityNumber = "891274"; //TODO need to provide actual code
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
