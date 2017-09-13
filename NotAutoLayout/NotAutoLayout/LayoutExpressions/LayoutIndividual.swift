//
//  LayoutIndividual.swift
//  NotAutoLayout
//
//  Created by 史　翔新 on 2017/06/16.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

extension Layout {
	
	public struct Individual {
		
		fileprivate enum Frame {
			case constant(CGRect)
			case basicEvaluation((_ layoutProperty: LayoutProperty) -> CGRect)
			case fittingEvaluation((_ fittedSize: (_ fittingSize: CGSize) -> CGSize, _ layoutProperty: LayoutProperty) -> CGRect)
		}
		
		private var basicFrameEvaluation: Frame
		
		private var additionalEvaluations: [FrameAdditionalEvaluation]
		
		private init(frame: CGRect) {
			self.basicFrameEvaluation = Frame.constant(frame)
			self.additionalEvaluations = []
		}
		
		private init(evaluation: @escaping (_ layoutProperty: LayoutProperty) -> CGRect) {
			self.basicFrameEvaluation = Frame.basicEvaluation(evaluation)
			self.additionalEvaluations = []
		}
		
		private init(evaluation: @escaping (_ fittedSize: (_ fittingSize: CGSize) -> CGSize, _ layoutProperty: LayoutProperty) -> CGRect) {
			self.basicFrameEvaluation = Frame.fittingEvaluation(evaluation)
			self.additionalEvaluations = []
		}
		
		private init(x: @escaping (LayoutProperty) -> CGFloat, y: @escaping (LayoutProperty) -> CGFloat, width: @escaping (LayoutProperty) -> CGFloat, height: @escaping (LayoutProperty) -> CGFloat) {
			
			let frame: (LayoutProperty) -> CGRect = { layoutProperty in
				let frame = CGRect(x: x(layoutProperty),
				                   y: y(layoutProperty),
				                   width: width(layoutProperty),
				                   height: height(layoutProperty))
				return frame
			}
			
			self.basicFrameEvaluation = Frame.basicEvaluation(frame)
			self.additionalEvaluations = []
			
		}
		
	}
	
}

extension Layout.Individual {
	
	static func makeAbsolute(frame: CGRect) -> Layout.Individual {
		let layout = Layout.Individual(frame: frame)
		return layout
	}
	
	static func makeCustom(x: @escaping (LayoutProperty) -> CGFloat, y: @escaping (LayoutProperty) -> CGFloat, width: @escaping (LayoutProperty) -> CGFloat, height: @escaping (LayoutProperty) -> CGFloat) -> Layout.Individual {
		let layout = Layout.Individual(x: x, y: y, width: width, height: height)
		return layout
	}
	
	static func makeCustom(frame: @escaping (LayoutProperty) -> CGRect) -> Layout.Individual {
		let layout = Layout.Individual(evaluation: frame)
		return layout
	}
	
	static func makeCustom(frame: @escaping (_ fittedSize: (_ fittingSize: CGSize) -> CGSize, _ layoutProperty: LayoutProperty) -> CGRect) -> Layout.Individual {
		let layout = Layout.Individual(evaluation: frame)
		return layout
	}
	
}

extension Layout.Individual {
	
	func addingAdditionalEvaluation(_ evaluation: FrameAdditionalEvaluation) -> Layout.Individual {
		
		var layout = self
		layout.additionalEvaluations.append(evaluation)
		
		return layout
		
	}
	
	mutating func addAdditionalEvaluation(_ evaluation: FrameAdditionalEvaluation) {
		
		self = self.addingAdditionalEvaluation(evaluation)
		
	}
	
}

extension Layout.Individual {
	
	func settingAdditionalEvaluations(to evaluations: [FrameAdditionalEvaluation]) -> Layout.Individual {
		
		var layout = self
		layout.additionalEvaluations = evaluations
		
		return layout
		
	}
	
	mutating func setAdditionalEvaluations(_ evaluations: [FrameAdditionalEvaluation]) {
		
		self = self.settingAdditionalEvaluations(to: evaluations)
		
	}
	
}

extension Layout.Individual {
	
	func evaluatedFrame(for view: UIView, fittedBy fitting: (_ fittingSize: CGSize) -> CGSize, with layoutProperty: LayoutProperty) -> CGRect {
		
		var frame = self.basicFrameEvaluation.frame(fittedBy: fitting, with: layoutProperty)
		
		for evaluation in self.additionalEvaluations {
			frame = evaluation.evaluated(for: view, from: frame, with: layoutProperty)
		}
		
		return frame
		
	}
	
}

extension Layout.Individual.Frame {
	
	func frame(fittedBy fitting: (_ fittingSize: CGSize) -> CGSize, with layoutProperty: LayoutProperty) -> CGRect {
		
		switch self {
		case .constant(let frame):
			return frame
			
		case .basicEvaluation(let frame):
			return frame(layoutProperty)
			
		case .fittingEvaluation(let frame):
			return frame(fitting, layoutProperty)
		}
		
	}
	
}
