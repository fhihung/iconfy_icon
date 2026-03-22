/// Category groupings for flat SVG icons.
enum IconfyCategory {
  ai,
  airpod,
  alert,
  arrow,
  arrowActions,
  audio,
  banking,
  bathWc,
  bookmark,
  brands,
  building,
  calendarDate,
  call,
  chartAnalytics,
  christmas,
  cloud,
  computerTv,
  cryptocurrency,
  database,
  delivery,
  design,
  development,
  devices,
  documentation,
  eCommerce,
  editor,
  electricity,
  email,
  emoji,
  essential,
  fashion,
  files,
  filterSetting,
  financial,
  food,
  fruitVegetables,
  game,
  gridsLayout,
  halloween,
  handGesture,
  health,
  heartLove,
  home,
  homeAppliances,
  kitchen,
  laundry,
  location,
  math,
  message,
  mobile,
  nature,
  network,
  numbers,
  petsAnimal,
  photo,
  reward,
  schoolLearning,
  search,
  security,
  server,
  shape,
  shopping,
  spaceGalaxy,
  sport,
  star,
  symbols,
  ticketTag,
  time,
  transport,
  travel,
  user,
  videoMovie,
  weather,
  web,
  wifi;

  /// Human-readable display name.
  String get displayName => switch (this) {
    IconfyCategory.ai => 'AI',
    IconfyCategory.airpod => 'Airpod',
    IconfyCategory.alert => 'Alert',
    IconfyCategory.arrow => 'Arrow',
    IconfyCategory.arrowActions => 'Arrow Actions',
    IconfyCategory.audio => 'Audio',
    IconfyCategory.banking => 'Banking',
    IconfyCategory.bathWc => 'Bath & WC',
    IconfyCategory.bookmark => 'Bookmark',
    IconfyCategory.brands => 'Brands',
    IconfyCategory.building => 'Building',
    IconfyCategory.calendarDate => 'Calendar & Date',
    IconfyCategory.call => 'Call',
    IconfyCategory.chartAnalytics => 'Chart & Analytics',
    IconfyCategory.christmas => 'Christmas',
    IconfyCategory.cloud => 'Cloud',
    IconfyCategory.computerTv => 'Computer & TV',
    IconfyCategory.cryptocurrency => 'Cryptocurrency',
    IconfyCategory.database => 'Database',
    IconfyCategory.delivery => 'Delivery',
    IconfyCategory.design => 'Design',
    IconfyCategory.development => 'Development',
    IconfyCategory.devices => 'Devices',
    IconfyCategory.documentation => 'Documentation',
    IconfyCategory.eCommerce => 'E-Commerce',
    IconfyCategory.editor => 'Editor',
    IconfyCategory.electricity => 'Electricity',
    IconfyCategory.email => 'Email',
    IconfyCategory.emoji => 'Emoji',
    IconfyCategory.essential => 'Essential',
    IconfyCategory.fashion => 'Fashion',
    IconfyCategory.files => 'Files',
    IconfyCategory.filterSetting => 'Filter & Setting',
    IconfyCategory.financial => 'Financial',
    IconfyCategory.food => 'Food',
    IconfyCategory.fruitVegetables => 'Fruit & Vegetables',
    IconfyCategory.game => 'Game',
    IconfyCategory.gridsLayout => 'Grids & Layout',
    IconfyCategory.halloween => 'Halloween',
    IconfyCategory.handGesture => 'Hand Gesture',
    IconfyCategory.health => 'Health',
    IconfyCategory.heartLove => 'Heart & Love',
    IconfyCategory.home => 'Home',
    IconfyCategory.homeAppliances => 'Home Appliances',
    IconfyCategory.kitchen => 'Kitchen',
    IconfyCategory.laundry => 'Laundry',
    IconfyCategory.location => 'Location',
    IconfyCategory.math => 'Math',
    IconfyCategory.message => 'Message',
    IconfyCategory.mobile => 'Mobile',
    IconfyCategory.nature => 'Nature',
    IconfyCategory.network => 'Network',
    IconfyCategory.numbers => 'Numbers',
    IconfyCategory.petsAnimal => 'Pets & Animal',
    IconfyCategory.photo => 'Photo',
    IconfyCategory.reward => 'Reward',
    IconfyCategory.schoolLearning => 'School & Learning',
    IconfyCategory.search => 'Search',
    IconfyCategory.security => 'Security',
    IconfyCategory.server => 'Server',
    IconfyCategory.shape => 'Shape',
    IconfyCategory.shopping => 'Shopping',
    IconfyCategory.spaceGalaxy => 'Space & Galaxy',
    IconfyCategory.sport => 'Sport',
    IconfyCategory.star => 'Star',
    IconfyCategory.symbols => 'Symbols',
    IconfyCategory.ticketTag => 'Ticket & Tag',
    IconfyCategory.time => 'Time',
    IconfyCategory.transport => 'Transport',
    IconfyCategory.travel => 'Travel',
    IconfyCategory.user => 'User',
    IconfyCategory.videoMovie => 'Video & Movie',
    IconfyCategory.weather => 'Weather',
    IconfyCategory.web => 'Web',
    IconfyCategory.wifi => 'WiFi',
  };
}

/// Style variants for flat SVG icons.
enum IconfyStyle {
  bold,
  bulk,
  light,
  outline,
  twoTone,
  broken,
}

/// Type variants for flat SVG icons.
enum IconfyType {
  regular,
  sharp,
  curved,
}

/// Data class representing a flat SVG icon.
///
/// The [svgContent] field contains the full SVG markup as an inline string,
/// enabling Dart's tree-shaking to eliminate unused icons from the final bundle.
class IconfyIconData {
  /// Display name of the icon.
  final String name;

  /// Inline SVG content (tree-shakeable).
  final String svgContent;

  /// Category the icon belongs to.
  final IconfyCategory category;

  /// Visual style of the icon.
  final IconfyStyle style;

  /// Type variant of the icon.
  final IconfyType type;

  const IconfyIconData({
    required this.name,
    required this.svgContent,
    required this.category,
    required this.style,
    required this.type,
  });

  @override
  String toString() => 'IconfyIconData($name, $category, $style, $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconfyIconData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          style == other.style &&
          type == other.type;

  @override
  int get hashCode => Object.hash(name, category, style, type);
}
