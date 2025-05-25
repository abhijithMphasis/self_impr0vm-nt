import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/utils/alert_manager.dart';
import 'package:wcas_frontend/core/utils/logger.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/models/admin/reference.dart';
import 'package:wcas_frontend/models/request/facility_security/security.dart';
import 'package:wcas_frontend/repositories/request_repository.dart';

import 'state.dart';

class LinkedFacilitiesDialogViewModel
    extends Cubit<LinkedFacilitiesDialogState> {
  LinkedFacilitiesDialogViewModel()
      : super(
            LinkedFacilitiesDialogState(loaderStatus: LoadingStatus.loading)) {
    yesOption = Reference(name: "Yes");
    noOption = Reference(name: "No");
    selectedFacilityOption = yesOption;
    linkFacilityOptions = [yesOption, noOption];
  }

  late Reference yesOption;
  late Reference noOption;
  bool selectToLinkFacility = true;
  late RequestRepository repository;
  List<SecuritySummary>? facilitiesList = [];
  List<Reference> linkFacilityOptions = [];
  Reference selectedFacilityOption = Reference(name: "Yes");
  void init(context) async {
    logger.i('initialising LinkedFacilitiesDialogViewModel');
    repository = RequestRepository.instance;
    getFacilitiesList("202502APNIS027140");
  }

  Future<void> getFacilitiesList(String appReffNo) async {
    try {
      facilitiesList = await repository.getFacilitiesSummaryList(appReffNo);
      emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
      emit(state.copyWith(loaderStatus: LoadingStatus.error));
    }
  }

  Future<void> saveFacilitySecurityLinkDetails() async {
    try {
      await repository.saveFacilitySecurityLinkDetails();
      emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
      emit(state.copyWith(loaderStatus: LoadingStatus.error));
    }
  }

  void selectOptions(Reference selectedOption) {
    selectedFacilityOption = selectedOption;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  void selectLinkFacility(bool value) {
    selectToLinkFacility = value;
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }
}
