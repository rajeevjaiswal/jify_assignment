import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'config/dio_client.dart';
import 'data/datasources/remote/images_api_service.dart';
import 'data/repositories/images_repository_impl.dart';
import 'domain/repositories/images_repository.dart';
import 'domain/usecases/get_images_usecase.dart';
import 'presentation/blocs/remote_images_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client

  injector.registerSingleton<Dio>(DioClient().dio);

  // Dependencies
  injector.registerSingleton<ImagesApiService>(ImagesApiService(injector()));

  // *
  injector.registerSingleton<ImagesRepository>(
    ImagesRepositoryImpl(injector()),
  );

  // UseCases
  injector.registerSingleton<GetImagesUseCase>(GetImagesUseCase(injector()));

  // Blocs
  injector.registerFactory<RemoteImagesBloc>(
    () => RemoteImagesBloc(injector()),
  );
}
