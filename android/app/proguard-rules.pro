# Flutter default keep rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.view.** { *; }
-dontwarn io.flutter.embedding.**

# Prevent obfuscation issues with Stripe SDK
-dontwarn com.reactnativestripesdk.**
-keep class com.reactnativestripesdk.** { *; }

# Keep React Native references used by Stripe
-dontwarn com.facebook.react.**
-keep class com.facebook.react.** { *; }

# Optional: prevent stripping some metadata
-keepattributes *Annotation*
