String convertDateTime(String date){
  DateTime dateTime = DateTime.parse(date);
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  int day = dateTime.day;
  int month = dateTime.month;
  int year = dateTime.year;
  return hour.toString() + ":"+ minute.toString() + " " + day.toString() + "/" + month.toString() + "/" + year.toString();
}