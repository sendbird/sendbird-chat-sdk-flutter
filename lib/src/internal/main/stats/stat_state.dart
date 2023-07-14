// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

enum StatState {
  pending, // StatCollector's state isn't determined because it haven't received LOGI command.
  enabled, // StatCollector is able to collect and upload stats.
  collectOnly, // StatCollector is able to collect but is not able to upload stats.
  disabled, // StatCollector is not able to collect and upload stats.
}
