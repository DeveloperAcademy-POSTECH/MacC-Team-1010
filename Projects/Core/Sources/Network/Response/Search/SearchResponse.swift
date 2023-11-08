//
//  SearchResponse.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/07.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation

public struct SearchResponse: Codable {
	public let status: Int
	public let resultMsg: String
	public let result: [SearchResult]?
}

public struct SearchResult: Codable {
	public let makNumber: Int?
	public let makName: String?
	public let makType: String?
	public let makImageNumber: String?
	public let mainDetail: SearchMainDetail?
	public let taste: SearchTaste?
}

public struct SearchMainDetail: Codable {
	public let makAlcoholPercentage: Int?
	public let makVolume: Int?
	public let makPrice: Int?
}

public struct SearchTaste: Codable {
	public let makTasteSweet: Int?
	public let makTasteSour: Int?
	public let makTasteThick: Int?
	public let makTasteFresh: Int?
}
