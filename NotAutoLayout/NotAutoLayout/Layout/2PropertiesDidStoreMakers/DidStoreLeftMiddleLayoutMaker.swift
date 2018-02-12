//
//  DidStoreLeftMiddleLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreLeftMiddleLayoutProperty {
	
	let left: LayoutElement.Horizontal
	
	let middle: LayoutElement.Vertical
	
}

// MARK: - Make Frame
extension DidStoreLeftMiddleLayoutProperty {
	
	private func makeFrame(left: CGFloat, middle: CGFloat, size: CGSize) -> CGRect {
		
		let top = middle - size.height.halved
		let origin = CGPoint(x: left, y: top)
		let size = size
		let frame = CGRect(origin: origin, size: size)
		
		return frame
		
	}
	
}

// MARK: - Set A Size -
// MARK: Size
extension DidStoreLeftMiddleLayoutProperty: LayoutPropertyCanStoreSizeToEvaluateFrameType {
	
	public func evaluateFrame(size: LayoutElement.Size, property: ViewFrameProperty) -> CGRect {
		
		let left = self.left.evaluated(from: property)
		let middle = self.middle.evaluated(from: property)
		let size = size.evaluated(from: property)
		
		return self.makeFrame(left: left, middle: middle, size: size)
		
	}
	
}

// MARK: - Set A Line -
// MARK: Bottom
extension DidStoreLeftMiddleLayoutProperty: LayoutPropertyCanStoreBottomType {
	
	public typealias WillSetBottomProperty = DidStoreLeftMiddleBottomLayoutProperty
	
	public func storeBottom(_ bottom: LayoutElement.Vertical, to maker: LayoutMaker<DidStoreLeftMiddleLayoutProperty>) -> LayoutMaker<DidStoreLeftMiddleBottomLayoutProperty> {
		
		let leftMiddleBottom = DidStoreLeftMiddleBottomLayoutProperty(left: self.left,
																	  middle: self.middle,
																	  bottom: bottom)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftMiddleBottom)
		
		return maker
		
	}
	
}

// MARK: - Set A Length -
// MARK: Width
extension DidStoreLeftMiddleLayoutProperty: LayoutPropertyCanStoreWidthType {
	
	public typealias WillSetWidthProperty = DidStoreLeftMiddleWidthLayoutProperty
	
	public func storeWidth(_ width: LayoutElement.Length, to maker: LayoutMaker<DidStoreLeftMiddleLayoutProperty>) -> LayoutMaker<DidStoreLeftMiddleWidthLayoutProperty> {
		
		let leftMiddleWidth = DidStoreLeftMiddleWidthLayoutProperty(left: self.left,
																	middle: self.middle,
																	width: width)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftMiddleWidth)
		
		return maker
		
	}
	
}

// MARK: Height
extension DidStoreLeftMiddleLayoutProperty: LayoutPropertyCanStoreHeightType {
	
	public typealias WillSetHeightProperty = DidStoreLeftMiddleHeightLayoutProperty
	
	public func storeHeight(_ height: LayoutElement.Length, to maker: LayoutMaker<DidStoreLeftMiddleLayoutProperty>) -> LayoutMaker<DidStoreLeftMiddleHeightLayoutProperty> {
		
		let leftMiddleHeight = DidStoreLeftMiddleHeightLayoutProperty(left: self.left,
																	  middle: self.middle,
																	  height: height)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftMiddleHeight)
		
		return maker
		
	}
	
}