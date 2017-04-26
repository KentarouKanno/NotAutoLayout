//
//  LayoutPosition.swift
//  NotAutoLayout
//
//  Created by 史　翔新 on 2017/02/22.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public enum LayoutPosition {
	
	public enum Individual {
		
		public typealias SizeToFrame = (CGSize) -> Frame
		public typealias FitSizeBoundSizeToFrame = (_ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		public typealias SizeToPoint = (CGSize) -> CGPoint
		public typealias SizeToSize = (CGSize) -> CGSize
		public typealias SizeToFloat = (CGSize) -> CGFloat
		
		case absolute(Frame)
		case relative(Frame)
		
		case insets(UIEdgeInsets)
		
		case customByFrame(frame: SizeToFrame)
		case customByOriginSize(origin: SizeToPoint, size: SizeToSize)
		case customByXYWidthHeight(x: SizeToFloat, y: SizeToFloat, width: SizeToFloat, height: SizeToFloat)
		
		case customFitsSizeByFrame(fittingSize: CGSize, frame: FitSizeBoundSizeToFrame)
		
	}
	
	public enum Sequential {
		
		public typealias SizeToFrame = (CGSize) -> Frame
		public typealias PreviousFrameAndSizeToFrame = (_ previousFrame: CGRect, _ boundSize: CGSize) -> Frame
		
		public typealias FitSizeBoundSizeToFrame = (_ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		public typealias PreviousFrameFitSizeAndSizeToFrame = (_ previousFrame: CGRect, _ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		
		case horizontallyEqualSizedAbsolute(initial: Frame, margin: CGFloat)
		case verticallyEqualSizedAbsolute(initial: Frame, margin: CGFloat)
		
		case horizontallyEqualSizedRelative(initial: Frame, margin: CGFloat)
		case verticallyEqualSizedRelative(initial: Frame, margin: CGFloat)
		
		case customByFrame(initial: SizeToFrame, rest: PreviousFrameAndSizeToFrame)
		
		case customFitsSizeByFrame(fittingSize: CGSize, initial: FitSizeBoundSizeToFrame, rest: PreviousFrameFitSizeAndSizeToFrame)
		
	}
	
	public enum Matrical {
		
		public typealias SizeToFrame = (CGSize) -> Frame
		public typealias PreviousColFrameAndSizeToFrame = (_ previousColFrame: CGRect, _ boundSize: CGSize) -> Frame
		public typealias PreviousRowFrameAndSizeToFrame = (_ previousRowFrame: CGRect, _ boundSize: CGSize) -> Frame
		public typealias PreviousRowColFrameAndSizeToFrame = (_ previousRowFrame: CGRect, _ previousColFrame: CGRect, _ boundSize: CGSize) -> Frame
		
		public typealias FitSizeBoundSizeToFrame = (_ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		public typealias PreviousColFrameFitSizeAndSizeToFrame = (_ previousColFrame: CGRect, _ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		public typealias PreviousRowFrameFitSizeAndSizeToFrame = (_ previousRowFrame: CGRect, _ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		public typealias PreviousRowColFrameFitSizeAndSizeToFrame = (_ previousRowFrame: CGRect, _ previousColFrame: CGRect, _ fitSize: CGSize, _ boundSize: CGSize) -> Frame
		
		case horizontallyEqualSizedAbsolute(initial: Frame, margin: CGVector)
		case verticallyEqualSizedAbsolute(initial: Frame, margin: CGVector)
		
		case horizontallyEqualSizedRelative(initial: Frame, margin: CGVector)
		case verticallyEqualSizedRelative(initial: Frame, margin: CGVector)
		
		case customByFrame(initial: SizeToFrame, firstInCol: PreviousColFrameAndSizeToFrame, firstInRow: PreviousRowFrameAndSizeToFrame, rest: PreviousRowColFrameAndSizeToFrame)
		
		case customFitsSizeByFrame(fittingSize: CGSize, initial: FitSizeBoundSizeToFrame, firstInCol: PreviousColFrameFitSizeAndSizeToFrame, firstInRow: PreviousRowFrameFitSizeAndSizeToFrame, rest: PreviousRowColFrameFitSizeAndSizeToFrame)
		
	}
	
	case individual(Individual)
	case sequential(Sequential)
	case matrical(Matrical)
	
}

extension LayoutPosition {
	
	var isSequential: Bool {
		switch self {
		case .sequential:
			return true
			
		case _:
			return false
		}
	}
	
	var isMatrical: Bool {
		switch self {
		case .matrical:
			return true
			
		case _:
			return false
		}
	}
	
}

extension LayoutPosition {
	
	public static func makeAbsolute(frame: Frame) -> LayoutPosition {
		return .individual(.absolute(frame))
	}
	
	public static func makeAbsolute(frame: CGRect) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: frame.origin, size: frame.size)
		return makeAbsolute(frame: layoutFrame)
	}
	
	public static func makeRelative(frame: Frame) -> LayoutPosition {
		return .individual(.relative(frame))
	}
	
	public static func makeRelative(frame: CGRect) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: frame.origin, size: frame.size)
		return makeRelative(frame: layoutFrame)
	}
	
	public static func makeInsets(insets: UIEdgeInsets) -> LayoutPosition {
		return .individual(.insets(insets))
	}
	
	public static func makeCustom(frame: @escaping Individual.SizeToFrame) -> LayoutPosition {
		return .individual(.customByFrame(frame: frame))
	}
	
	public static func makeCustom(origin: @escaping Individual.SizeToPoint, size: @escaping Individual.SizeToSize) -> LayoutPosition {
		return .individual(.customByOriginSize(origin: origin, size: size))
	}
	
	public static func makeCustom(x: @escaping Individual.SizeToFloat, y: @escaping Individual.SizeToFloat, width: @escaping Individual.SizeToFloat, height: @escaping Individual.SizeToFloat) -> LayoutPosition {
		return .individual(.customByXYWidthHeight(x: x, y: y, width: width, height: height))
	}
	
	public static func makeCustome(thatFits fittingSize: CGSize, frame: @escaping Individual.FitSizeBoundSizeToFrame) -> LayoutPosition {
		return .individual(.customFitsSizeByFrame(fittingSize: fittingSize, frame: frame))
	}
	
}

extension LayoutPosition.Sequential {
	
	public enum Direction {
		case horizontal
		case vertical
	}
	
}

extension LayoutPosition {
	
	public static func makeAbsolute(initialFrame: Frame, margin: CGFloat, direction: LayoutPosition.Sequential.Direction) -> LayoutPosition {
		switch direction {
		case .horizontal:
			return .sequential(.horizontallyEqualSizedAbsolute(initial: initialFrame, margin: margin))
			
		case .vertical:
			return .sequential(.verticallyEqualSizedAbsolute(initial: initialFrame, margin: margin))
		}
	}
	
	public static func makeAbsolute(initialFrame: CGRect, margin: CGFloat, direction: LayoutPosition.Sequential.Direction) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: initialFrame.origin, size: initialFrame.size)
		return makeAbsolute(initialFrame: layoutFrame, margin: margin, direction: direction)
	}
	
	public static func makeRelative(initialFrame: Frame, margin: CGFloat, direction: LayoutPosition.Sequential.Direction) -> LayoutPosition {
		switch direction {
		case .horizontal:
			return .sequential(.horizontallyEqualSizedRelative(initial: initialFrame, margin: margin))
			
		case .vertical:
			return .sequential(.verticallyEqualSizedRelative(initial: initialFrame, margin: margin))
		}
	}
	
	public static func makeRelative(initialFrame: CGRect, margin: CGFloat, direction: LayoutPosition.Sequential.Direction) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: initialFrame.origin, size: initialFrame.size)
		return makeRelative(initialFrame: layoutFrame, margin: margin, direction: direction)
	}
	
	public static func makeCustom(initialFrame: @escaping Sequential.SizeToFrame, restFrame: @escaping Sequential.PreviousFrameAndSizeToFrame) -> LayoutPosition {
		return .sequential(.customByFrame(initial: initialFrame, rest: restFrame))
	}
	
	public static func makeCustom(thatFits fittingSize: CGSize, initialFrame: @escaping Sequential.FitSizeBoundSizeToFrame, restFrame: @escaping Sequential.PreviousFrameFitSizeAndSizeToFrame) -> LayoutPosition {
		return .sequential(.customFitsSizeByFrame(fittingSize: fittingSize, initial: initialFrame, rest: restFrame))
	}
	
}

