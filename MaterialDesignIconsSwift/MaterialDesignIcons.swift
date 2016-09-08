//
//  MaterialDesignIcons.swift
//  MaterialDesignIconsSwift
//
//  Created by Bull Xu on 8/09/2016.
//  Copyright © 2016 Stride Solutions. All rights reserved.
//

import Foundation

/// A MaterialDesignIcons extension to UIFont.
public extension UIFont {
	
	/// Get a UIFont object of MaterialDesignIcons.
	///
	/// - parameter fontSize: The preferred font size.
	/// - returns: A UIFont object of MaterialDesignIcons.
	public class func fontMaterialDesignIconsOfSize(fontSize: CGFloat) -> UIFont {
		return MaterialDesignIcons.fontOfSize(fontSize)
	}
	
}

/// A protocol to provide font's file name, extension and font name.
/// This protocol can be used to any icon fonts, such as FontAwsome etc.
public protocol FontIconProcotol {
	/// Font file name in the bundle.
	static var fontFilename: String { get }
	/// Font file extension name, e.g. ttf.
	static var fontFileExtension: String { get }
	/// Font name. Use Font Book app to install the font, select "Show Font Info" from "View" menu, the value of "PostScript name" is the font name to be used in Xcode.
	static var fontName: String { get }
	/// A dispatch_once_t value to use for load the font file once.
	static var onceToken: dispatch_once_t { get set }
	/// RawValue of the Enum type.
	var rawValue: String { get }
}

extension FontIconProcotol {

	/// Get a UIFont object by the provided font information of this protocol.
	/// - parameter fontSize: The preferred font size.
	/// - returns: A UIFont object.
	public static func fontOfSize(fontSize: CGFloat) -> UIFont! {
		if UIFont.fontNamesForFamilyName(fontName).isEmpty {
			dispatch_once(&onceToken) {
				FontLoader.loadFont(fontFilename, withExtension: fontFileExtension)
			}
		}
		return UIFont(name: fontName, size: fontSize)
	}
	
	/// Return the string value of the font Enum value's rawValue.
	public var stringValue: String {
		return rawValue.substringToIndex(rawValue.startIndex.advancedBy(1))
	}
	
	/// Convert the font icon to an attributed string.
	/// - parameter textColor: The preferred foreground color, default is .whiteColor()
	/// - parameter fontSize: The preferred font size, default is 24.
	/// - parameter backgroundColor: The preferred background color, default is .clearColor()
	/// - parameter alignment: The preferred alignment, default is .Center
	public func attributedString(
		textColor: UIColor = UIColor.whiteColor(),
		fontSize: CGFloat = 24,
		backgroundColor: UIColor = UIColor.clearColor(),
		alignment: NSTextAlignment = .Center) -> NSAttributedString {
		
		let font = Self.fontOfSize(fontSize)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = alignment
		
		let attrs = [
			NSFontAttributeName: font,
			NSForegroundColorAttributeName: textColor,
			NSBackgroundColorAttributeName: backgroundColor,
			NSParagraphStyleAttributeName: paragraph]
		
		let attributedString = NSAttributedString(string: stringValue, attributes: attrs)
		return attributedString
		
	}
	
	/// Convert the font icon to an image.
	/// - parameter textColor: The preferred foreground color, default is .whiteColor()
	/// - parameter size: The preferred image size, default is (24, 24). If the width and height is not equal, use the min value.
	/// - parameter backgroundColor: The preferred background color, default is .clearColor()
	/// - parameter alignment: The preferred alignment, default is .Center
	public func image(
		textColor: UIColor = UIColor.whiteColor(),
		size: CGSize = CGSizeMake(24, 24),
		backgroundColor: UIColor = UIColor.clearColor(),
		fontAspectRatio: CGFloat = 1) -> UIImage {
		
		let fontSize = max(1, min(size.width / fontAspectRatio, size.height))
		let attributedString = self.attributedString(textColor, fontSize: fontSize, backgroundColor: backgroundColor)
		
		UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
		attributedString.drawInRect(CGRectMake(0, (size.height - fontSize) / 2, size.width, fontSize))
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image ?? UIImage()
		
	}
	
}

extension MaterialDesignIcons: FontIconProcotol {
	public static var onceToken: dispatch_once_t = 0
	public static var fontFilename: String { return "materialdesignicons-webfont" }
	public static var fontFileExtension: String { return "ttf" }
	public static var fontName: String { return "Material-Design-Icons" }
}