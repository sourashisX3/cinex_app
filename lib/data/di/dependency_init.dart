import 'package:cinex_app/data/data_sources/data_sources_hive_database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initDependencies() {
  getIt.registerSingleton<HiveDatabase>(HiveDatabase());
}
