# ScreenUtil Integration Guide

This guide explains how to use ScreenUtil in your Engzly app for responsive design.

## What is ScreenUtil?

ScreenUtil is a Flutter package that helps create responsive UIs that work across different screen sizes and densities. It provides utilities for:
- Responsive dimensions (width, height, padding, margin)
- Responsive font sizes
- Responsive border radius
- Device type detection (phone vs tablet)

## Configuration

ScreenUtil is configured in `EngzlyApp` with:
- **Design Size**: 375x812 (iPhone X standard)
- **Text Adaptation**: Enabled for better text scaling
- **Split Screen Support**: Enabled for multi-window support

## Usage Examples

### Basic Responsive Dimensions

```dart
// Using the helper class
Container(
  width: ScreenUtilHelper.responsiveWidth(50), // 50% of screen width
  height: ScreenUtilHelper.responsiveHeight(30), // 30% of screen height
  padding: ScreenUtilHelper.responsivePadding(all: 16),
  margin: ScreenUtilHelper.responsiveMargin(horizontal: 20),
)

// Using ScreenUtil directly
Container(
  width: 200.w, // 200 logical pixels
  height: 100.h, // 100 logical pixels
  padding: EdgeInsets.all(16.r), // 16 logical pixels
)
```

### Responsive Text

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: ScreenUtilHelper.responsiveFontSize(16), // 16.sp
    // or directly: fontSize: 16.sp
  ),
)
```

### Responsive Borders

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: ScreenUtilHelper.responsiveBorderRadius(all: 12),
    // or directly: borderRadius: BorderRadius.circular(12.r)
  ),
)
```

### Device Detection

```dart
if (ScreenUtilHelper.isTablet) {
  // Tablet-specific layout
  return Row(children: [leftPanel, rightPanel]);
} else {
  // Phone-specific layout
  return Column(children: [topPanel, bottomPanel]);
}
```

### Responsive Layouts

```dart
// Responsive grid
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: ScreenUtilHelper.isTablet ? 4 : 2,
    childAspectRatio: ScreenUtilHelper.isTablet ? 1.5 : 1.0,
  ),
  // ... rest of grid
)
```

## Best Practices

1. **Use Logical Pixels**: Always use `.w`, `.h`, `.r` for dimensions
2. **Design for Mobile First**: Start with mobile design, then adapt for tablets
3. **Test on Multiple Devices**: Test your responsive design on different screen sizes
4. **Use Helper Methods**: Use `ScreenUtilHelper` for complex responsive calculations
5. **Avoid Hard-coded Values**: Don't use fixed pixel values, always make them responsive

## Common Patterns

### Responsive Container

```dart
Container(
  width: ScreenUtilHelper.responsiveWidth(90), // 90% of screen width
  height: 200.h,
  padding: ScreenUtilHelper.responsivePadding(
    horizontal: 20,
    vertical: 16,
  ),
  margin: ScreenUtilHelper.responsiveMargin(all: 8),
  decoration: BoxDecoration(
    borderRadius: ScreenUtilHelper.responsiveBorderRadius(all: 16),
    color: Colors.blue,
  ),
)
```

### Responsive Text with Different Sizes

```dart
Text(
  'Title',
  style: TextStyle(
    fontSize: ScreenUtilHelper.isTablet ? 24.sp : 20.sp,
    fontWeight: FontWeight.bold,
  ),
)
```

### Responsive Spacing

```dart
SizedBox(
  height: ScreenUtilHelper.isTablet ? 32.h : 24.h,
)
```

## Migration from Fixed Values

If you have existing code with fixed values, replace them:

```dart
// Before
Container(width: 200, height: 100, padding: EdgeInsets.all(16))

// After
Container(width: 200.w, height: 100.h, padding: EdgeInsets.all(16.r))
```

## Troubleshooting

- **Text too small/large**: Adjust the design size in `EngzlyApp`
- **Layout breaks on tablets**: Use `ScreenUtilHelper.isTablet` for conditional layouts
- **Performance issues**: ScreenUtil calculations are cached, so performance impact is minimal
