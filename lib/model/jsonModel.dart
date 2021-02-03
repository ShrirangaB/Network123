class GetUsers {
  int id;
  String name;
  String email;
  String phoneNumber;
  Address address;

  GetUsers({this.id, this.name, this.email, this.phoneNumber, this.address});

  factory GetUsers.fromJson(Map<String, dynamic> json) {
    return GetUsers(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone'],
        address:
            json['address'] != null ? Address.fromJson(json['address']) : null);
  }
}

class Address {
  final String street;
  final String city;
  final String zipcode;

  Address({this.street, this.city, this.zipcode});

  factory Address.fromJson(Map<String, dynamic> addjson) {
    return Address(
        street: addjson["street"],
        city: addjson["city"],
        zipcode: addjson["zipcode"]);
  }
}
