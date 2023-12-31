//
//  MakgeolliLikesAndCommentResponse.swift
//  Core
//
//  Created by Kim SungHun on 2023/11/06.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import Foundation

public struct MakLikesAndCommentsResponse: Codable {
	public let status: Int
	public let resultMsg: String?
	public let result: MakLikesAndCommentsResult?
}

public struct MakLikesAndCommentsResult: Codable {
	public let content: [MakLikeCommentContent]?
	public let pageable: MakLikesAndCommentsPageable?
	public let totalPages, totalElements: Int?
	public let last: Bool?
	public let size, number: Int?
	public let sort: MakLikesAndCommentsSort?
	public let numberOfElements: Int?
	public let first, empty: Bool?
	
	public func toEntity() -> (LikeDetail, [VisibleComment]) {
		
		if let content = content?[0] {
			let result = content
			return (result.toEntity())
		}
		
		return (LikeDetail(), [])
	}
}

public struct MakLikeCommentContent: Codable {
	public let makEvaluateInfo: MakEvaluateInfo?
	public let comments : [VisibleCommentResponse]?
	
	public func toEntity() -> (LikeDetail, [VisibleComment]) {
		let likeDetail = makEvaluateInfo?.toEntity ?? LikeDetail()
		var visibleComments: [VisibleComment] = []
		if let comments = comments {
			visibleComments = comments.compactMap { $0.toEntity }
		}
		return (likeDetail, visibleComments)
	}
}

public struct MakEvaluateInfo: Codable {
	public let totalEvaluateCounts: Int?
	public let likeCounts: Int?
	public let dislikeCounts: Int?
	
	public var toEntity: LikeDetail {
		let totalCount = totalEvaluateCounts ?? 0
		let likeCount = likeCounts ?? 0
		let dislikeCount = dislikeCounts ?? (totalCount - likeCount)
		return LikeDetail(totalCount: totalCount, likeCount: likeCount, dislikeCount: dislikeCount)
	}
}


public struct VisibleCommentResponse: Codable {
	public let userNickName: String?
	public let userLikeOrNot: String?
	public let contents: String?
	public let writeDate: String?
	
	public var toEntity: VisibleComment {
		let userName = userNickName ?? ""
		
		var likeState: LikeState = .none
		if let userLikeOrNot = userLikeOrNot {
			if userLikeOrNot == "Y" {
				likeState = .like
			} else {
				likeState = .dislike
			}
		}
		let content = contents ?? ""
		let date = writeDate ?? ""
		return VisibleComment(userName: userName, isLiked: likeState, content: content, date: date)
	}
}

public struct MakLikesAndCommentsPageable: Codable {
	public let pageNumber, pageSize: Int?
	public let sort: MakLikesAndCommentsSort?
	public let offset: Int?
	public let paged, unpaged: Bool?
}

public struct MakLikesAndCommentsSort: Codable {
	public let empty, sorted, unsorted: Bool?
}
