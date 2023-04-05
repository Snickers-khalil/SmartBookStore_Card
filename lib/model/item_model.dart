class Item {
  final int id;
  final String title;
  final String author;
  final String description;
  final int price;
  final String image;

  Item({ this.id , this.title,  this.author,this.description, this.price,  this.image});

  Map toJson() {
    return {
      'id':id,
      'name': title,
      'unit': author,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
