class Utils {

  static Duration timeAgoFunc(String timeago){
    Duration duration = const Duration(days: 15);
    if(timeago == 'Son 12 saat'){
      duration = const Duration(hours: 12);
    }
    if(timeago == 'Son 24 saat'){
      duration = const Duration(hours: 24);
    }
    if(timeago == 'Son hafta'){
      duration = const Duration(days: 7);
    }
    if(timeago == 'Son 30 gün'){
      duration = const Duration(days: 30);
    }
    if(timeago == 'Son 60 gün'){
      duration = const Duration(days: 60);
    }
    if(timeago == 'Son 90 gün'){
      duration = const Duration(days: 90);
    }
    return duration;
  }
}
