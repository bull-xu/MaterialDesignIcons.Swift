//
//  FontLoader.swift
//  MaterialDesignIconsSwift
//
//  Created by Bull Xu on 8/09/2016.
//  Copyright © 2016 Stride Solutions. All rights reserved.
//

import Foundation

/// FontLoad class to load the font file. Code copied from https://github.com/thii/FontAwesome.swift. Thanks to Thi, the author of FontAwesome.swift.
class FontLoader {
	
	class func loadFont(name: String, withExtension ext: String = "ttf") {
		let bundle = NSBundle(forClass: FontLoader.self)
		let identifier = bundle.bundleIdentifier

		let fontURL:NSURL
		if identifier?.hasPrefix("org.cocoapods") == true {
			// If this framework is added using CocoaPods, resources is placed under a subdirectory
			fontURL = bundle.URLForResource(name, withExtension: ext, subdirectory: "MaterialDesignIconsSwift.bundle")!
		} else {
			fontURL = bundle.URLForResource(name, withExtension: ext)!
		}
		
		let data = NSData(contentsOfURL: fontURL)!
		let provider = CGDataProviderCreateWithCFData(data)
		let font = CGFontCreateWithDataProvider(provider)!
		
		var error: Unmanaged<CFError>?
		if !CTFontManagerRegisterGraphicsFont(font, &error) {
			let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
			let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
			NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
		}
	}
	
}