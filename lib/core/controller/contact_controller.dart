import 'package:contact_serverpod/core/controller/api_service.dart';
import 'package:contact_serverpod/core/model/model.dart';
import 'package:contact_serverpod/core/model/objectboxmodel.dart';
import 'package:contact_serverpod/core/services/object_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_controller.g.dart';

class ContactController {
  // List<Contact> getNumber() {
  //   return ObjectBox.instance.contactBox.getAll();
  // }

  Future<List<Contact>> addContactToObjectBox() async {
    final List<ContactModel> listOfContactApi = await ApiServices.getContact();
    final List<Contact> listOfConatctObj = listOfContactApi
        .map((e) => Contact(name: e.name, mobile: e.mobile))
        .toList();
    ObjectBox.instance.contactBox.putMany(listOfConatctObj);
    return ObjectBox.instance.contactBox.getAll();
  }
}

@riverpod
Future<List<Contact>> getContact(GetContactRef ref) {
  return ContactController().addContactToObjectBox();
}
