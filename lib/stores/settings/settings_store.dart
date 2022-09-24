import 'package:boilerplate/data/repository.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  // repository instance
  final Repository _repository;

  // store variables:-----------------------------------------------------------
  @observable
  bool _userDidFinishOnboarding = false;

  // getters:---------------------------------------------------------------------
  bool get userDidFinishOnboarding => _userDidFinishOnboarding;

  // constructor:---------------------------------------------------------------
  _SettingsStore(Repository repository) : this._repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future setUserDidFinishOnboarding(bool value) async {
    _userDidFinishOnboarding = value;
    await _repository.setUserDidFinishOnboarding(value);
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    if (_repository.userDidFinishOnboarding != null) {
      _userDidFinishOnboarding = _repository.userDidFinishOnboarding!;
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
