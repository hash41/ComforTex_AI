enum AiVersion {
  one, two, twoDynamicPredictions
}

class AiVersionStore {
  AiVersion? _aiVersion;

  ///Singleton .. stays while the app is active..
  static final AiVersionStore instance = AiVersionStore._();
  AiVersionStore._();


  AiVersion? get aiVersion {
    return _aiVersion;
  }
  set aiVersion(AiVersion? ai) {
    this._aiVersion = ai;
  }

  Map<String, String> toJson() {
    if(aiVersion != null) {
      if(aiVersion == AiVersion.one) {
        return {'ai_version': '1'};
      }
      else if (aiVersion == AiVersion.twoDynamicPredictions)
        {
          return {'ai_version': '2.1'};
        }
      return {'ai_version': '2'};
    }
    throw ArgumentError();
  }
}