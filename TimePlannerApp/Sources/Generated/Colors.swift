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

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3dcf04"></span>
  /// Alpha: 100% <br/> (0x3dcf04ff)
  internal static let averagePriority = ColorName(rgbaValue: 0x3dcf04ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eb6e00"></span>
  /// Alpha: 100% <br/> (0xeb6e00ff)
  internal static let highPriority = ColorName(rgbaValue: 0xeb6e00ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eb1000"></span>
  /// Alpha: 100% <br/> (0xeb1000ff)
  internal static let highestPriority = ColorName(rgbaValue: 0xeb1000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e1e809"></span>
  /// Alpha: 100% <br/> (0xe1e809ff)
  internal static let lowPriority = ColorName(rgbaValue: 0xe1e809ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#09bbe8"></span>
  /// Alpha: 100% <br/> (0x09bbe8ff)
  internal static let lowestPriority = ColorName(rgbaValue: 0x09bbe8ff)
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
