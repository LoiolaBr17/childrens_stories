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
        return 'Medo';
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
            // Criar um ListView apenas com as categorias e suas histórias
            final categories = state.categorizedStories.entries.toList();

            return ListView.builder(
              itemCount:
                  categories.length, // Duas categorias, portanto 2 HomeList
              itemBuilder: (context, index) {
                final categoryId = categories[index].key;
                final stories = categories[index].value;

                // Apenas criar HomeList para categorias que possuem histórias
                if (stories.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: HomeList(
                      stories: stories, // Histórias da categoria
                      title: getCategoryTitle(
                          categoryId), // Nome da categoria com base no ID
                    ),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Não exibir nada se não houver histórias
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
