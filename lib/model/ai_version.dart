///Enum representation of the diff available AI versions AND API versions
enum AiVersion {
  /// 1st AI we had
  one,
  /// 2st AI we had
  two,
  /// 2st AI we had with dynamic properties values
  twoDynamicProperties,
}


/// A singleton class which register and keeps track of the ai version
class AiVersionStore {
  AiVersionStore._();
  AiVersion? _aiVersion;

  /// 1 instance
  static final AiVersionStore instance = AiVersionStore._();



  /// Getter + setter
  AiVersion? get aiVersion {
    return _aiVersion;
  }
  set aiVersion(AiVersion? ai) {
    _aiVersion = ai;
  }


  /// JSON representation of this class
  Map<String, String> toJson() {
    if(aiVersion != null) {
      if(aiVersion == AiVersion.one) {
        return {'ai_version': '1'};
      }
      else if (aiVersion == AiVersion.twoDynamicProperties)
        {
          return {'ai_version': '2.1'};
        }
      return {'ai_version': '2'};
    }
    //TODO(Hash): switch to an Exception
    throw ArgumentError();
  }
}
