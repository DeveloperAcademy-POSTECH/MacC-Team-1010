//
//  View+.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/09.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI

public extension View {
	dynamic func dismissKeyboard(on gestures: [Gestures] = Gestures.allCases,
															 onDismiss: (() -> Void)? = nil) -> some View {
		return ModifiedContent(content: self,
													 modifier: DismissingKeyboard(gestures: gestures,
																												onDismiss: onDismiss))
	}
}

// MARK: - DismissingKeyboard

private struct DismissingKeyboard: ViewModifier {
	var gestures: [Gestures] = Gestures.allCases
	var onDismiss: (() -> Void)?
	
	private func action() {
		let forcing = true
		let keyWindow = UIApplication.shared.connectedScenes
			.filter({$0.activationState == .foregroundActive})
			.map({$0 as? UIWindowScene})
			.compactMap({$0})
			.first?.windows
			.filter({$0.isKeyWindow}).first
		keyWindow?.endEditing(forcing)
	}
	
	private func handleOnDismiss() {
		action()
		onDismiss?()
	}
	
	dynamic func body(content: Content) -> some View {
		return gestures.reduce(AnyView(content)) { $1.apply(to: $0, perform: handleOnDismiss) }
	}
}

public enum Gestures: Hashable, CaseIterable {
	case tap, longPress, drag, magnification, rotation
}

public protocol ValueGesture: Gesture where Value: Equatable {
	func onChanged(_ action: @escaping (Value) -> Void) -> _ChangedGesture<Self>
}

extension LongPressGesture: ValueGesture {}
extension DragGesture: ValueGesture {}
extension MagnificationGesture: ValueGesture {}
extension RotationGesture: ValueGesture {}

public extension Gestures {
	@discardableResult
	func apply<V>(to view: V, perform voidAction: @escaping () -> Void) -> AnyView where V: View {
		
		func highPrio<G>(
			gesture: G
		) -> AnyView where G: ValueGesture {
			AnyView(view.highPriorityGesture(
				gesture.onChanged { value in
					_ = value
					voidAction()
				}
			))
		}
		
		switch self {
		case .tap:
			return AnyView(view.gesture(TapGesture().onEnded(voidAction)))
		case .longPress: return highPrio(gesture: LongPressGesture())
		case .drag: return highPrio(gesture: DragGesture())
		case .magnification: return highPrio(gesture: MagnificationGesture())
		case .rotation: return highPrio(gesture: RotationGesture())
		}
	}
}
