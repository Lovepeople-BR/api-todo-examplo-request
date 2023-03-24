import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/home_controller.dart';
import 'package:todo_lovepeople/data/model/todo.dart';

class HomePage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const KEY_DELETE_BUTTON = Key('KEY_DELETE_BUTTON');
  static const KEY_EXIT_BUTTON = Key('KEY_EXIT_BUTTON');
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeController>().getTODOList();
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                key: HomePage.KEY_EXIT_BUTTON,
                onPressed: () async {
                  await controller.logout();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  }
                },
                icon: const Icon(Icons.exit_to_app),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index) {
              var item = controller.todoList[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: _getColor(item.attributes?.color ?? ''),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.attributes?.title ?? '')),
                        IconButton(
                          key: HomePage.KEY_DELETE_BUTTON,
                          onPressed: () => _delete(context, item, controller),
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register-todo').then((value) {
                if (value == true) {
                  controller.getTODOList();
                }
              });
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Todo item, HomeController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Deseja deteletar o todo: ${item.attributes?.title}?'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Não'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.delete(
                            item.id?.toString() ?? '',
                            success: () {},
                          );
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getColor(String color) {
    try {
      if (color.toUpperCase().contains('0XFF')) {
        return Color(int.parse(color));
      }
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } catch (e) {
      print(e);
      return Colors.white;
    }
  }
}
