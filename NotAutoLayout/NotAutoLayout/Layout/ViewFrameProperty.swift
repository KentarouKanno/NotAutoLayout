//
//  ViewFrameProperty.swift
//  NotAutoLayout
//
//  Created by 史　翔新 on 2017/09/13.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct ViewFrameProperty {
	
	private(set) weak var parentView: UIView?
	
}

extension ViewFrameProperty {
	
	public var bounds: CGRect {
		
		return self.parentView?.bounds ?? .zero
		
	}
	
	public var contentsArea: CGRect {
		
		return self.bounds.inside(self.layoutMarginInsets)
		
	}
	
	@available(iOS 11.0, *)
	public var safeArea: CGRect {
		
		return self.bounds.inside(self.safeAreaInsets)
		
	}
	
}

extension ViewFrameProperty {
	
	public var layoutMarginInsets: UIEdgeInsets {
		
		return self.parentView?.layoutMargins ?? .zero
		
	}
	
	@available(iOS 11.0, *)
	public var safeAreaInsets: UIEdgeInsets {
		
		return self.parentView?.safeAreaInsets ?? .zero
		
	}
	
}

extension ViewFrameProperty {
	
	public func boundHorizontal(at relativePosition: CGFloat) -> CGFloat {
		return self.bounds.left + (self.bounds.width * relativePosition)
	}
	
	public func boundVertical(at relativePosition: CGFloat) -> CGFloat {
		return self.bounds.top + (self.bounds.height * relativePosition)
	}
	
	public func boundPoint(at relativePoint: CGPoint) -> CGPoint {
		let x = self.boundHorizontal(at: relativePoint.x)
		let y = self.boundVertical(at: relativePoint.y)
		return .init(x: x, y: y)
	}
	
}

extension ViewFrameProperty {
	
	@available(iOS 11.0, *)
	public var topSafeAreaInset: CGFloat {
		return self.safeAreaInsets.top
	}
	
	@available(iOS 11.0, *)
	public var bottomSafeAreaInset: CGFloat {
		return self.safeAreaInsets.bottom
	}
	
	@available(iOS 11.0, *)
	public var leftSafeAreaInset: CGFloat {
		return self.safeAreaInsets.left
	}
	
	@available(iOS 11.0, *)
	public var rightSafeAreaInset: CGFloat {
		return self.safeAreaInsets.right
	}
	
}

extension ViewFrameProperty {
	
	@available(iOS 11.0, *)
	public func safeHorizontal(at relativePosition: CGFloat) -> CGFloat {
		return self.safeArea.left + (self.safeArea.width * relativePosition)
	}
	
	@available(iOS 11.0, *)
	public func safeVertical(at relativePosition: CGFloat) -> CGFloat {
		return self.safeArea.top + (self.safeArea.height * relativePosition)
	}
	
	@available(iOS 11.0, *)
	public func safePoint(at relativePoint: CGPoint) -> CGPoint {
		let x = self.safeHorizontal(at: relativePoint.x)
		let y = self.safeVertical(at: relativePoint.y)
		return .init(x: x, y: y)
	}
	
}

extension ViewFrameProperty {
	
	func size(for view: UIView, thatFits fittingSize: CGSize) -> CGSize {
		
		let fittedSize = view.sizeThatFits(fittingSize)
		
		return fittedSize
		
	}
	
}

extension ViewFrameProperty {
	
	func evaluateSize(from calculation: (ViewFrameProperty) -> CGSize) -> CGSize {
		
		return calculation(self)
		
	}
	
	func evaluateSize(for view: UIView, from aspect: LayoutElement.Size.AspectSizing) -> CGSize {
		
		let canvasSize = { (safeAreaOnly: Bool) -> CGSize in
			switch safeAreaOnly {
			case true:
				if #available(iOS 11.0, *) {
					return self.safeArea.size
				} else {
					fallthrough
				}
				
			case false:
				return self.bounds.size
			}
		}(aspect.safeAreaOnly)
		
		let targetRatio = aspect.ratio ?? { (targetView: UIView?) in
			return targetView?.sizeThatFits(.zero).ratio
		}(view) ?? 1
		
		guard targetRatio.isNaN == false,
			canvasSize.ratio.isNaN == false
		else {
			return canvasSize
		}
		
		switch aspect {
		case .fit, .safeAreaFit:
			return CGSize.aspectFitSize(in: canvasSize, with: targetRatio)
			
		case .fill, .safeAreaFill:
			return CGSize.aspectFillSize(in: canvasSize, with: targetRatio)
		}
		
	}
	
}
