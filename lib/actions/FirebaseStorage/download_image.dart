import 'package:casslab/helpers/helpers.dart';
import 'package:dio/dio.dart';

class DownloadImage {
  Future<bool> action(String destinationFilePath, String targetURL) async {
    try {
      if (await checkFileAvailable(destinationFilePath)) {
        return false;
      }
      await Dio().download(targetURL, destinationFilePath);
      return await checkFileAvailable(destinationFilePath);
    } catch (error) {
      return false;
    }
  }
}
