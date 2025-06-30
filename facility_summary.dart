import 'package:wcas_frontend/models/admin/reference.dart';

class CustomerFacility {
  // TODO need better name for model class
  int? rimNo;
  String? custName;
  GeneralWorkingCapitalLimits? generalWorkingCapitalLimits;
  Loans? loans;
  PPELimits? ppeLimits;
  ProjectStandbyLimits? projectStandbyLimits;
  ProjectSpecificLimit? projectSpecificLimit;
  OverallTotal? overallTotal;

  CustomerFacility(
      {this.rimNo,
      this.custName,
      this.generalWorkingCapitalLimits,
      this.loans,
      this.ppeLimits,
      this.projectStandbyLimits,
      this.projectSpecificLimit,
      this.overallTotal});

  CustomerFacility.fromJson(Map<String, dynamic> json) {
    rimNo = json['rim_no'];
    custName = json['cust_name'];
    generalWorkingCapitalLimits = json['General_Working_Capital_Limits'] != null
        ? GeneralWorkingCapitalLimits.fromJson(
            json['General_Working_Capital_Limits'])
        : null;
    loans = json['Loans'] != null ? Loans.fromJson(json['Loans']) : null;
    ppeLimits = json['PPE_Limits'] != null
        ? PPELimits.fromJson(json['PPE_Limits'])
        : null;
    projectStandbyLimits = json['Project_Standby_Limits'] != null
        ? ProjectStandbyLimits.fromJson(json['Project_Standby_Limits'])
        : null;
    projectSpecificLimit = json['Project_Specific_Limit'] != null
        ? ProjectSpecificLimit.fromJson(json['Project_Specific_Limit'])
        : null;
    overallTotal = json['overallTotal'] != null
        ? OverallTotal.fromJson(json['overallTotal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rim_no'] = rimNo;
    data['cust_name'] = custName;
    if (generalWorkingCapitalLimits != null) {
      data['General_Working_Capital_Limits'] =
          generalWorkingCapitalLimits!.toJson();
    }
    if (loans != null) {
      data['Loans'] = loans!.toJson();
    }
    if (ppeLimits != null) {
      data['PPE_Limits'] = ppeLimits!.toJson();
    }
    if (projectStandbyLimits != null) {
      data['Project_Standby_Limits'] = projectStandbyLimits!.toJson();
    }
    if (projectSpecificLimit != null) {
      data['Project_Specific_Limit'] = projectSpecificLimit!.toJson();
    }
    if (overallTotal != null) {
      data['overallTotal'] = overallTotal!.toJson();
    }
    return data;
  }
}

class GeneralWorkingCapitalLimits {
  int? totalWorkingCapitalLimits;
  List<Facilities>? facilities;
  int? typeId;
  GeneralWorkingCapitalLimits(
      {this.totalWorkingCapitalLimits, this.facilities, this.typeId});

