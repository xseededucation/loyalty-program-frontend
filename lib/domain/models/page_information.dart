class PageInformationModel {
  String? status;
  Data? data;

  PageInformationModel({this.status, this.data});

  PageInformationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ConversionRates>? conversionRates;
  int? currentCredit;
  List<EventToCreditMap>? eventToCreditMap;
  List<PageDetails>? pageDetails;

  Data(
      {this.conversionRates,
      this.currentCredit,
      this.eventToCreditMap,
      this.pageDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['conversionRates'] != null) {
      conversionRates = <ConversionRates>[];
      json['conversionRates'].forEach((v) {
        conversionRates!.add(ConversionRates.fromJson(v));
      });
    }
    currentCredit = json['currentCredit'];
    if (json['eventToCreditMap'] != null) {
      eventToCreditMap = <EventToCreditMap>[];
      json['eventToCreditMap'].forEach((v) {
        eventToCreditMap!.add(EventToCreditMap.fromJson(v));
      });
    }
    if (json['pageDetails'] != null) {
      pageDetails = <PageDetails>[];
      json['pageDetails'].forEach((v) {
        pageDetails!.add(PageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversionRates != null) {
      data['conversionRates'] =
          conversionRates!.map((v) => v.toJson()).toList();
    }
    data['currentCredit'] = currentCredit;
    if (eventToCreditMap != null) {
      data['eventToCreditMap'] =
          eventToCreditMap!.map((v) => v.toJson()).toList();
    }
    if (pageDetails != null) {
      data['pageDetails'] = pageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversionRates {
  int? credit;
  int? denomination;

  ConversionRates({this.credit, this.denomination});

  ConversionRates.fromJson(Map<String, dynamic> json) {
    credit = json['credit'];
    denomination = json['denomination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit'] = credit;
    data['denomination'] = denomination;
    return data;
  }
}

class EventToCreditMap {
  String? event;
  int? creditGiven;
  int? timeInMins;

  EventToCreditMap({this.event, this.creditGiven, this.timeInMins});

  EventToCreditMap.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    creditGiven = json['creditGiven'];
    timeInMins = json['timeInMins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event'] = event;
    data['creditGiven'] = creditGiven;
    data['timeInMins'] = timeInMins;
    return data;
  }
}

class PageDetails {
  String? text;
  String? entityType;

  PageDetails({this.text, this.entityType});

  PageDetails.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    entityType = json['entityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['entityType'] = entityType;
    return data;
  }
}
