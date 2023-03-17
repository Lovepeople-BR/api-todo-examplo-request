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
                      InkWell(
                        onTap: () {
                          controller.changeColor('#FF0000');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(
                              controller.colorSelected == '#FF0000' ? 1 : 0.2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          controller.changeColor('#2986cc');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(
                              controller.colorSelected == '#2986cc' ? 1 : 0.2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          controller.changeColor('#8fce00');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                              controller.colorSelected == '#8fce00' ? 1 : 0.2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.register(
                          _titleController.text, _descriptionController.text,
                          success: () {
                        Navigator.pop(context, true);
                      });
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
}
