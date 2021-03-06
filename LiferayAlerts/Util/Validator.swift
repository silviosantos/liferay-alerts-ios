/**
* Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/

/**
* @author Josiane Bezerra
*/
class Validator: NSObject {

	class func isEmailAddress(emailAddress: String) -> Bool {
		let pattern = "[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*" +
			"+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:-*[a-zA-" +
			"Z0-9])?\\.*)+"

		let regex: NSRegularExpression = NSRegularExpression(pattern: pattern,
			options: NSRegularExpressionOptions(0), error: nil)!

		let matches = regex.matchesInString(emailAddress,
			options: NSMatchingOptions(0), range: NSMakeRange(
				0, countElements(emailAddress)))

		if(matches.count == 0) {
			return false
		}

		return true
	}

	class func isNull(var string: String?) -> Bool {
		if (string == nil || string!.isEmpty) {
			return true
		}

		let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
		string = string!.stringByTrimmingCharactersInSet(whitespace)

		if (string!.isEmpty) {
			return true
		}

		return false
	}

}