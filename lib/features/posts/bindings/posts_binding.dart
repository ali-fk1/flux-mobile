import 'package:get/get.dart';
import '../../../core/network/dio_client.dart';
import '../../auth/controllers/x_auth_controller.dart';
import '../../auth/repositories/x_auth_repository.dart';
import '../controllers/posts_controller.dart';
import '../repositories/post_repository.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRepository>(
          () => PostRepository(Get.find<DioClient>().dio),
    );

    Get.lazyPut<PostsController>(
          () => PostsController(Get.find<PostRepository>()),
    );

    Get.lazyPut<XAuthRepository>(
            () => XAuthRepository(Get.find<DioClient>().dio))
    ;
    Get.lazyPut<XAuthController>(            () => XAuthController(Get.find<XAuthRepository>())
    );
  }
}