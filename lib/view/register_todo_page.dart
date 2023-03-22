import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/register_todo_controller.dart';

class RegisterTodoPage extends StatefulWidget {
  const RegisterTodoPage({super.key});

  @override
  State<RegisterTodoPage> createState() => _RegisterTodoPageState();
}

class _RegisterTodoPageState extends State<RegisterTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterTodoController>(
        builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Registrar TODO'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Titulo'),
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Descrição'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildItemColor('#FF0000', controller),
                      const SizedBox(width: 10),
                      _buildItemColor('#2986cc', controller),
                      const SizedBox(width: 10),
                      _buildItemColor('#8fce00', controller),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.register(
                        _titleController.text,
                        _descriptionController.text,
                        success: () {
                          Navigator.pop(context, true);
                        },
                      );
                    },
                    child: const Text('Salvar'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildItemColor(
    String colorHex,
    RegisterTodoController controller,
  ) {
    return InkWell(
      onTap: () {
        controller.changeColor(colorHex);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(int.parse(colorHex.replaceAll('#', '0xFF'))).withOpacity(
            controller.colorSelected == colorHex ? 1 : 0.2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
