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
	public class func fontMaterialDesignIcons(ofSize fontSize: CGFloat) -> UIFont? {
		return MaterialDesignIcons.font(ofSize: fontSize)
	}
	
}

/// A protocol to provide font's file name, extension and font name.
/// This protocol can be used to any icon fonts, such as FontAwsome etc.
public protocol FontIconProcotol {
	/// Font file name in the bundle.
	static var fontFilename: String { get }
	/// Font file extension name, e.g. ttf.
	static var fontFileExtension: String { get }
	/// Font name. Use Font Book app to install the font, select "Show Font Info" 
	/// from "View" menu, the value of "PostScript name" is the font name to be used in Xcode.
	static var fontName: String { get }
	/// RawValue of the Enum type.
	var rawValue: String { get }
}

extension FontIconProcotol {

	/// Get a UIFont object by the provided font information of this protocol.
	/// - parameter fontSize: The preferred font size.
	/// - returns: A UIFont object.
	public static func font(ofSize fontSize: CGFloat) -> UIFont? {
		if UIFont.fontNames(forFamilyName: fontName).isEmpty {
			FontLoader.loadFont(fontFilename, withExtension: fontFileExtension)
		}
		return UIFont(name: fontName, size: fontSize)
	}
	
	/// Return the string value of the font Enum value's rawValue.
	public var stringValue: String {
		return rawValue.substring(to: rawValue.characters.index(rawValue.startIndex, offsetBy: 1))
	}
	
	/// Convert the font icon to an attributed string.
	/// - parameter textColor: The preferred foreground color, default is .whiteColor()
	/// - parameter fontSize: The preferred font size, default is 24.
	/// - parameter backgroundColor: The preferred background color, default is .clearColor()
	/// - parameter alignment: The preferred alignment, default is .Center
	public func attributedString(
		_ textColor: UIColor = UIColor.white,
		fontSize: CGFloat = 24,
		backgroundColor: UIColor = UIColor.clear,
		alignment: NSTextAlignment = .center) -> NSAttributedString {
		
		let font = Self.font(ofSize: fontSize)
		guard font != nil else {
			return NSAttributedString()
		}
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.alignment = alignment
		
		let attrs = [
			NSFontAttributeName: font!,
			NSForegroundColorAttributeName: textColor,
			NSBackgroundColorAttributeName: backgroundColor,
			NSParagraphStyleAttributeName: paragraph]
		
		let attributedString = NSAttributedString(string: stringValue, attributes: attrs)
		return attributedString
		
	}
	
	/// Convert the font icon to an image.
	/// - parameter textColor: The preferred foreground color, default is .whiteColor()
	/// - parameter size: The preferred image size, default is (24, 24). 
	///                   If the width and height is not equal, use the min value.
	/// - parameter backgroundColor: The preferred background color, default is .clearColor()
	/// - parameter alignment: The preferred alignment, default is .Center
	public func image(
		_ textColor: UIColor = UIColor.white,
		size: CGSize = CGSize(width: 24, height: 24),
		backgroundColor: UIColor = UIColor.clear,
		fontAspectRatio: CGFloat = 1) -> UIImage {
		
		let fontSize = max(1, min(size.width / fontAspectRatio, size.height))
		let attributedString = self.attributedString(
			textColor, fontSize: fontSize, backgroundColor: backgroundColor)
		
		UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
		let rect = CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize)
		attributedString.draw(in: rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image ?? UIImage()
		
	}
	
}

extension MaterialDesignIcons: FontIconProcotol {
	public static var onceToken: Int = 0
	public static var fontFilename: String { return "materialdesignicons-webfont" }
	public static var fontFileExtension: String { return "ttf" }
	public static var fontName: String { return "Material-Design-Icons" }
}

extension UIImageView {
	
	/// Initializes and returns a newly allocated view object with the specified 
	/// frame rectangle and font icon value.
	/// - parameter frame: The frame rectangle for the view, measured in points.
	/// - parameter fontIcon: The font icon value.
	public convenience init(frame: CGRect, fontIcon: FontIconProcotol) {
		self.init(frame: frame)
		setImage(fontIcon)
	}
	
	/// Set the image by specified font icon, with the image view's tintColor, 
	/// frame's size and backgroundColor.
	/// - parameter fontIcon: The font icon value.
	public func setImage(_ fontIcon: FontIconProcotol) {
		image = fontIcon.image(
			tintColor ?? .black,
			size: frame.size,
			backgroundColor: backgroundColor ?? .clear)
	}
	
}

extension UILabel {
	
	/// Initializes and returns a newly allocated view object with the specified 
	/// frame rectangle and font icon value.
	/// - parameter frame: The frame rectangle for the view, measured in points.
	/// - parameter fontIcon: The font icon value.
	public convenience init(frame: CGRect, fontIcon: FontIconProcotol) {
		self.init(frame: frame)
		setAttributedText(fontIcon)
	}
	
	/// Set the attributed text by specified font icon, with the label's tintColor, 
	/// frame's size and backgroundColor.
	/// - parameter fontIcon: The font icon value.
	public func setAttributedText(_ fontIcon: FontIconProcotol) {
		attributedText = fontIcon.attributedString(
			tintColor ?? .black,
			fontSize: font.pointSize,
			backgroundColor: backgroundColor ?? .clear)
	}
	
}
