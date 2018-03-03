//
//  MiddleLeftCenter.Individual.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension IndividualProperty {
	
	public struct MiddleLeftCenter {
		
		let middleLeft: LayoutElement.Point
		
		let center: LayoutElement.Horizontal
		
	}
	
}

// MARK: - Make Frame
extension IndividualProperty.MiddleLeftCenter {
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, top: CGFloat) -> CGRect {
		
		let height = (middleLeft.y - top).doubled
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = (bottom - middleLeft.y).doubled
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, height: CGFloat) -> CGRect {
		
		let x = middleLeft.x
		let y = middleLeft.y - height.halved
		let width = (center - middleLeft.x).doubled
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Top
extension IndividualProperty.MiddleLeftCenter: LayoutPropertyCanStoreTopToEvaluateFrameType {
	
	public func evaluateFrame(top: LayoutElement.Vertical, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: parameters)
		let center = self.center.evaluated(from: parameters)
		let top = top.evaluated(from: parameters)
		
		return self.makeFrame(middleLeft: middleLeft, center: center, top: top)
		
	}
	
}

// MARK: Bottom
extension IndividualProperty.MiddleLeftCenter: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: parameters)
		let center = self.center.evaluated(from: parameters)
		let bottom = bottom.evaluated(from: parameters)
		
		return self.makeFrame(middleLeft: middleLeft, center: center, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension IndividualProperty.MiddleLeftCenter: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, parameters: IndividualFrameCalculationParameters) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: parameters)
		let center = self.center.evaluated(from: parameters)
		let width = (center - middleLeft.x).doubled
		let height = height.evaluated(from: parameters, withTheOtherAxis: .width(width))
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
}