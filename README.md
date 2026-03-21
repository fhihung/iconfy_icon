# iconfy_icon

Iconly Pro flat SVG icons for Flutter — **tree-shakeable**, type-safe, and zero-config.

Only the icons you actually reference in code get bundled into your app.

---

## Features

| Feature | Description |
|---|---|
| 🌲 Tree-shakeable | Unused icons are removed at compile time |
| 🎨 6 styles | `bold` · `bulk` · `light` · `outline` · `twoTone` · `broken` |
| ✏️ 3 types | `regular` · `sharp` · `curved` |
| 📦 75 categories | From `essential` to `spaceGalaxy` — thousands of icons |
| 🔤 Type-safe API | Full autocompletion with chained getters |
| ♿ Accessible | Built-in semantic labels |

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  iconfy_icon:
    git:
      url: https://github.com/fhihung/iconfy_icon.git
```

Then run:

```bash
flutter pub get
```

---

## Usage

### Import

```dart
import 'package:iconfy_icon/iconfy_icon.dart';
```

### Basic — Display an Icon

```dart
IconfyIconWidget(
  IconfyIcons.essential.home.bold.regular,
  size: 24,
  color: Colors.blue,
)
```

### Access Pattern

```
IconfyIcons.<category>.<iconName>.<style>.<type>
```

**Example paths:**

```dart
IconfyIcons.essential.home.bold.regular      // Home — bold, regular
IconfyIcons.essential.search.outline.sharp   // Search — outline, sharp
IconfyIcons.arrow.left.light.curved          // Arrow Left — light, curved
IconfyIcons.weather.sun.twoTone.regular      // Sun — two-tone, regular
IconfyIcons.user.profile.broken.regular      // Profile — broken, regular
IconfyIcons.shopping.cart.bulk.sharp          // Cart — bulk, sharp
```

### Customize Size

```dart
IconfyIconWidget(
  IconfyIcons.essential.notification.bold.regular,
  size: 32,
)
```

### Customize Color

```dart
IconfyIconWidget(
  IconfyIcons.essential.heart.outline.regular,
  color: Colors.red,
)
```

### Fit & Semantic Label

```dart
IconfyIconWidget(
  IconfyIcons.essential.setting.light.curved,
  size: 48,
  fit: BoxFit.cover,
  semanticLabel: 'Settings',
)
```

### Use the Data Object Directly

`IconfyIconData` holds raw SVG content and metadata — useful if you want to render icons yourself:

```dart
final icon = IconfyIcons.essential.home.bold.regular;

