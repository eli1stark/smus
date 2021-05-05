String unixTimeToTimeAgo(int time) {
  final dateNow = DateTime.now();
  final dateAgo = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  final difference = dateNow.difference(dateAgo);

  if (difference.inSeconds < 60) {
    final duration = difference.inSeconds;
    return '$duration second${_plurality(duration)} ago';
  } else if (difference.inMinutes < 60) {
    final duration = difference.inMinutes;
    return '$duration minute${_plurality(duration)} ago';
  } else if (difference.inHours < 24) {
    final duration = difference.inHours;
    return '$duration hour${_plurality(duration)} ago';
  } else {
    final duration = difference.inDays;
    return '$duration day${_plurality(duration)} ago';
  }
}

String _plurality(int duration) {
  if (duration != 1) {
    return 's';
  } else {
    return '';
  }
}
