import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  final Map<String, dynamic> _states = {};
  BuildContext? _context;

  T? getState<T>(String key, {T? defaultValue}) {
    if (_states.containsKey(key)) {
      return _states[key] as T;
    } else {
      return defaultValue;
    }
  }

  void setState<T>(BuildContext context, String key, T value,
      {VoidCallback? onStateChanged}) {
    _states[key] = value;
    _context = context;
    if (onStateChanged != null) {
      onStateChanged();
    }
    notifyListeners(); // Thông báo cho listeners
    (_context as Element).markNeedsBuild();
  }
}

class StateProvider extends InheritedWidget {
  final SimpleState stateManager;

  const StateProvider({
    super.key,
    required this.stateManager,
    required super.child,
  });

  static SimpleState of(BuildContext context) {
    final StateProvider? result =
        context.dependOnInheritedWidgetOfExactType<StateProvider>();
    assert(result != null, 'No StateProvider found in context');
    return result!.stateManager;
  }

  void _updateContext(BuildContext context) {
    stateManager._context = context;
  }

  @override
  bool updateShouldNotify(StateProvider oldWidget) {
    return stateManager != oldWidget.stateManager;
  }
}

class StateBuilder extends StatefulWidget {
  final SimpleState stateManager;
  final Widget Function(BuildContext, SimpleState) builder;

  const StateBuilder({
    super.key,
    required this.stateManager,
    required this.builder,
  });

  @override
  State<StateBuilder> createState() => _StateBuilderState();
}

class _StateBuilderState extends State<StateBuilder> {
  @override
  void initState() {
    super.initState();
    widget.stateManager.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType<StateProvider>()?._updateContext(context);
  }

  @override
  void didUpdateWidget(covariant StateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stateManager != oldWidget.stateManager) {
      oldWidget.stateManager.removeListener(() {
        if (mounted) {
          setState(() {});
        }
      });
      widget.stateManager.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    widget.stateManager.removeListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.stateManager);
  }
}

class StateHelper {
  final SimpleState _stateManager;
  final BuildContext _context;

  StateHelper(this._stateManager, this._context);

  T? getState<T>(String key, {T? defaultValue}) =>
      _stateManager.getState<T>(key, defaultValue: defaultValue);

  void setState<T>(String key, T value) =>
      _stateManager.setState(_context, key, value);
}

extension StateContext on BuildContext {
  SimpleState get stateManager => StateProvider.of(this);

  StateHelper get state => StateHelper(stateManager, this);

  T? getState<T>(String key, {T? defaultValue}) =>
      stateManager.getState<T>(key, defaultValue: defaultValue);

  void setState<T>(String key, T value) =>
      stateManager.setState(this, key, value);
}
