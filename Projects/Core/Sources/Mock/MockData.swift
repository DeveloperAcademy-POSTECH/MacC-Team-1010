//
//  MockData.swift
//  Core
//
//  Created by Kim SungHun on 5/15/24.
//  Copyright © 2024 com.teamten. All rights reserved.
//

import Foundation

// MARK: - FeatureHome

let FetchNewMakListMockData = Data (
 """
 {
 "makNumber": 14,
 "makName": "아지 막걸리",
 "makType": "탁주",
 "makImageNumber": "1068",
 "mainDetail": {
 "makAlcoholPercentage": 6.0,
 "makVolume": 750,
 "makPrice": 1200.0
 },
 "taste": {
 "makTasteSweet": 1.0,
 "makTasteSour": 2.0,
 "makTasteThick": 2.0,
 "makTasteFresh": 1.0
 }
 }
 """.utf8
)

let FetchRecentCommentsMockData = Data (
 """
 {
 "makNumber": 14,
 "makName": "인천 생 소성주",
 "makType": "탁주",
 "makImageNumber": "1068",
 "mainDetail": {
 "makAlcoholPercentage": 6.0,
 "makVolume": 750,
 "makPrice": 1200.0
 },
 "taste": {
 "makTasteSweet": 1.0,
 "makTasteSour": 2.0,
 "makTasteThick": 2.0,
 "makTasteFresh": 1.0
 }
 }
 """.utf8
)

// MARK: - FeatureOnboarding

let CheckNicknameMockData = Data (
 """
 {
 "isSuccess": true,
 "message": "사용 가능한 닉네임 입니다."
 }
 """.utf8
)
