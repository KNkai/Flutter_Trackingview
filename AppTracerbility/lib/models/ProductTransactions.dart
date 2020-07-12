class ProductTransactions{
  int id;
  String idProduct;
  int idLocation;
  String detail;
  String dateChecked;
  String idUser;

  ProductTransactions({this.id, this.idProduct, this.idLocation, this.detail, this.dateChecked, this.idUser});

  factory ProductTransactions.fromJson(Map<String, dynamic> map){
    return ProductTransactions(
      id : map['idProductTransactions'],
      idProduct: map['idProduct'],
      idLocation: map['idLocation'],
      detail: map['detail'],
      dateChecked: map['dateChecked'],
      idUser: map['idUser'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      // 'idProductTransactions':id,
      'idProduct':idProduct,
      'idLocation':idLocation,
      'detail':detail,
      'dateChecked':dateChecked,
      'idUser':idUser,
    };
  }
}

