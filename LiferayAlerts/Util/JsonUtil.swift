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
* @author Silvio Santos
* @author Josiane Bezerra
*/
class JsonUtil: NSObject {

	class func toJson(json: String) -> [NSObject: AnyObject] {
		var jsonData: NSData? = json.dataUsingEncoding(NSUTF8StringEncoding)
		var error: NSError?

		var jsonObj = NSJSONSerialization.JSONObjectWithData(
			jsonData!, options:NSJSONReadingOptions(0), error:&error)
			as [NSObject: AnyObject]

		return jsonObj
	}

	class func toString(json: [NSObject: AnyObject]) -> String? {
		var error: NSError?
		let stringData: NSData? = NSJSONSerialization.dataWithJSONObject(json,
			options: NSJSONWritingOptions(0), error: &error)

		return NSString(data: stringData!, encoding: NSUTF8StringEncoding)
	}

}