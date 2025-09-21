import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'core/api/media_service.dart';

// Instância global e estática do GetIt.
final locator = GetIt.instance;

// Função para registrar as dependências (nossos "serviços").
void setupLocator() {
  // REGRA DE REGISTRO PARA O DIO
  // 'registerLazySingleton' cria uma instância do Dio na primeira chamada, 
  // para todas as chamadas futuras entrega essa mesma instância
  locator.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: 'https://movie-api.bridge.ufsc.br/api',
    )
  ));

  // REGRA DE REGISTRO PARA O SERVIÇO MEDIA
  // Quando criar um MediaService, pega a instancia global do Dio e passa para o construtor
  locator.registerLazySingleton(() => MediaService(dio: locator<Dio>()));
}