print(icon.name);       // "Home"
print(icon.category);   // "Essential"
print(icon.style);      // IconfyStyle.bold
print(icon.type);       // IconfyType.regular
print(icon.svgContent); // "<svg ...>...</svg>"
```

---

## API Reference

### `IconfyIconWidget`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `icon` | `IconfyIconData` | **required** | The icon to render (positional) |
| `size` | `double` | `24` | Width and height in logical pixels |
| `color` | `Color?` | `null` | Colorizes the SVG via `BlendMode.srcIn` |
| `fit` | `BoxFit` | `BoxFit.contain` | How to inscribe the icon |
| `semanticLabel` | `String?` | `icon.name` | Accessibility label |

### `IconfyIconData`

| Property | Type | Description |
|---|---|---|
| `name` | `String` | Display name (e.g. `"Home"`) |
| `svgContent` | `String` | Inline SVG markup |
| `category` | `String` | Category name (e.g. `"Essential"`) |
| `style` | `IconfyStyle` | `bold` · `bulk` · `light` · `outline` · `twoTone` · `broken` |
| `type` | `IconfyType` | `regular` · `sharp` · `curved` |

### `IconfyStyle` enum

`bold`, `bulk`, `light`, `outline`, `twoTone`, `broken`

### `IconfyType` enum

`regular`, `sharp`, `curved`

---

## Icon Categories

<details>
<summary>All 75 categories (click to expand)</summary>

| Category | Accessor |
|---|---|
| AI | `IconfyIcons.ai` |
| Airpod | `IconfyIcons.airpod` |
| Alert | `IconfyIcons.alert` |
| Arrow | `IconfyIcons.arrow` |
| Arrow Actions | `IconfyIcons.arrowActions` |
| Audio | `IconfyIcons.audio` |
| Banking | `IconfyIcons.banking` |
| Bath & WC | `IconfyIcons.bathWc` |
| Bookmark | `IconfyIcons.bookmark` |
| Brands | `IconfyIcons.brands` |
| Building | `IconfyIcons.building` |
| Calendar & Date | `IconfyIcons.calendarDate` |
| Call | `IconfyIcons.call` |
| Chart & Analytics | `IconfyIcons.chartAnalytics` |
| Christmas | `IconfyIcons.christmas` |
| Cloud | `IconfyIcons.cloud` |
| Computer & TV | `IconfyIcons.computerTv` |
| Cryptocurrency | `IconfyIcons.cryptocurrency` |
| Database | `IconfyIcons.database` |
| Delivery | `IconfyIcons.delivery` |
| Design | `IconfyIcons.design` |
| Development | `IconfyIcons.development` |
| Devices | `IconfyIcons.devices` |
| Documentation | `IconfyIcons.documentation` |
| E-Commerce | `IconfyIcons.eCommerce` |
| Editor | `IconfyIcons.editor` |
| Electricity | `IconfyIcons.electricity` |
| Email | `IconfyIcons.email` |
| Emoji | `IconfyIcons.emoji` |
| Essential | `IconfyIcons.essential` |
| Fashion | `IconfyIcons.fashion` |
| Files | `IconfyIcons.files` |
| Filter & Setting | `IconfyIcons.filterSetting` |
| Financial | `IconfyIcons.financial` |
| Food | `IconfyIcons.food` |
| Fruit & Vegetables | `IconfyIcons.fruitVegetables` |
| Game | `IconfyIcons.game` |
| Grids & Layout | `IconfyIcons.gridsLayout` |
| Halloween | `IconfyIcons.halloween` |
| Hand Gesture | `IconfyIcons.handGesture` |
| Health | `IconfyIcons.health` |
| Heart & Love | `IconfyIcons.heartLove` |
| Home | `IconfyIcons.home` |
| Home Appliances | `IconfyIcons.homeAppliances` |
| Kitchen | `IconfyIcons.kitchen` |
| Laundry | `IconfyIcons.laundry` |
| Location | `IconfyIcons.location` |
| Math | `IconfyIcons.math` |
| Message | `IconfyIcons.message` |
| Mobile | `IconfyIcons.mobile` |
| Nature | `IconfyIcons.nature` |
| Network | `IconfyIcons.network` |
| Numbers | `IconfyIcons.numbers` |
| Pets & Animal | `IconfyIcons.petsAnimal` |
| Photo | `IconfyIcons.photo` |
| Reward | `IconfyIcons.reward` |
| School & Learning | `IconfyIcons.schoolLearning` |
| Search | `IconfyIcons.search` |
| Security | `IconfyIcons.security` |
| Server | `IconfyIcons.server` |
| Shape | `IconfyIcons.shape` |
| Shopping | `IconfyIcons.shopping` |
| Space & Galaxy | `IconfyIcons.spaceGalaxy` |
| Sport | `IconfyIcons.sport` |
| Star | `IconfyIcons.star` |
| Symbols | `IconfyIcons.symbols` |
| Ticket & Tag | `IconfyIcons.ticketTag` |
| Time | `IconfyIcons.time` |
| Transport | `IconfyIcons.transport` |
| Travel | `IconfyIcons.travel` |
| User | `IconfyIcons.user` |
| Video & Movie | `IconfyIcons.videoMovie` |
| Weather | `IconfyIcons.weather` |
| Web | `IconfyIcons.web` |
| Wifi | `IconfyIcons.wifi` |

</details>

---

## How It Works

1. SVG files live in `assets/flat/<Category>/` organized by icon name, style, and type
2. `tool/generate.dart` reads all SVGs and inlines them as `const` strings in generated `.g.dart` files
3. Dart's tree-shaking eliminates any `IconfyIconData` constants that aren't referenced in your code
4. `IconfyIconWidget` renders the inline SVG at runtime using `flutter_svg`

No asset bundling config needed — SVGs are embedded in Dart source code.

---

## Re-Generating Icons

If you add or modify SVGs in `assets/flat/`:

```bash
dart run tool/generate.dart
```

---

## Dependencies

| Package | Purpose |
|---|---|
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | Renders inline SVG strings |

---

## License

See [LICENSE](LICENSE) for details.
