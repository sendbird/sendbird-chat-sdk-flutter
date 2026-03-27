// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatUser on Chat {
  User? get currentUser {
    return chatContext.currentUser;
  }

  Future<void> updateCurrentUserInfo({
    String? nickname,
    FileInfo? profileFileInfo,
    List<String>? preferredLanguages,
    ProgressHandler? progressHandler,
  }) async {
    sbLog.i(StackTrace.current, 'nickname: $nickname');

    if (nickname == null &&
        profileFileInfo == null &&
        preferredLanguages == null) {
      throw InvalidParameterException();
    }

    final user = await apiClient.send<User>(UserInfoUpdateRequest(
      this,
      nickname: nickname,
      profileFileInfo: profileFileInfo,
      preferredLanguages: preferredLanguages,
      progressHandler: progressHandler,
    ));
    chatContext.currentUser?.copyWith(user);
  }

  Future<User> blockUser(String userId) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    return await apiClient.send<User>(UserBlockRequest(this, targetId: userId));
  }

  Future<void> unblockUser(String userId) async {
    sbLog.i(StackTrace.current, 'userId: $userId');
    await apiClient.send(UserUnblockRequest(this, targetId: userId));
  }

  Future<void> setWeeklyDoNotDisturb({
    required List<DndSchedule> dndSchedules,
    String timezone = 'UTC',
  }) async {
    sbLog.i(StackTrace.current);

    if (dndSchedules.isEmpty) {
      throw InvalidParameterException();
    }

    final dayOfWeekSet = <DayOfWeek>{};
    for (final dndSchedule in dndSchedules) {
      if (!dayOfWeekSet.add(dndSchedule.dayOfWeek)) {
        throw InvalidParameterException();
      }

      final timeWindows = dndSchedule.dndTimeWindows;
      if (timeWindows.isEmpty) {
        throw InvalidParameterException();
      }

      for (int i = 0; i < timeWindows.length; i++) {
        final a = timeWindows[i];
        if (a.startHour < 0 ||
            a.startHour > 23 ||
            a.startMin < 0 ||
            a.startMin > 59 ||
            a.endHour < 0 ||
            a.endHour > 23 ||
            a.endMin < 0 ||
            a.endMin > 59) {
          throw InvalidParameterException();
        }

        final aStart = a.startHour * 60 + a.startMin;
        final aEnd = a.endHour * 60 + a.endMin;
        if (aStart >= aEnd) {
          throw InvalidParameterException();
        }

        for (int j = i + 1; j < timeWindows.length; j++) {
          final b = timeWindows[j];
          final bStart = b.startHour * 60 + b.startMin;
          final bEnd = b.endHour * 60 + b.endMin;
          if (aStart <= bEnd && bStart <= aEnd) {
            throw InvalidParameterException();
          }
        }
      }
    }

    await apiClient.send(UserWeeklyDoNotDisturbSetRequest(
      this,
      dndSchedules: dndSchedules,
      timezone: timezone,
    ));
  }

  Future<WeeklyDoNotDisturb> getWeeklyDoNotDisturb() async {
    sbLog.i(StackTrace.current);
    return await apiClient
        .send<WeeklyDoNotDisturb>(UserWeeklyDoNotDisturbGetRequest(this));
  }

  Future<void> clearWeeklyDoNotDisturb() async {
    sbLog.i(StackTrace.current);
    await apiClient.send(UserWeeklyDoNotDisturbDeleteRequest(this));
  }

  Future<void> setDoNotDisturb({
    required bool enable,
    int startHour = 0,
    int startMin = 0,
    int endHour = 23,
    int endMin = 59,
    String timezone = 'UTC',
  }) async {
    sbLog.i(StackTrace.current, 'enable: $enable');

    if (enable && startHour < 0 ||
        startHour > 23 ||
        startMin < 0 ||
        startMin > 59 ||
        endHour < 0 ||
        endHour > 23 ||
        endMin < 0 ||
        endMin > 59) {
      throw InvalidParameterException();
    }

    return await apiClient.send(UserDoNotDisturbSetRequest(
      this,
      enable: enable,
      startHour: startHour,
      startMin: startMin,
      endHour: endHour,
      endMin: endMin,
      timezone: timezone,
    ));
  }

  Future<DoNotDisturb> getDoNotDisturb() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<DoNotDisturb>(UserDoNotDisturbGetRequest(this));
  }

  Future<void> setSnoozePeriod({
    required bool enable,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    sbLog.i(StackTrace.current, 'enable: $enable');

    if (enable) {
      if (startDate == null || endDate == null) {
        throw InvalidParameterException();
      }
      if (endDate.difference(startDate).inSeconds < 0) {
        throw InvalidParameterException();
      }
      if (endDate.difference(DateTime.now()).inSeconds < 0) {
        throw InvalidParameterException();
      }
    }
    return await apiClient.send(UserSnoozePeriodSetRequest(
      this,
      enable: enable,
      startDate: startDate,
      endDate: endDate,
    ));
  }

  Future<SnoozePeriod> getSnoozePeriod() async {
    sbLog.i(StackTrace.current);
    return await apiClient.send<SnoozePeriod>(UserSnoozePeriodGetRequest(this));
  }
}
