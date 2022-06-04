abstract class AbstractDomain<T> {
  AbstractDomain({this.id});

  T? id;

  T? getId();

  AbstractDomain<T> fromJson(Map<String, dynamic> map);

  Map<String, dynamic> toJson();
}