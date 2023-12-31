//
//  EventName.swift
//  Core
//
//  Created by Eric Lee on 11/26/23.
//  Copyright © 2023 com.teamten. All rights reserved.
//

import Foundation

public enum MPEvent {
	
	case signup
	case requestMakHoly
	case submitSearch
	case informationviewClosed
	case hastagviewClosed
	
	public var title: String {
		switch self {
		case .signup:
			return "Sign_Up"
		case .requestMakHoly:
			return "Request_Makholy"
		case .submitSearch:
			return "Submit_Search"
		case .informationviewClosed:
			return "InformationView_Closed"
		case .hastagviewClosed:
			return "HastagView_Closed"
		}
	}
	
}
