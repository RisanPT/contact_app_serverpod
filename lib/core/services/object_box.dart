import 'package:contact_serverpod/core/model/objectboxmodel.dart';
import 'package:contact_serverpod/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;
  late Box<Contact> contactBox;
  ObjectBox._create(this.store) {
    contactBox = store.box();
  }
  static ObjectBox? _instance;
  static ObjectBox get instance {
    return _instance!;
  }

  static Future<ObjectBox> createContact() async {
    final contactstore = await getApplicationDocumentsDirectory();
    final store =
        await openStore(directory: p.join(contactstore.path, "Contact box"));
    final instance = ObjectBox._create(store);
    _instance = instance;
    return instance;
  }
}
