//
//  TabMenuView.swift
//  FeatureEncyclopedia
//
//  Created by 박지은 on 2023/11/02.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core

public struct EncyclopediaView: View {
    @StateObject var viewModel = EncyclopediaViewModel(userRepository: DefaultUserRepository())
    
    @State private var selectedPicker: headerType = .all
    
    @Namespace private var animation
    
    enum headerType: String, CaseIterable {
        case all = "전체"
        case like = "좋았어요"
        case dislike = "아쉬워요"
        case bookmark = "찜"
        case comment = "코멘트"
    }
    
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView()
                BodyView(selectedType: selectedPicker)
                Spacer()
            }
            .navigationTitle("내 막걸리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color.DarkBase,
                for: .tabBar, .navigationBar
            )
            .background(Color.DarkBase)
        }
    }
}

private extension EncyclopediaView {
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            ForEach(headerType.allCases, id: \.self) { item in
                ZStack(alignment: .bottom) {
                    VStack {
                        Text(item.rawValue)
                            .SF14R()
                            .frame(maxWidth: .infinity/5, minHeight: 42)
                            .foregroundColor(.White)
                    }
                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.Lilac)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "id", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.selectedPicker = item
                    }
                }
            }
        }
        .background(Color.DarkBase)
    }
    
    @ViewBuilder
    func BodyView(selectedType: headerType) -> some View {
        switch selectedType {
        case .all:
            AllView()
                .background(Color.DarkBase)
        case .like:
            LikeView()
                .background(Color.DarkBase)
        case .dislike:
            DislikeView()
                .background(Color.DarkBase)
        case .bookmark:
            BookmarkView()
                .background(Color.DarkBase)
        case .comment:
            CommentView()
                .background(Color.DarkBase)
        }
    }
}
