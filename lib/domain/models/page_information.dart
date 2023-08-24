import 'dart:io';

class PageInformation {
  List<ConversionRates>? conversionRates;
  int? currentCredit;
  List<EventToCreditMap>? eventToCreditMap;
  List<PageDetail>? pageDetails;

  PageInformation(
      {this.conversionRates,
      this.currentCredit,
      this.eventToCreditMap,
      this.pageDetails});

  PageInformation.fromJson(Map<String, dynamic> json) {
    if (json['conversionRates'] != null) {
      conversionRates = <ConversionRates>[];
      json['conversionRates'].forEach((v) {
        conversionRates!.add(new ConversionRates.fromJson(v));
      });
    }
    currentCredit = json['currentCredit'];
    if (json['eventToCreditMap'] != null) {
      eventToCreditMap = <EventToCreditMap>[];
      json['eventToCreditMap'].forEach((v) {
        eventToCreditMap!.add(new EventToCreditMap.fromJson(v));
      });
    }
    if (json['pageDetails'] != null) {
      pageDetails = <PageDetail>[];
      json['pageDetails'].forEach((v) {
        pageDetails!.add(PageContext().fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversionRates != null) {
      data['conversionRates'] =
          this.conversionRates!.map((v) => v.toJson()).toList();
    }
    data['currentCredit'] = this.currentCredit;
    if (this.eventToCreditMap != null) {
      data['eventToCreditMap'] =
          this.eventToCreditMap!.map((v) => v.toJson()).toList();
    }
    if (this.pageDetails != null) {
      data['pageDetails'] = this.pageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversionRates {
  int? credit;
  int? denomination;
  int? sequenceNo;
  String? toolTipText;

  ConversionRates({this.credit, this.denomination});

  ConversionRates.fromJson(Map<String, dynamic> json) {
    credit = json['credit'];
    denomination = json['denomination'];
    sequenceNo = json['sequenceNo'];
    toolTipText = json['toolTipText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit'] = this.credit;
    data['denomination'] = this.denomination;
    data['sequenceNo'] = this.sequenceNo;
    data['toolTipText'] = this.toolTipText;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['creditGiven'] = this.creditGiven;
    data['timeInMins'] = this.timeInMins;
    return data;
  }
}

abstract class PageDetail {
  Map<String, dynamic> toJson();
}

final Map<String, dynamic> entityToClassMap = {
  "EarnMore": EarnMoreCredit,
  "Terms": Terms
};

class PageContext {
  PageDetail fromJson(Map<String, dynamic> pageDetail) {
    if (pageDetail != null) {
      if (pageDetail["entityType"] == "Terms") {
        return Terms.fromJson(pageDetail);
      } else if (pageDetail["entityType"] == "EarnMore") {
        return EarnMoreCredit.fromJson(pageDetail);
      }
    }
    throw Exception();
  }
}

class Terms implements PageDetail {
  String? text;
  String? textToCredit;
  String? entityType;

  Terms({this.text, this.textToCredit, this.entityType});

  Terms.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    textToCredit = json['textToCredit'];
    entityType = json['entityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['textToCredit'] = this.textToCredit;
    data['entityType'] = this.entityType;
    return data;
  }
}

class EarnMoreCredit implements PageDetail {
  String? text;
  List<TextToCredit>? textToCredit;
  String? entityType;

  EarnMoreCredit({this.text, this.textToCredit, this.entityType});

  EarnMoreCredit.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['textToCredit'] != null) {
      textToCredit = <TextToCredit>[];
      json['textToCredit'].forEach((v) {
        textToCredit!.add(new TextToCredit.fromJson(v));
      });
    }
    entityType = json['entityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.textToCredit != null) {
      data['textToCredit'] = this.textToCredit!.map((v) => v.toJson()).toList();
    }
    data['entityType'] = this.entityType;
    return data;
  }
}

class TextToCredit {
  String? text;
  int? credit;
  String? subText;

  TextToCredit({this.text, this.credit, this.subText});

  TextToCredit.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    credit = json['credit'];
    subText = json['subText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['credit'] = this.credit;
    data['subText'] = this.subText;
    return data;
  }
}
