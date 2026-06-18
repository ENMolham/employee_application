import 'package:dio/dio.dart';
import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Model/change_status_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

abstract class ChangeStatusWebService {
  Future<ChangeStatusEntity> changeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  );
}

@Singleton(as: ChangeStatusWebService)
class ChangeStatusWebServiceImpl implements ChangeStatusWebService {
  final ApiConsumer _apiConsumer;

  ChangeStatusWebServiceImpl(this._apiConsumer);

  @override
  Future<ChangeStatusEntity> changeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  ) async {
    final Map<String, dynamic> data = {
      'idTransaction': idTransaction,
      'newStatus': newStatus,
    };
    if (text != null && text.trim().isNotEmpty) {
      data['text'] = text.trim();
    }
    if (files != null && files.isNotEmpty) {
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        if (file.bytes != null) {
          data['attashments[$i]'] = MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
          );
        }
      }
    }

    final formData = FormData.fromMap(data);
    final response = await _apiConsumer.post(
      EndPoints.changeStatusUrl,
      formData: formData,
    );
    return ChangeStatusEntity.fromJson(response);
  }
}
