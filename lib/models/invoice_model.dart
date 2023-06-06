import 'dart:convert';

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class Invoice {
  String? id;
  DateTime? createdAt;
  DateTime? paymentDue;
  String? description;
  int? paymentTerms;
  String? clientName;
  String? clientEmail;
  String? status;
  Address? senderAddress;
  Address? clientAddress;
  List<Item>? items;
  double? total;

  Invoice({
    this.id,
    this.createdAt,
    this.paymentDue,
    this.description,
    this.paymentTerms,
    this.clientName,
    this.clientEmail,
    this.status,
    this.senderAddress,
    this.clientAddress,
    this.items,
    this.total,
  });

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],

        createdAt: _parseDate(json["createdAt"]),
        paymentDue: _parseDate(json["paymentDue"]),
        // createdAt: json["createdAt"] == null
        //     ? null
        //     : DateTime._parseDate(json["createdAt"]),
        // paymentDue: json["paymentDue"] == null
        //     ? null
        //     : DateTime.parse(json["paymentDue"]),
        description: json["description"],
        paymentTerms: json["paymentTerms"],
        clientName: json["clientName"],
        clientEmail: json["clientEmail"],
        status: json["status"],
        senderAddress: json["senderAddress"] == null
            ? null
            : Address.fromJson(json["senderAddress"]),
        clientAddress: json["clientAddress"] == null
            ? null
            : Address.fromJson(json["clientAddress"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "paymentDue":
            "${paymentDue!.year.toString().padLeft(4, '0')}-${paymentDue!.month.toString().padLeft(2, '0')}-${paymentDue!.day.toString().padLeft(2, '0')}",
        "description": description,
        "paymentTerms": paymentTerms,
        "clientName": clientName,
        "clientEmail": clientEmail,
        "status": status,
        "senderAddress": senderAddress?.toJson(),
        "clientAddress": clientAddress?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "total": total,
      };
}

DateTime? _parseDate(String? dateString) {
  if (dateString == null) return null;
  final parts = dateString.split("-");
  if (parts.length != 3) return null;
  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);
  if (year == null || month == null || day == null) return null;
  return DateTime(year, month, day);
}

class Address {
  String? street;
  String? city;
  String? postCode;
  Country? country;

  Address({
    this.street,
    this.city,
    this.postCode,
    this.country,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        postCode: json["postCode"],
        country: countryValues.map[json["country"]]!,
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "postCode": postCode,
        "country": countryValues.reverse[country],
      };
}

enum Country { UNITED_KINGDOM, UNITED_STATES_OF_AMERICA, EMPTY }

final countryValues = EnumValues({
  "": Country.EMPTY,
  "United Kingdom": Country.UNITED_KINGDOM,
  "United States of America": Country.UNITED_STATES_OF_AMERICA
});

class Item {
  String? name;
  int? quantity;
  double? price;
  double? total;

  Item({
    this.name,
    this.quantity,
    this.price,
    this.total,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Dummy {
  //Map<String, dynamic>
  dynamic jsonData = ''' [
      {
      "id": "RT3080",
      "createdAt": "2021-08-18",
      "paymentDue": "2021-08-19",
      "description": "Re-branding",
      "paymentTerms": 1,
      "clientName": "Jensen Huang",
      "clientEmail": "jensenh@mail.com",
      "status": "paid",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "106 Kendell Street",
        "city": "Sharrington",
        "postCode": "NR24 5WQ",
        "country": "United Kingdom"
      },
      "items": [
        {
          "name": "Brand Guidelines",
          "quantity": 1,
          "price": 1800.90,
          "total": 1800.90
        }
      ],
      "total": 1800.90
    },
    {
      "id": "XM9141",
      "createdAt": "2021-08-21",
      "paymentDue": "2021-09-20",
      "description": "Graphic Design",
      "paymentTerms": 30,
      "clientName": "Alex Grim",
      "clientEmail": "alexgrim@mail.com",
      "status": "pending",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "84 Church Way",
        "city": "Bradford",
        "postCode": "BD1 9PB",
        "country": "United Kingdom"
      },
      "items": [
        {
          "name": "Banner Design",
          "quantity": 1,
          "price": 156.00,
          "total": 156.00
        },
        {
          "name": "Email Design",
          "quantity": 2,
          "price": 200.00,
          "total": 400.00
        }
      ],
      "total": 556.00
    },
    {
      "id": "RG0314",
      "createdAt": "2021-09-24",
      "paymentDue": "2021-10-01",
      "description": "Website Redesign",
      "paymentTerms": 7,
      "clientName": "John Morrison",
      "clientEmail": "jm@myco.com",
      "status": "paid",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "79 Dover Road",
        "city": "Westhall",
        "postCode": "IP19 3PF",
        "country": "United Kingdom"
      },
      "items": [
        {
          "name": "Website Redesign",
          "quantity": 1,
          "price": 14002.33,
          "total": 14002.33
        }
      ],
      "total": 14002.33
    },
    {
      "id": "RT2080",
      "createdAt": "2021-10-11",
      "paymentDue": "2021-10-12",
      "description": "Logo Concept",
      "paymentTerms": 1,
      "clientName": "Alysa Werner",
      "clientEmail": "alysa@email.co.uk",
      "status": "pending",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "63 Warwick Road",
        "city": "Carlisle",
        "postCode": "CA20 2TG",
        "country": "United Kingdom"
      },
      "items": [
        {
          "name": "Logo Sketches",
          "quantity": 1,
          "price": 102.04,
          "total": 102.04
        }
      ],
      "total": 102.04
    },
    {
      "id": "AA1449",
      "createdAt": "2021-10-7",
      "paymentDue": "2021-10-14",
      "description": "Re-branding",
      "paymentTerms": 7,
      "clientName": "Mellisa Clarke",
      "clientEmail": "mellisa.clarke@example.com",
      "status": "pending",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "46 Abbey Row",
        "city": "Cambridge",
        "postCode": "CB5 6EG",
        "country": "United Kingdom"
      },
      "items": [
        {"name": "New Logo", "quantity": 1, "price": 1532.33, "total": 1532.33},
        {
          "name": "Brand Guidelines",
          "quantity": 1,
          "price": 2500.00,
          "total": 2500.00
        }
      ],
      "total": 4032.33
    },
    {
      "id": "TY9141",
      "createdAt": "2021-10-01",
      "paymentDue": "2021-10-31",
      "description": "Landing Page Design",
      "paymentTerms": 30,
      "clientName": "Thomas Wayne",
      "clientEmail": "thomas@dc.com",
      "status": "pending",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "3964  Queens Lane",
        "city": "Gotham",
        "postCode": "60457",
        "country": "United States of America"
      },
      "items": [
        {
          "name": "Web Design",
          "quantity": 1,
          "price": 6155.91,
          "total": 6155.91
        }
      ],
      "total": 6155.91
    },
    {
      "id": "FV2353",
      "createdAt": "2021-11-05",
      "paymentDue": "2021-11-12",
      "description": "Logo Re-design",
      "paymentTerms": 7,
      "clientName": "Anita Wainwright",
      "clientEmail": "",
      "status": "draft",
      "senderAddress": {
        "street": "19 Union Terrace",
        "city": "London",
        "postCode": "E1 3EZ",
        "country": "United Kingdom"
      },
      "clientAddress": {
        "street": "",
        "city": "",
        "postCode": "",
        "country": ""
      },
      "items": [
        {
          "name": "Logo Re-design",
          "quantity": 1,
          "price": 3102.04,
          "total": 3102.04
        }
      ],
      "total": 3102.04
    }
  ]''';
}
