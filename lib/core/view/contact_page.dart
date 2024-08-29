import 'package:contact_serverpod/core/controller/riverpod_generator.dart';
import 'package:contact_serverpod/core/controller/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactPage extends HookConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final mobileController = useTextEditingController();
    final loading = useState<bool>(false);

    void onAdd() async {
      // loading.value = true;
      // await ref.read(contactControllerProvider.notifier).addContct(
      //       context,
      //       name: nameController.text,
      //       mobile: mobileController.text,
      //     );
      // loading.value = false;
      // nameController.clear();
      // mobileController.clear();
      // ref.invalidate(contactControllerProvider);
      // Future.sync(() => Navigator.pop(context));
    }

    void onEdit(int id) async {
      await ref.read(contactControllerProvider.notifier).updateContct(context,
          id: id, name: nameController.text, mobile: mobileController.text);
      Future.sync(() => Navigator.pop(context));
    }

    void showDialogModal([bool isEdit = false, int? id]) {
      if (!isEdit) {
        nameController.clear();
        mobileController.clear();
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("${isEdit ? "Edit" : "Add"} Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter name",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter number",
                ),
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => isEdit ? onEdit(id!) : onAdd(),
              child: loading.value
                  ? const CircularProgressIndicator()
                  : Text(isEdit ? "Edit" : "Add"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact App"),
          actions: [
            IconButton(
              onPressed: showDialogModal,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(contactControllerProvider);
          },
          child: ref.watch(contactControllerProvider).isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ref.watch(contactControllerProvider).when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) => ListTile(
                        onTap: () {
                          toastinfo("Haui");
                        },
                        title: Text(data[index].name),
                        subtitle: Text("${data[index].mobile}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                nameController.text = data[index].name;
                                mobileController.text = data[index].mobile;
                                showDialogModal(true, data[index].id);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(contactControllerProvider.notifier)
                                    .deleteContct(context, id: data[index].id);
                                ref.invalidate(contactControllerProvider);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text("$error"),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
        ));
  }
}
