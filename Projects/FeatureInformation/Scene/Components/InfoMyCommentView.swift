//
//  InfoMyCommentView.swift
//  FeatureInformation
//
//  Created by Eric Lee on 11/4/23.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core
import DesignSystem

struct InfoMyCommentView: View {
	@ObservedObject var viewModel: InformationViewModel
	
    var body: some View {
		VStack(spacing: 6) {
			
			//Header
			HStack {
				Text("내 코멘트")
				Spacer()
				if var myComment = viewModel.makHoly?.myComment {
					Button(action: {
						myComment.isVisible.toggle()
					}, label: {
						Text(myComment.isVisible ? "전체 공개" : "비공개")
					})
				}
			}
			
			//Comment Description
			if let myComment = viewModel.makHoly?.myComment {
				Text(myComment.contents)
			} else {
				
				Text("터치해서 코멘트를 남겨보세요!")
					.font(.style(.SF14R))
					.foregroundColor(Color(uiColor: .designSystem(.w85)!))
					
					.padding(.vertical, 16)
				
			}
			
			if let myComment = viewModel.makHoly?.myComment {
				HStack {
					Text("\(myComment.date)")
					Spacer()
					Button(action: {
						// 수정 모달 Sheet 활성화
						viewModel.showActionSheet.toggle()
					}, label: {
						Text("수정")
							.font(.style(.SF12R))
							.foregroundColor(Color(uiColor: .designSystem(.primary)!))
					})
				}
			}
			
		}
    }
}