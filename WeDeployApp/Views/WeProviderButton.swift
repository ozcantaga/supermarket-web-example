//
//  WeProviderButton.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy

@IBDesignable open class WeProviderButton : UIButton {

	@IBInspectable open var providerName: String? = "github"

	open var provider: AuthProvider.Provider?

	open override var isEnabled: Bool {
		didSet {
			enabledChanged()
		}
	}

	override public init(frame: CGRect) {
		super.init(frame: frame)

		initalize()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}

	open override func awakeFromNib() {
		super.awakeFromNib()

		initalize()
	}

	open func initalize() {
		guard let provider = AuthProvider.Provider(rawValue: providerName!) else {
			print("wrong provider name")
			return
		}
		self.provider = provider
		let providerSettings = provider.providerSettings

		backgroundColor = providerSettings.color

		setTitle(providerSettings.icon, for: .normal)
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont(name: "loop-icons-12px", size: 24)

		layer.cornerRadius = 4
	}

	func enabledChanged() {
		if !isEnabled {
			setTitle("\u{E04E}", for: .normal)
			backgroundColor = UIColor(59, 88, 152, 0.6)
		}
		else {
			initalize()
		}
	}

}

extension AuthProvider.Provider {

	var providerSettings: (color: UIColor, icon: String) {
		switch self {
		case .facebook:
			return (.FacebookColor, "\u{E052}")
		case .github:
			return (.GithubColor, "\u{E04C}")
		case .google:
			return (.GoogleColor, "\u{E025}")
		}
	}
}
