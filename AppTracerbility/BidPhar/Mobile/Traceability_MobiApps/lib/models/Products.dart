class Products{
  String id;
  String nameProduct;
  String manufacturedDate;
  String expiredDate;
  String manufactured;
  String details;

  Products({this.id, this.nameProduct, this.manufacturedDate, this.expiredDate, this.manufactured, this.details});

  factory Products.fromJson(Map<String, dynamic> map){
    return Products(
      id:map['idProduct'],
      nameProduct:map['nameProduct'],
      manufacturedDate:map['manufacturedDate'],
      expiredDate:map['expiredDate'],
      manufactured:map['manufactured'],
      details: map['details']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'idProduct':id,
      'nameProduct':nameProduct,
      'manufacturedDate':manufacturedDate,
      'expiredDate':expiredDate,
      'manufactured':manufactured,
      'details':details
    };
  }
}