class AddressModel {
  String phonenumber;
  String Adress1;
  String Adress2;
  String city;
  String State;
  String pincode;

  AddressModel(
      {required this.phonenumber,
      required this.Adress1,
      required this.Adress2,
      required this.city,
      required this.State,
      required this.pincode});

  factory AddressModel.fromMap(Map<String, dynamic> addresses) {
    return AddressModel(
      phonenumber: addresses['phonenumber'],
      Adress1: addresses['Adress1'],
      Adress2: addresses['Adress2'],
      city: addresses['city'],
      State: addresses['state'],
      pincode: addresses['pincode'],
    );
  }
}

//========================================== (in add functionality for checkout page)
class PersonelDetailModel{
  late String Name;
  late String mobile;

  PersonelDetailModel(
    {
      required this.Name,
      required this.mobile,
    });

    factory PersonelDetailModel.fromMap(Map<String, dynamic> Detail) {
    return PersonelDetailModel(
      Name: Detail['Name'],
      mobile: Detail['Mobile'],
      
    );
  }
}
