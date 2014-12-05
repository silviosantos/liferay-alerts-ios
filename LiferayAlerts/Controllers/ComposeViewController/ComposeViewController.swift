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
class ComposeViewController: UIViewController {

	override init() {
		super.init(nibName:"ComposeViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		messageTextView.becomeFirstResponder()
	}

	@IBAction func backButtonAction() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	@IBAction func createButtonAction() {
		let message = messageTextView.text

		var payload = [String: String]()
		payload["message"] = message
		payload["type"] = AlertType.TEXT.rawValue

		PushNotificationsEntryServiceUtil.addPushNotificationsEntry(
			JsonUtil.toString(payload)!)

		println(payload)
	}

	@IBOutlet weak var messageTextView: UITextView!
}