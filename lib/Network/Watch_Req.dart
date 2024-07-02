/// episode_id : "EP1"
/// data : {"startTime":"Date","endTime":"Date","watchedDuration":"Number"}

class WatchReq
{
  WatchReq
  (
    {
      required String episodeID,
      required WatchedData data,
    }
  )
  {
    _episodeId = episodeID;
    _data = data;
  }

  WatchReq.fromJson(dynamic json)
  {
    _episodeId = json['episode_id'];
    _data = (json['data'] != null ? WatchedData.fromJson(json['data']) : null)!;
  }

  String? _episodeId;
  WatchedData? _data;
  String? get episodeId => _episodeId;
  WatchedData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['episode_id'] = _episodeId;
    final _data = this._data;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// startTime : "Date"
/// endTime : "Date"
/// watchedDuration : "Number"

class WatchedData
{
  WatchedData
  (
    {
      required String startTime,
      required String endTime,
      required String duration,
    }
  )
  {
    _startTime = startTime;
    _endTime = endTime;
    _watchedDuration = duration;
  }

  WatchedData.fromJson(dynamic json)
  {
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _watchedDuration = json['watchedDuration'];
  }

  String _startTime = '';
  String _endTime = '';
  String _watchedDuration = '';

  String get startTime => _startTime;
  String get endTime => _endTime;
  String get watchedDuration => _watchedDuration;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['watchedDuration'] = _watchedDuration;
    return map;
  }

}