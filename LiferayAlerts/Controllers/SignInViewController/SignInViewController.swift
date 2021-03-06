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
class SignInViewController: UIViewController, UITextFieldDelegate {

	override init() {
		super.init(nibName:"SignInViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		loginTextField.becomeFirstResponder()
		self._updateSiginInButton()
	}

	@IBAction func editingChanged() {
		self._updateSiginInButton()
	}

	@IBAction func signInAction() {
		let login = loginTextField.text
		let password = passwordTextField.text

		MBProgressHUD.showHUDAddedTo(view, animated: true)

		let operation = SignInOperation(login: login, password: password) {
			(user, error) -> Void in

			MBProgressHUD.hideHUDForView(self.view, animated: true)

			if (error == nil) {
				SettingsUtil.setUser(user!)

				self.navigationController!.pushViewController(
					MainViewController(), animated: true)
			}
			else {
				var window: UIWindow =
					UIApplication.sharedApplication().keyWindow!

				var hud = MBProgressHUD.showHUDAddedTo(window, animated: true)

				hud.labelText = error!.description

				hud.mode = MBProgressHUDModeText
				hud.hide(true, afterDelay:1.5)
			}
		}

		queue.addOperation(operation)
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if (textField.tag == UIDimensions.SIGN_IN_LOGIN_TEXT_FIELD) {
			passwordTextField.becomeFirstResponder()
		}
		else if (textField.tag == UIDimensions.SIGN_IN_PASSWORD_TEXT_FIELD) {
			self.signInAction()
		}

		return true
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		super.touchesBegan(touches, withEvent: event)
		let touch: UITouch = touches.anyObject()! as UITouch
		let view = touch.view

		if(view.tag == UIDimensions.SIGN_IN_BUTTON_TAG) {
			view.alpha = 0.5
		}
	}

	override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
		super.touchesEnded(touches, withEvent: event)
		let touch: UITouch = touches.anyObject()! as UITouch
		let view = touch.view

		if(view.tag == UIDimensions.SIGN_IN_BUTTON_TAG) {
			view.alpha = 1.0
		}
	}

	func _updateSiginInButton() {
		let hasLogin = !Validator.isNull(loginTextField.text);
		let hasPassword = !Validator.isNull(passwordTextField.text);

		if (hasLogin && hasPassword) {
			signInLabel.alpha = 1.0
			signInLabel.userInteractionEnabled = true
		}
		else {
			signInLabel.alpha = 0.3
			signInLabel.userInteractionEnabled = false
		}
	}

	lazy var queue: NSOperationQueue = {
		var queue = NSOperationQueue()
		queue.maxConcurrentOperationCount = 1

		return queue
	}()

	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signInLabel: UILabel!

}