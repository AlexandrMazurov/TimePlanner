// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#15b2e3"></span>
  /// Alpha: 100% <br/> (0x15b2e3ff)
  internal static let buttonHighlited = ColorName(rgbaValue: 0x15b2e3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#25bee0"></span>
  /// Alpha: 100% <br/> (0x25bee0ff)
  internal static let buttonNormal = ColorName(rgbaValue: 0x25bee0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#beccdc"></span>
  /// Alpha: 100% <br/> (0xbeccdcff)
  internal static let disabled = ColorName(rgbaValue: 0xbeccdcff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#feebf0"></span>
  /// Alpha: 100% <br/> (0xfeebf0ff)
  internal static let errorBackground = ColorName(rgbaValue: 0xfeebf0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff023f"></span>
  /// Alpha: 100% <br/> (0xff023fff)
  internal static let errorText = ColorName(rgbaValue: 0xff023fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#92a9c3"></span>
  /// Alpha: 100% <br/> (0x92a9c3ff)
  internal static let textFieldBorderColor = ColorName(rgbaValue: 0x92a9c3ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
