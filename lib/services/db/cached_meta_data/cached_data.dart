class CachedData<T> {
  T value;
  bool isRemoved;
  int ts;

  CachedData({
    required this.value,
    this.isRemoved = false,
    this.ts = 0,
  });
}
