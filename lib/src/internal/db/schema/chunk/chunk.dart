// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

class Chunk {
  int oldestTs;
  int latestTs;

  Chunk({
    required this.oldestTs,
    required this.latestTs,
  });

  @override
  bool operator ==(other) {
    if (identical(other, this)) return true;

    return other is Chunk &&
        other.oldestTs == oldestTs &&
        other.latestTs == latestTs;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        oldestTs,
        latestTs,
      );
}
