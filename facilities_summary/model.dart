import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcas_frontend/core/constants/_reference_data_keys.dart';
import 'package:wcas_frontend/core/services/reference_data_service.dart';
import 'package:wcas_frontend/core/utils/alert_manager.dart';
import 'package:wcas_frontend/core/utils/logger.dart';
import 'package:wcas_frontend/core/utils/utils.dart';
import 'package:wcas_frontend/models/admin/reference.dart';
import 'package:wcas_frontend/models/request/facility_security/facility.dart';
import 'package:wcas_frontend/models/request/facility_security/facility_summary.dart';
import 'package:wcas_frontend/repositories/facility_security_repository.dart';
import 'package:wcas_frontend/repositories/request_repository.dart';
import 'state.dart';

/// to fetch, save, and delete facility data, and emits state changes
/// to update the UI accordingly.
class FacilitiesSummaryViewModel extends Cubit<FacilitiesSummaryState> {
  FacilitiesSummaryViewModel()
      : super(FacilitiesSummaryState(loaderStatus: LoadingStatus.loading));

  /// Repository instance used for fetching and saving data.
  late RequestRepository repository;

  /// List of customer facilities retrieved from the backend.
  List<CustomerFacility>? customerFacilities = [];

  /// List of available currency codes.
  List<Reference> currencyCodes = [];

  /// List of facility limit types.
  List<Reference> limitTypes = [];

  /// List of sub-limit types.
  List<Reference> subLimitTypes = [];

  /// Initializes the ViewModel by setting up the repository and fetching
  /// currency codes, facility summaries, and reference data.

  void init(context) async {
    logger.i('initialising FacilitiesSummaryViewModel');
    repository = RequestRepository.instance;

    await Future.wait([
      getCurrencyCodes(),
      getFacilitySummaryList(),
      getReferenceData(),
    ]);
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  /// Fetches the list of customer facilities from the FacilitySecurityRepository.

  Future<void> getFacilitySummaryList() async {
    try {
      customerFacilities =
          await FacilitySecurityRepository.instance.getFacilitySummaryList();
    } catch (error) {
      AlertManager().showFailureToast(error.toString());
    }
  }

  /// Retrieves reference data for facility types and advance types.
  /// Populates the `limitTypes` and `subLimitTypes` lists.

  Future<void> getReferenceData() async {
    try {
      Map<String, List<Reference>> referenceData =
          await ReferenceDataService().getReferenceData([
        ReferenceDataKeys.facilityType,
        ReferenceDataKeys.advanceType,
      ]);
      limitTypes = referenceData[ReferenceDataKeys.facilityType] ?? [];
      subLimitTypes = referenceData[ReferenceDataKeys.advanceType] ?? [];
    } catch (error) {
      AlertManager().showFailureToast(error.toString());
    }
  }

  /// Fetches the list of currency codes from the repository.

  Future<void> getCurrencyCodes() async {
    try {
      currencyCodes = await repository.getCurrencyCodes();
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
  }

  /// Saves the details of a given customer facility.

  Future<void> saveFacilityDetails(CustomerFacility customerFacility) async {
    emit(state.copyWith(loaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance
          .saveFacilityDetails(customerFacility);
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(loaderStatus: LoadingStatus.loaded));
  }

  /// Deletes facility details based on the provided serial number and type ID.
  /// Emits loading and loaded states for the table loader.

  Future<void> deleteFacilityDetails({int? serialNumber, int? typeID}) async {
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance
          .deleteFacilityDetails(serialNumber: serialNumber, typeID: typeID);
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loaded));
  }

  /// Saves the sub-limit details for a given facility and facility group.
  /// Emits loading and loaded states for the table loader.

  Future<void> saveFacilitySubLimit({
    required FacilityGroup? facilityGroup,
    required Facility? facility,
  }) async {
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loading));
    try {
      await FacilitySecurityRepository.instance.saveFacilitySubLimit(
        rimNo: facility?.rimNo,
        limitDescriptionID: facilityGroup?.typeId,
        limitCategory: facility?.facilityDetails,
      );
    } catch (e) {
      AlertManager().showFailureToast(e.toString());
    }
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loaded));
  }

  void addFacility({FacilityGroup? group, Facility? facility}) {
    group?.facilities ??= [];
    group?.facilities?.add(facility!);
    emit(state.copyWith(tableLoaderStatus: LoadingStatus.loaded));
  }
}
