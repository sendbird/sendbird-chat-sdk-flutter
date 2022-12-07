/// Represents a set of error code from server and sdk
class ErrorCode {
  // Server Error
  static int invalidParameteraValueString = 400100;
  static int nvalidParameterValueNumber = 400101;
  static int invalidParameterValueList = 400102;
  static int invalidParameterValueJson = 400103;
  static int invalidParameterValueBoolean = 400104;
  static int invalidParameterValueRequired = 400105;
  static int invalidParameterValuePositive = 400106;
  static int invalidParameterValueNegative = 400107;
  static int nonAuthorized = 400108;
  static int tokenExpired = 400109;
  static int invalidChannelUrl = 400110;
  static int invalidParameterValue = 400111;
  static int unusableCharacterIncluded = 400151;
  static int notFoundInDatabase = 400201;
  static int duplicatedData = 400202;

  static int userDeactivated = 400300;
  static int userNotExist = 400301;
  static int accessTokenNotValid = 400302;
  static int authUnknownError = 400303;
  static int appIdNotValid = 400304;
  static int authUserIdTooLong = 400305;
  static int authPlanQuotaExceeded = 400306;
  static int sessionKeyExpired = 400309;
  static int sessionTokenRevoked = 400310;

  static int invalidApiToken = 400401;
  static int parameterMissing = 400402;
  static int invalidJsonBody = 400403;

  static int internalServerError = 500901;
  static int rateLimitExceeded = 500910;

  // SDK Errors
  static int unknownError = 800000;
  static int invalidInitialization = 800100;
  static int notSupportedError = 800111;
  static int connectionRequired = 800101;
  static int connectionCanceled = 800102;
  static int invalidParameter = 800110;
  static int networkError = 800120;
  static int networkRoutingError = 800121;
  static int malformedData = 800130;
  static int malformedErrorData = 800140;
  static int wrongChannelType = 800150;
  static int markAsReadRateLimitExceeded = 800160;
  static int queryInProgress = 800170;
  static int ackTimeout = 800180;
  static int loginTimeout = 800190;
  static int webSocketConnectionClosed = 800200;
  static int webSocketConnectionFailed = 800210;
  static int requestFailed = 800220;
  static int fileUploadCancelFailed = 800230;
  static int fileUploadCanceled = 800240;
  static int fileUploadTimeout = 800250;
  static int fileSizeLimitExceeded = 800260;
  static int timerWasExpired = 800301;
  static int timerWasAlreadyDone = 800302;
  static int pendingError = 800400;
  static int passedInvalidAccessToken = 800500;
  static int sessionKeyRefreshSucceeded = 800501;
  static int sessionKeyRefreshFailed = 800502;

  // WS Error
  static int socketLoginRequired = 900010;
  static int socketUserNotMember = 900020;
  static int socketUserDeactivated = 900021;
  static int socketUserNotOwnerOfMessage = 900022;
  static int socketUserSendMessageNotAllowed = 900023;
  static int socketInvalidMentionForMessage = 900025;
  static int socketInvalidPushOptionForMessage = 900026;
  static int socketTooManyMetaKeyForMessage = 900027;
  static int socketTooManyMetaValueForMessage = 900028;
  static int socketTooManyMetaArrayForMessage = 900029;
  static int socketGuestNotAllowed = 900030;
  static int socketMutedUserInApplicationSendMessageNotAllowed = 900040;
  static int socketMutedUserInChannelSendMessageNotAllowed = 900041;
  static int socketChannelFrozen = 900050;
  static int socketProfanityMessageBlocked = 900060;
  static int socketBannedUrlsBlocked = 900061;
  static int socketRestrictedDomainBlocked = 900065;
  static int socketModeratedFileBlocked = 900066;
  static int socketEnterDeletedChannel = 900070;
  static int socketBlockedUserReceiveMessageNotAllowed = 900080;
  static int socketDeactivatedUserReceiveMessageNotAllowed = 900081;
  static int socketWrongChannelType = 900090;
  static int socketBannedUserSendMessageNotAllowed = 900100;
  static int socketTooManyMessages = 900200;
  static int socketMessageNotFound = 900300;
  static int socketTooManyParticipants = 900400;
  static int socketChannelNotFound = 900500;
}
