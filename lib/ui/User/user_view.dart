import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servicios_modelo_ui/models/users.dart';
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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Mis colores',
          style: TextStyle(
            color: Color(0xFF171717),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Color(0xFF606060), size: 28),
          SizedBox(width: 18),
          Icon(Icons.more_vert, color: Color(0xFF606060), size: 28),
          SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'COLORES DE CABELLO',
                style: TextStyle(
                  color: Color(0xFF606060),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 48,
                child: colorsAsync.when(
                  data: (colors) => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, index) {
                      final color = colors[index];
                      final isSelected = selectedColor == color;
                      return ChoiceChip(
                        label: Text(color),
                        selected: isSelected,
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF2388E8),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF2388E8)
                              : const Color(0xFFD8D8D8),
                        ),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF171717),
                          fontSize: 17,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                        onSelected: (_) => ref
                            .read(colorSeleccionadoProvider.notifier)
                            .seleccionar(color),
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text(
                    'No se pudieron cargar los colores: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              usersAsync.when(
                data: (users) => Row(
                  children: [
                    const Text(
                      'USUARIOS',
                      style: TextStyle(
                        color: Color(0xFF606060),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _UserCount(count: users.length),
                  ],
                ),
                loading: () => const Text(
                  'USUARIOS',
                  style: TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                error: (error, stack) => const Text(
                  'USUARIOS',
                  style: TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: usersAsync.when(
                  data: (users) {
                    if (users.isEmpty) {
                      return Center(
                        child: Text(
                          selectedColor == null
                              ? 'No hay usuarios disponibles.'
                              : 'No hay usuarios con cabello $selectedColor.',
                          style: const TextStyle(color: Color(0xFF606060)),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (_, index) => _UserCard(user: users[index]),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => const Center(
                    child: Text(
                      'No se pudieron cargar los usuarios.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCount extends StatelessWidget {
  const _UserCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Color(0xFF2388E8),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final initials = '${user.firstName[0]}${user.lastName[0]}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCDCDC)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: _avatarColor(user.id),
            backgroundImage: NetworkImage(user.image),
            child: user.image.isEmpty
                ? Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF606060), size: 32),
        ],
      ),
    );
  }

  static Color _avatarColor(int id) {
    const colors = [
      Color(0xFFEC3D91),
      Color(0xFF8654EA),
      Color(0xFF10B981),
      Color(0xFFFF9D00),
      Color(0xFF10B5D2),
    ];
    return colors[(id - 1) % colors.length];
  }
}
