// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Task {
    internal enum Awaiting {
      internal enum Rating {
        /// Awaiting rating
        internal static let title = L10n.tr("Localizable", "task.awaiting.rating.title")
      }
    }
    internal enum Info {
      internal enum Before {
        internal enum Ending {
          /// Before ending
          internal static let title = L10n.tr("Localizable", "task.info.before.ending.title")
        }
      }
    }
    internal enum State {
      internal enum Awaiting {
        /// Awaiting
        internal static let title = L10n.tr("Localizable", "task.state.awaiting.title")
      }
      internal enum Before {
        internal enum Starting {
          /// Before starting
          internal static let title = L10n.tr("Localizable", "task.state.before.starting.title")
        }
      }
      internal enum Completed {
        /// Completed
        internal static let title = L10n.tr("Localizable", "task.state.completed.title")
      }
      internal enum Performed {
        /// Performed
        internal static let title = L10n.tr("Localizable", "task.state.performed.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
