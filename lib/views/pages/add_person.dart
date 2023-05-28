import 'package:flutter/material.dart';
import 'package:money_manager/blocs/exports.dart';

import 'package:money_manager/models/user.dart';
import 'package:money_manager/views/pages/navigation_bar.dart';

import '../../core/validation.dart';

class AddPersonPage extends StatefulWidget {
  static const String id = '/add_person';
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController nameController;
  @override
  void initState() {
    nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: nameController,
                  validator: Validate.username,
                  decoration: InputDecoration(
                    hintText: 'What\'s your nick name?',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ))),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<CategoryListBloc>().add(LoadCategoryEvent());
              context
                  .read<UserBloc>()
                  .add(AddUserEvent(user: User(name: nameController.text)));
              Navigator.pushNamedAndRemoveUntil(
                  context, CustomNavigationBar.id, (route) => false);
            }
          },
          child: const Text('Done')),
    );
  }
}
