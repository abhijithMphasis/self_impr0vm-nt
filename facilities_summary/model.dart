import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/utils/alert_manager.dart';
import 'package:wcas_frontend/core/utils/logger.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/models/admin/reference.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';
import 'package:wcas_frontend/repositories/facility_security_repository.dart';
import 'package:wcas_frontend/repositories/request_repository.dart';
import 'state.dart';

class FacilitiesSummaryViewModel extends Cubit<FacilitiesSummaryState> {
  FacilitiesSummaryViewModel()
      : super(FacilitiesSummaryState(loaderStatus: LoadingStatus.loading));
  late RequestRepository repository;

  List<CustomerFacility>? customerFacilities = [];
  List<Reference> currencyCodes = [];

  void init(context) async {
    logger.i('initialising FacilitiesSummaryViewModel');
    repository = RequestRepository.instance;

    await Future.wait([
      getCurrencyCodes(),
      getFacilitySummaryList(),
    ]);
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  Future<void> getFacilitySummaryList() async {
    try {
      customerFacilities =
          await FacilitySecurityRepository.instance.getFacilitySummaryList();
    } catch (error) {
      AlertManager().showFailureToast(error.toString());
    }
  }

  Future<void> getCurrencyCodes() async {
    try {
      currencyCodes = await repository.getCurrencyCodes();
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
  }

  Future<void> saveFacilityDetails(CustomerFacility customerFacility) async {
    emit(state.copyWith(loaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance.saveFacilityDetails(customerFacility);
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  Future<void> deleteFacilityDetails({
    required Facility facility,
    required FacilityGroup facilityGroup,
  }) async {
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance.deleteFacilityDetails(
        serialNumber: facility.sNo,
        typeID: facilityGroup.typeId,
      );
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loaded));
  }

  Future<void> saveFacilitySubLimit(CustomerFacility customerFacility, Facility facility) async {
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance.saveFacilitySubLimit(
        rimNo: customerFacility.rimNo,
        limitDescriptionID: customerFacility.generalWorkingCapitalLimits?.typeId,
        limitCategory: facility.facilityDetails,
      );
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loaded));
  }
}
