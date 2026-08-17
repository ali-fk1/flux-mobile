enum PostStatus {
  draft,
  scheduled,
  processing,
  publishing,
  published,
  failed,
  cancelled,
  deleted }

PostStatus postStatusFromString(String value) {
  return PostStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
    orElse: () => PostStatus.draft,
  );
}