extension LayoutPosition.Matrical {
	
	public enum Direction {
		case horizontal
		case vertical
	}
	
}

extension LayoutPosition {
	
	public static func makeAbsolute(initialFrame: Frame, margin: CGVector, direction: LayoutPosition.Matrical.Direction) -> LayoutPosition {
		switch direction {
		case .horizontal:
			return .matrical(.horizontallyEqualSizedAbsolute(initial: initialFrame, margin: margin))
			
		case .vertical:
			return .matrical(.verticallyEqualSizedAbsolute(initial: initialFrame, margin: margin))
		}
	}
	
	public static func makeAbsolute(initialFrame: CGRect, margin: CGVector, direction: LayoutPosition.Matrical.Direction) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: initialFrame.origin, size: initialFrame.size)
		return makeAbsolute(initialFrame: layoutFrame, margin: margin, direction: direction)
	}
	
	public static func makeRelative(initialFrame: Frame, margin: CGVector, direction: LayoutPosition.Matrical.Direction) -> LayoutPosition {
		switch direction {
		case .horizontal:
			return .matrical(.horizontallyEqualSizedRelative(initial: initialFrame, margin: margin))
			
		case .vertical:
			return .matrical(.verticallyEqualSizedRelative(initial: initialFrame, margin: margin))
		}
	}
	
	public static func makeRelative(initialFrame: CGRect, margin: CGVector, direction: LayoutPosition.Matrical.Direction) -> LayoutPosition {
		let layoutFrame = Frame(reference: .topLeft, origin: initialFrame.origin, size: initialFrame.size)
		return makeRelative(initialFrame: layoutFrame, margin: margin, direction: direction)
	}
	
	public static func makeCustom(initialFrame: @escaping Matrical.SizeToFrame, firstInColFrame: @escaping Matrical.PreviousColFrameAndSizeToFrame, firstInRowFrame: @escaping Matrical.PreviousRowFrameAndSizeToFrame, restFrame: @escaping Matrical.PreviousRowColFrameAndSizeToFrame) -> LayoutPosition {
		return .matrical(.customByFrame(initial: initialFrame, firstInCol: firstInColFrame, firstInRow: firstInRowFrame, rest: restFrame))
	}
	
	public static func makeCustom(thatFits fittingSize: CGSize, initialFrame: @escaping Matrical.FitSizeBoundSizeToFrame, firstInColFrame: @escaping Matrical.PreviousColFrameFitSizeAndSizeToFrame, firstInRowFrame: @escaping Matrical.PreviousRowFrameFitSizeAndSizeToFrame, restFrame: @escaping Matrical.PreviousRowColFrameFitSizeAndSizeToFrame) -> LayoutPosition {
		return .matrical(.customFitsSizeByFrame(fittingSize: fittingSize, initial: initialFrame, firstInCol: firstInColFrame, firstInRow: firstInRowFrame, rest: restFrame))
	}
	
}
