// ignore: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servicios_modelo_ui/models/users.dart';
import 'package:servicios_modelo_ui/services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

final hairColorsProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(userServiceProvider);
  return service.getHairColors();
});

class ColorSeleccionado extends Notifier<String?> {
  @override
  String? build() => null;

  void seleccionar(String? color) {
    state = (state == color) ? null : color;
  }
}

final colorSeleccionadoProvider = NotifierProvider<ColorSeleccionado, String?>(
  ColorSeleccionado.new,
);

final usersProvider = FutureProvider<List<User>>((ref) {
  final service = ref.watch(userServiceProvider);
  final color = ref.watch(colorSeleccionadoProvider);
  return (color == null)
      ? service.getUsers()
      : service.getUsersByHairColor(color);
});

final userByIdProvider = FutureProvider.family<User, int>((ref, id) {
  final service = ref.watch(userServiceProvider);
  return service.getUserById(id);
},);
