import 'package:flux_mobile/core/network/dio_client.dart';
import 'package:flux_mobile/features/schedule/controllers/scheduling_controller.dart';
import 'package:flux_mobile/features/schedule/repositories/scheduling_repository.dart';
import 'package:get/get.dart';

class SchedulingBinding extends Bindings{

  @override
  void dependencies() {

    Get.lazyPut<SchedulingRepository>(
        ()=>SchedulingRepository(Get.find<DioClient>().dio),
    );

    Get.lazyPut<SchedulingController>(
          () => SchedulingController(Get.find<SchedulingRepository>()),
    );
  }

}