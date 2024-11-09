String getFullTime(DateTime date) {
  var hourType = '오전';
  var hour = date.hour;
  if (date.hour > 12) {
    hourType = '오후';
    hour -= 12;
  }
  return '${date.year}년 ${date.month}월 ${date.day}일 $hourType $hour:${date.minute}:${date.second}';
}
