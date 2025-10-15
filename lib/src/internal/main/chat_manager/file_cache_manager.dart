// Copyright (c) 2025 Sendbird, Inc. All rights reserved.

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_chat_sdk/src/internal/main/chat/chat.dart';

import '../logger/sendbird_logger.dart';

class FileCacheManager {
  static const String _folderName = 'sendbird_chat_file_cache';

  final Chat _chat;
  int retentionMinutes = 3 * 24 * 60; // 3 days

  FileCacheManager({required Chat chat}) : _chat = chat;

  bool _isForIOSCaching() {
    return Platform.isIOS && _chat.chatContext.options.useCollectionCaching;
  }

  Future<Directory> _getCacheDir() async {
    final appSupportDir = await getApplicationSupportDirectory();
    final cacheDir = Directory('${appSupportDir.path}/$_folderName');
    if (!cacheDir.existsSync()) {
      cacheDir.createSync();
    }
    return cacheDir;
  }

  Future<String> _getCachedFilePath({
    required String requestId,
    required File file,
  }) async {
    final cacheDir = await _getCacheDir();
    String cachedFilePath =
        '${cacheDir.path}/${requestId}_${file.path.split('/').last}';
    return cachedFilePath;
  }

  Future<void> copyFileForIOS({
    required GroupChannel channel,
    required String? requestId,
    required File? originalFile,
  }) async {
    if (_isForIOSCaching() && requestId != null && originalFile != null) {
      try {
        final cachedFilePath = await _getCachedFilePath(
          requestId: requestId,
          file: originalFile,
        );
        File cachedFile = File(cachedFilePath);
        if (cachedFile.existsSync()) {
          cachedFile.deleteSync();
        }
        cachedFile = await originalFile.copy(cachedFilePath);
        await cachedFile.setLastModified(DateTime.now());

        final failedFileMessage = await _chat.dbManager.getFailedFileMessage(
          channelType: ChannelType.group,
          channelUrl: channel.channelUrl,
          requestId: requestId,
        );

        if (failedFileMessage != null) {
          failedFileMessage.file = cachedFile;
          failedFileMessage.messageCreateParams?.fileInfo.file = cachedFile;

          await _chat.dbManager.upsertMessages([failedFileMessage]);
        }
      } catch (e) {
        sbLog.e(StackTrace.current, 'Failed to write cache file for iOS: $e');
      }
    }
  }

  Future<void> removeCachedFileForIOS({
    required String? requestId,
    required File? file,
  }) async {
    if (_isForIOSCaching() && requestId != null && file != null) {
      try {
        final cachedFilePath = await _getCachedFilePath(
          requestId: requestId,
          file: file,
        );
        final cachedFile = File(cachedFilePath);
        if (cachedFile.existsSync()) {
          cachedFile.deleteSync();
        }
      } catch (e) {
        sbLog.e(StackTrace.current, 'Failed to delete cache file for iOS: $e');
      }
    }
  }

  Future<void> removeOldCachedFilesForIOS() async {
    if (_isForIOSCaching()) {
      try {
        final cacheDir = await _getCacheDir();
        List<String> filePathList = [];
        final now = DateTime.now();

        for (final fileEntity in cacheDir.listSync()) {
          final file = File(fileEntity.path);
          final lastModified = file.lastModifiedSync();
          if (now.difference(lastModified).inMinutes >= retentionMinutes) {
            filePathList.add(fileEntity.path);
          }
        }

        if (filePathList.isNotEmpty) {
          try {
            await _chat.dbManager.removeOldFailedMessages(filePathList);
          } catch (e) {
            sbLog.e(StackTrace.current,
                'Failed to remove failed messages with old cache files: $e');
          }
        }
      } catch (e) {
        sbLog.e(StackTrace.current, 'Failed to clean old cache files: $e');
      }
    }
  }

  Future<void> clearCacheForIOS() async {
    if (_isForIOSCaching()) {
      try {
        final cacheDir = await _getCacheDir();
        if (cacheDir.existsSync()) {
          cacheDir.deleteSync(recursive: true);
        }
      } catch (e) {
        sbLog.e(StackTrace.current, 'Failed to clear cache for iOS: $e');
      }
    }
  }
}
