//
//  FontLoader.swift
//  MaterialDesignIconsSwift
//
//  Created by Bull Xu on 8/09/2016.
//  Copyright © 2016 Stride Solutions. All rights reserved.
//

import Foundation

/// FontLoad class to load the font file. 
/// Code copied from https://github.com/thii/FontAwesome.swift. 
// Thanks to Thi, the author of FontAwesome.swift.

internal class FontLoader {
	
	internal class func loadFont(_ name: String, withExtension ext: String = "ttf") {

		let bundle = Bundle(for: FontLoader.self)
		let identifier = bundle.bundleIdentifier

		let fontURL: URL?
		if identifier?.hasPrefix("org.cocoapods") == true {
			// If this framework is added using CocoaPods, resources is placed under a subdirectory
			fontURL = bundle.url(forResource: name,
			                     withExtension: ext, subdirectory: "MaterialDesignIconsSwift.bundle")
		} else {
			fontURL = bundle.url(forResource: name,
			                     withExtension: ext)
		}
		
		guard let url = fontURL,
			let data = try? Data(contentsOf: url),
			let provider = CGDataProvider(data: data as CFData),
			let font = CGFont(provider) else { return }
		
		var error: Unmanaged<CFError>?
		if CTFontManagerRegisterGraphicsFont(font, &error) { return }
		
		if let error = error, let nsError = error.takeUnretainedValue() as AnyObject as? NSError {
			let errorDescription: CFString = CFErrorCopyDescription(error.takeUnretainedValue())
			NSException(name: NSExceptionName.internalInconsistencyException,
			            reason: errorDescription as String,
			            userInfo: [NSUnderlyingErrorKey: nsError]).raise()
		}
		
	}
	
}
