//
//  String.swift
//  XLProjectName
//
//  Created by Diego Ernst on 9/7/16.
//  Copyright © 2016 'XLOrganizationName'. All rights reserved.
//

import Foundation

extension String {

    public func getBase64EncodedData()-> String? {
		let utf8str = self.data(using: String.Encoding.utf8)

		if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
		{
			return base64Encoded
		}
		return nil
    }
}
