import 'package:contact_serverpod/core/controller/api_service.dart';
import 'package:contact_serverpod/core/model/model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_generator.g.dart';

@riverpod
class ContactController extends _$ContactController {
  @override
  FutureOr<List<ContactModel>> build() async {
    return getContact();
  }

  Future<List<ContactModel>> getContact() async {
    try {
      return await ApiServices.getContact();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addContct(BuildContext context,
      {required String name, required String mobile}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        ApiServices.add(name: name, mobile: mobile);
      } catch (e) {
        Future.sync(() => const Text("Server not found"));
      }
      return getContact();
    });
  }

  Future<void> updateContct(BuildContext context,
      {required int id, required String name, required String mobile}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        ApiServices.update(id: id, name: name, mobile: mobile);
      } catch (e) {
        Future.sync(() => const Text("Server not found"));
      }
      return getContact();
    });
  }

  Future<void> deleteContct(
    BuildContext context, {
    required int id,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        ApiServices.delete(
          id: id,
        );
      } catch (e) {
        Future.sync(() => const Text("Server not found"));
      }
      return getContact();
    });
  }
}
