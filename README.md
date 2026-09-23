# LiquidGlassTint

<img width="250" alt="Stripes" src="https://github.com/user-attachments/assets/20b82ac9-e96d-41e8-a523-d9b0099be156" />

<img width="250" alt="Checkerboard" src="https://github.com/user-attachments/assets/b6484bde-7eae-4029-9c08-06f278b8e750" />

<img width="250" alt="image" src="https://github.com/user-attachments/assets/83eb7d7a-206c-41ec-8560-050247bacc14" />



A small SwiftUI test app that shows **tinted Liquid Glass tab bars**, including a tinted search tab. Each tab has a high-contrast, scrollable background, so you can see that the tab bar is still glass after it's been tinted.

## What's inside

| Tab | Background | What it shows |
|-----|------------|---------------|
| **Stripes** | Red / yellow stripes | Refraction along the glass edges |
| **Checkerboard** | Black / white checkerboard | Blur and distortion |
| **Text** | Colored rows of text | Content stays readable but softened under the glass |
| ⭐ **Search** | Rainbow bands | How the tinted search button blends with what's behind it |

Every page scrolls under the tab bar. Scrolling down also triggers `.tabBarMinimizeBehavior(.onScrollDown)`, so you can check the minimized state as well.

## How the tint works

The tint is applied in two places, and both read the same color, **`accent`** from `Assets.xcassets`.

1. **Tab items**: `.tint(Color("accent"))` on the `TabView` sets the tint for the selected tab.
2. **Search tab**: `SearchTabColor` (in `TabTint.swift`) is a small UIKit bridge. It finds the underlying `UITabBarController`, locates the search tab's platter and sets its background to the `accent` color, rounding it into a circle.

## Setting the color

1. Open **Assets → accent** in Xcode.
2. Pick any color you like.
3. Set its **opacity to 50%**.

> **Why 50%?** The transparency keeps the glass effect visible. At 100% the tint covers the glass and the search button looks like a flat, solid circle.


You'll need to add the SF Symbols to the assets folder to prevent the fading of inactivity when the tab is inactive.

## Requirements

- Xcode 26 or later
- iOS 26 or later (Liquid Glass)

## Project structure

```
TabLiquidGlassTint/
├── TabLiquidGlassTintApp.swift   // App entry point
├── ContentView.swift             // TabView, tint and test backgrounds
├── TabTint.swift                 // SearchTabColor: tints the search tab via UIKit
└── Assets.xcassets               // "accent" color set (50% opacity)
```

## ⚠️ Note

`SearchTabColor` works by matching internal UIKit view names (`_UITabBarAuxiliaryView`, `ContentView`). These are private implementation details, so a future iOS update could stop the search tab tint from working. The rest of the app will keep running either way. Test it on each new iOS version, and avoid relying on it in production apps.

## Author

Made by **Jonas Storli**.
