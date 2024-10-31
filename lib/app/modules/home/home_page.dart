import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:childrens_stories/app/core/state/base_state.dart';
import 'package:childrens_stories/app/modules/home/cubit/home_cubit.dart';
import 'package:childrens_stories/app/modules/home/widgets/home_list.dart';
import 'package:flutter/material.dart';
import 'package:childrens_stories/app/modules/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeCubit> {
  @override
  void onReady() {
    super.onReady();
    context.read<HomeCubit>().findAllStories();
  }

  // Função para mapear o ID da categoria para o título
  String getCategoryTitle(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'Aventura';
      case 2:
        return 'Morais';
      default:
        return 'Desconhecida'; // Caso de fallback para IDs inesperados
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórias Infantis'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == HomeStatus.loaded &&
              state.categorizedStories.isNotEmpty) {
            final categories = state.categorizedStories.entries.toList();

            return ListView.builder(
              itemCount: categories.length + 1, // Adiciona 1 para o banner
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Adiciona o banner no topo
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: context.percentHeight(.3),
                          width: context.percentWidth(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/home_banner.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Defina o raio desejado aqui
                            ),
                          ),
                          child: Text(
                            'Liberte sua imaginação',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  final categoryId = categories[index - 1].key;
                  final stories = categories[index - 1].value;

                  if (stories.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: HomeList(
                        stories: stories,
                        title: getCategoryTitle(categoryId),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            );
          } else if (state.status == HomeStatus.empty) {
            return const Center(child: Text('Nenhuma história disponível.'));
          } else if (state.status == HomeStatus.error) {
            return const Center(child: Text('Erro ao carregar histórias.'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
