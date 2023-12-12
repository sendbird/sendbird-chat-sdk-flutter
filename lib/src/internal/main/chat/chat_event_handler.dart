// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

part of 'chat.dart';

extension ChatEventHandler on Chat {
  void addChannelHandler(String identifier, RootChannelHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.addChannelHandler(identifier, handler);
  }

  BaseChannelHandler? getChannelHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return eventManager.getChannelHandler(identifier);
  }

  void removeChannelHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.removeChannelHandler(identifier);
  }

  void removeAllChannelHandlers() {
    sbLog.i(StackTrace.current);
    eventManager.removeAllChannelHandlers();
  }

  void addConnectionHandler(String identifier, ConnectionHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.addConnectionHandler(identifier, handler);
  }

  ConnectionHandler? getConnectionHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return eventManager.getConnectionHandler(identifier);
  }

  void removeConnectionHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.removeConnectionHandler(identifier);
  }

  void removeAllConnectionHandlers() {
    sbLog.i(StackTrace.current);
    eventManager.removeAllConnectionHandlers();
  }

  void addUserEventHandler(String identifier, UserEventHandler handler) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.addUserEventHandler(identifier, handler);
  }

  UserEventHandler? getUserEventHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    return eventManager.getUserEventHandler(identifier);
  }

  void removeUserEventHandler(String identifier) {
    sbLog.i(StackTrace.current, 'identifier: $identifier');
    eventManager.removeUserEventHandler(identifier);
  }

  void removeAllUserEventHandlers() {
    sbLog.i(StackTrace.current);
    eventManager.removeAllUserEventHandlers();
  }

  void setSessionHandler(SessionHandler handler) {
    sbLog.i(StackTrace.current);
    eventManager.setSessionHandler(handler);
  }

  SessionHandler? getSessionHandler() {
    sbLog.i(StackTrace.current);
    return eventManager.getSessionHandler();
  }

  void removeSessionHandler() {
    sbLog.i(StackTrace.current);
    eventManager.removeSessionHandler();
  }
}
