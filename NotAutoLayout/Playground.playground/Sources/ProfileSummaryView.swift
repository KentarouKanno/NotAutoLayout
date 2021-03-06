import UIKit
import NotAutoLayout

private let margin: CGFloat = 10

public class ProfileSummaryView: UIView {
	
	private let avatarView: UIImageView
	private let mainTitleLabel: UILabel
	private let subTitleLabel: UILabel
	
	public var avatar: UIImage? {
		get {
			return self.avatarView.image
		}
		set {
			self.avatarView.image = newValue
		}
	}
	
	public var mainTitle: String? {
		get {
			return self.mainTitleLabel.text
		}
		set {
			self.mainTitleLabel.text = newValue
		}
	}
	
	public var subTitle: String? {
		get {
			return self.subTitleLabel.text
		}
		set {
			self.subTitleLabel.text = newValue
		}
	}
	
	public override init(frame: CGRect) {
		
		self.avatarView = UIImageView()
		self.mainTitleLabel = UILabel()
		self.subTitleLabel = UILabel()
		
		super.init(frame: frame)
		
		self.setupAvatarView()
		self.setupMainTitleView()
		self.setupSubTitleView()
		
	}
	
	public convenience init() {
		self.init(frame: .zero)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		self.placeAvatarView()
		self.placeMainTitleView()
		self.placeSubTitleView()
	}
	
}

extension ProfileSummaryView {
	
	private func setupAvatarView() {
		
		let view = self.avatarView
		view.backgroundColor = .red
		view.clipsToBounds = true
		self.addSubview(view)
		
	}
	
	private func setupMainTitleView() {
		
		let view = self.mainTitleLabel
		view.clipsToBounds = true
		view.font = .boldSystemFont(ofSize: UIFont.smallSystemFontSize)
		view.textColor = .black
		self.addSubview(view)
		
	}
	
	private func setupSubTitleView() {
		
		let view = self.subTitleLabel
		view.clipsToBounds = true
		view.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
		view.textColor = .darkGray
		self.addSubview(view)
		
	}
	
}

extension ProfileSummaryView {
	
	private func placeAvatarView() {
		
		self.nal.layout(self.avatarView) { $0
			.setTopLeft(by: { $0.safeTopLeft })
			.setSize(by: { let length = min($0.safeWidth, $0.safeHeight); return .init(width: length, height: length) })
			.movingX(by: margin)
			.addingProcess(by: { (view, frame, _) in
				view.layer.cornerRadius = min(frame.width, frame.height) / 2
			})
		}
		
	}
	
	private func placeMainTitleView() {
		
		self.nal.layout(self.mainTitleLabel, by: { $0
			.pinTopLeft(to: self.avatarView, s: .topRight)
			.setRight(by: { $0.safeRight - margin })
			.setBottom(by: { $0.safeMiddle })
			.pinchingLeft(by: margin)
		})
		
	}
	
	private func placeSubTitleView() {
		
		self.nal.layout(self.subTitleLabel) { $0
			.pinTopLeft(to: self.mainTitleLabel, s: .bottomLeft)
			.pinRight(to: self.mainTitleLabel, s: .right)
			.setBottom(by: { $0.safeTop + ($0.safeBottom - $0.safeTop) * 0.75 })
		}
		
	}
	
}
