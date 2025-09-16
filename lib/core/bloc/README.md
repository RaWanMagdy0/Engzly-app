# BlocObserver

This directory contains the custom BlocObserver for the Engzly app.

## Files

- `bloc_observer.dart` - Custom BlocObserver implementation
- `index.dart` - Export file for easier imports

## Usage

The `AppBlocObserver` is automatically set up in `main.dart` and will log all Bloc/Cubit activities when running in debug mode.

### What it logs:

1. **onCreate** - When a Bloc/Cubit is created
2. **onChange** - When the state changes (for Cubits)
3. **onEvent** - When an event is added to a Bloc
4. **onTransition** - When a Bloc transitions from one state to another
5. **onError** - When an error occurs in a Bloc/Cubit
6. **onClose** - When a Bloc/Cubit is closed

### Example Output:

```
onCreate -- LoginCubit
onChange -- LoginCubit, Change
  Current State: LoginInitial
  Next State: LoginLoading
onChange -- LoginCubit, Change
  Current State: LoginLoading
  Next State: LoginSuccess
```

### Benefits:

- **Debugging**: Easily track state changes and events
- **Performance**: Only logs in debug mode, no impact on release builds
- **Comprehensive**: Covers all Bloc lifecycle events
- **Customizable**: Easy to modify logging behavior

## Customization

You can modify the `AppBlocObserver` to:
- Add custom logging formats
- Filter specific Bloc types
- Add analytics tracking
- Integrate with external logging services
