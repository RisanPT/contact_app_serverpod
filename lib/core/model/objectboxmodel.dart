import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  @Id()
  int id;
  String name;
  String mobile;
  Contact({this.id = 0, required this.name, required this.mobile});
}
