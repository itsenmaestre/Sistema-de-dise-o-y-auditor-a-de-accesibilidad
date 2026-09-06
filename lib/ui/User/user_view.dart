import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servicios_modelo_ui/providers/User_providers.dart';

class UserVieww extends ConsumerWidget {
  const UserVieww({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MisColores();
  }
}

class UserView extends UserVieww {
  const UserView({super.key});
}

class MisColores extends ConsumerWidget {
  const MisColores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsAsync = ref.watch(hairColorsProvider);
    final selectedColor = ref.watch(colorSeleccionadoProvider);
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis colores')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(hairColorsProvider);
          ref.invalidate(usersProvider);
          await ref.read(hairColorsProvider.future);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Text(
              'Colores de cabello',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            colorsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _ErrorMessage(
                message: 'No se pudieron cargar los colores.',
                onRetry: () => ref.invalidate(hairColorsProvider),
              ),
              data: (colors) {
                if (colors.isEmpty) {
                  return const Text('No hay colores disponibles.');
                }

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: colors.map((color) {
                    return ChoiceChip(
                      label: Text(color),
                      selected: selectedColor == color,
                      onSelected: (_) => ref
                          .read(colorSeleccionadoProvider.notifier)
                          .seleccionar(color),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 28),
            Text(
              selectedColor == null
                  ? 'Usuarios'
                  : 'Usuarios con cabello $selectedColor',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            usersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _ErrorMessage(
                message: 'No se pudieron cargar los usuarios.',
                onRetry: () => ref.invalidate(usersProvider),
              ),
              data: (users) {
                if (users.isEmpty) {
                  return const Text('No hay usuarios para este color.');
                }

                return Column(
                  children: users.map((user) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.email),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message),
        TextButton(onPressed: onRetry, child: const Text('Reintentar')),
      ],
    );
  }
}