  GeneralWorkingCapitalLimits.fromJson(Map<String, dynamic> json) {
    totalWorkingCapitalLimits = json['total_working_capital_limits'];
    typeId = json['type_id'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_working_capital_limits'] = totalWorkingCapitalLimits;
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Facilities {
  // TODO can be reuse the class and remove this duplication
  int? sNo;
  String? facilityDetails;
  String? subFacilityDetails;
  List<Reference>? sustainabilityClassification;
  int? existingLimits;
  int? proposedLimits;
  int? outstanding;
  int? tenorDays;
  String? applicablePricing;
  String? margin;

  Facilities(
      {this.sNo,
      this.facilityDetails,
      this.subFacilityDetails,
      this.sustainabilityClassification,
      this.existingLimits,
      this.proposedLimits,
      this.outstanding,
      this.tenorDays,
      this.applicablePricing,
      this.margin});

  Facilities.fromJson(Map<String, dynamic> json) {
    sNo = json['S_No'];
    facilityDetails = json['Facility_Details'];
    subFacilityDetails = json['Sub_Facility_Details'];

    // Convert List<String> to List<Reference>
    if (json['Sustainability_Classification'] != null) {
      sustainabilityClassification =
          (json['Sustainability_Classification'] as List)
              .map((e) => Reference(name: e.toString()))
              .toList();
    }

    existingLimits = json['Existing_Limits'];
    proposedLimits = json['Proposed_Limits'];
    outstanding = json['Outstanding'];
    tenorDays = json['Tenor_Days'];
    applicablePricing = json['Applicable_Pricing'];
    margin = json['Margin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['S_No'] = sNo;
    data['Facility_Details'] = facilityDetails;
    data['Sub_Facility_Details'] = subFacilityDetails;
    data['Sustainability_Classification'] = sustainabilityClassification;
    data['Existing_Limits'] = existingLimits;
    data['Proposed_Limits'] = proposedLimits;
    data['Outstanding'] = outstanding;
    data['Tenor_Days'] = tenorDays;
    data['Applicable_Pricing'] = applicablePricing;
    data['Margin'] = margin;
    return data;
  }
}

class Loans {
  int? totalLoans;
  int? typeId;
  List<Facilities>? facilities;
  Loans({this.totalLoans, this.facilities, this.typeId});
  Loans.fromJson(Map<String, dynamic> json) {
    totalLoans = json['total_loans'];
    typeId = json['type_id'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_loans'] = totalLoans;
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PPELimits {
  int? totalPpeLimits;
  List<Facilities>? facilities;
  int? typeID;
  PPELimits({this.totalPpeLimits, this.facilities, this.typeID});

  PPELimits.fromJson(Map<String, dynamic> json) {
    totalPpeLimits = json['total_ppe_limits'];
    typeID = json['type_id'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_ppe_limits'] = totalPpeLimits;
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectStandbyLimits {
  Project? project;
  List<Facilities>? facilities;
  int? typeId;
  ProjectStandbyLimits({this.project, this.facilities, this.typeId});

  ProjectStandbyLimits.fromJson(Map<String, dynamic> json) {
    project =
        json['Project'] != null ? Project.fromJson(json['Project']) : null;
    typeId = json['type_id'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (project != null) {
      data['Project'] = project!.toJson();
    }
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  String? projectName;
  int? totalProjectStandbyLimits;
  List<Facilities>? facilities;

  Project({this.projectName, this.totalProjectStandbyLimits, this.facilities});

  Project.fromJson(Map<String, dynamic> json) {
    projectName = json['project_name'];
    totalProjectStandbyLimits = json['total_project_standby_limits'];
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_name'] = projectName;
    data['total_project_standby_limits'] = totalProjectStandbyLimits;
    if (facilities != null) {
      data['facilities'] = facilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectSpecificLimit {
  Project? project;
  int? typeId;
  ProjectSpecificLimit({this.project, this.typeId});

  ProjectSpecificLimit.fromJson(Map<String, dynamic> json) {
    project =
        json['Project'] != null ? Project.fromJson(json['Project']) : null;
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (project != null) {
      data['Project'] = project!.toJson();
    }
    return data;
  }
}

class OverallTotal {
  String? title;
  List<Limits>? limits;

  OverallTotal({this.title, this.limits});

  OverallTotal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['limits'] != null) {
      limits = <Limits>[];
      json['limits'].forEach((v) {
        limits!.add(Limits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (limits != null) {
      data['limits'] = limits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Limits {
  String? description;
  int? existingLimit;
  int? proposedLimit;
  String? remark;

  Limits(
      {this.description, this.existingLimit, this.proposedLimit, this.remark});

  Limits.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    existingLimit = json['existingLimit'];
    proposedLimit = json['proposedLimit'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['existingLimit'] = existingLimit;
    data['proposedLimit'] = proposedLimit;
    data['remark'] = remark;
    return data;
  }
}
