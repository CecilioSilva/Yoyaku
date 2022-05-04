bool getDateInSameMonth(DateTime startingDate, DateTime endDate) {
  int dayDifference = endDate.difference(startingDate).inDays;
  return dayDifference <= 31;
}
