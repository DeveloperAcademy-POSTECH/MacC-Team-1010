//
//  InformationViewModel.swift
//  FeatureInformation
//
//  Created by Eric Lee on 11/4/23.
//  Copyright © 2023 com.tenten. All rights reserved.
//

import SwiftUI
import Core
import Utils

final class InformationViewModel: ObservableObject {
	
	let makHolyId: Int
	let userId: Int = Int(KeyChainManager.shared.read(account: .userId)) ?? -1
	let maHolyRepo: DefaultMakgeolliRepository
	let userRepo: DefaultUserRepository
	
	var currentOffset: Int = 0
	var isLastPage = false
	
	var mpParameters: MPInfoClosedEventParameters
	
	init(makHolyId: Int,
		 maHolyRepo: DefaultMakgeolliRepository,
		 userRepo: DefaultUserRepository,
		 mpParameters: MPInfoClosedEventParameters) {
		self.makHolyId = makHolyId
		self.maHolyRepo = maHolyRepo
		self.userRepo = userRepo
		self.mpParameters = mpParameters
	}
	
	@Published var errorState = false
	@Published var isFetchCompleted: Bool = false
	@Published var makHoly: MakHoly = MakHoly()
	@Published var myReaction: MyReaction = MyReaction()
	@Published var likeDetail: LikeDetail = LikeDetail()
	@Published var comments: [VisibleComment] = []
	
	@Published var showActionSheet: Bool = false
	@Published var showCommentSheet: Bool = false
	@Published var showDetailCommentListSheet: Bool = false
	@Published var showDeleteAlert: Bool = false
	@Published var commentText: String = ""
	
	private var user: User = User.user1
	
	@MainActor
	func fetchDatas() {
		Task {
			await withTaskGroup(of: Void.self) { group in
				group.addTask {
					await self.fetchMakHoly()
				}
				group.addTask {
					await self.fetchReactions()
				}
				
				for _ in 0..<2 {
					await group.next()
				}
				
				isFetchCompleted = true
			}
		}
	}
	
	@MainActor
	func fetchMakHoly() {
		Task {
			do {
				let result = try await maHolyRepo.fetchDetail(makNumber: self.makHolyId,
															  userId: self.userId)
				self.makHoly = result.0
				self.myReaction = result.1
				print("fetchMakHoly Completed : -------")
				print("makHoly : \(makHoly)")
				print("myReaction : \(myReaction)")
				print("----------------------------------")
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -fetchMakHoly()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func fetchReactions(offset: Int = 0) {
		Task {
			do {
				let response = try await maHolyRepo.fetchMakLikesAndComments(
					makNumber: self.makHolyId,
					offset: offset
				)
				if offset == 0 {
					self.comments = []
					self.likeDetail = response.result?.toEntity().0 ?? LikeDetail()
					self.comments = response.result?.toEntity().1 ?? []
				} else {
					self.comments.append(contentsOf: response.result?.toEntity().1 ?? [])
				}
				self.isLastPage = response.result?.last ?? true
				self.currentOffset = response.result?.pageable?.offset ?? 0
				print("fetchReactions Completed : -------")
				print("likeDetail : \(likeDetail)")
				print("comments : \(comments)")
				print("----------------------------------")
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -fetchReactions()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func toggleCommentVisible() {
		
		self.myReaction.comment?.isVisible.toggle()
		
		guard let comment = myReaction.comment else {
			return
		}
		Task {
			do {
				let response = try await userRepo.updateComment(
					UpdateCommentRequest(
						userId: self.userId,
						makNumber: self.makHolyId,
						contents: comment.contents,
						isVisible: comment.isVisible))
				
				if response.result?.isSuccess == true {
					if comment.isVisible == true {
						mpParameters.editCommentVisible += 1
					} else {
						mpParameters.editCommentInvisible += 1
					}
				} else {
					self.myReaction.comment?.isVisible.toggle()
					errorState = true
				}
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -toggleCommentVisible()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func likeButtonTapped() {
		switch self.myReaction.likeState {
		case .like:
			self.myReaction.likeState = .none
		default:
			self.myReaction.likeState = .like
		}
	}
	
	@MainActor
	func dislikeButtonTapped() {
		switch self.myReaction.likeState {
		case .dislike:
			self.myReaction.likeState = .none
		default:
			self.myReaction.likeState = .dislike
		}
	}
	
	@MainActor
	func postLikeState(from: LikeState) {
		Task {
			do {
				let response = try await userRepo.evaluateMak(EvaluateMakRequest(
					userId: self.userId,
					makNumber: self.makHolyId,
					likeState: self.myReaction.likeState))
				switch myReaction.likeState {
				case .none:
					if from == .like {
						MixpanelManager.shared.decreaseUserCount(property: .like)
						mpParameters.deleteLikeCount += 1
					} else {
						MixpanelManager.shared.decreaseUserCount(property: .dislike)
						mpParameters.deleteDisLikeCount += 1
					}
				case .like:
					if from == .dislike {
						MixpanelManager.shared.decreaseUserCount(property: .dislike)
					}
					MixpanelManager.shared.increaseUserCount(property: .like)
					mpParameters.addLikeCount += 1
				case .dislike:
					if from == .like {
						MixpanelManager.shared.decreaseUserCount(property: .like)
					}
					MixpanelManager.shared.increaseUserCount(property: .dislike)
					mpParameters.addDisLikeCount += 1
				}
				
				print("postLikeState Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -postLikeState()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func toggleBookMark() {
		myReaction.isBookMarked.toggle()
		if self.myReaction.isBookMarked {
			addBookMark()
		} else {
			deleteBookMark()
		}
	}
	
	@MainActor
	func addBookMark() {
		Task {
			do {
				let response = try await userRepo.addWishList(WishListRequest(
					userId: self.userId, makNumber: self.makHolyId)
				)
				print("addBookMark Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
				if response.result?.isSuccess == false {
					myReaction.isBookMarked.toggle()
					errorState = true
					return
				}
				MixpanelManager.shared.increaseUserCount(property: .bookmark)
				mpParameters.addBookmarkCount += 1
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -addBookMark()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func deleteBookMark() {
		Task {
			do {
				let response = try await userRepo.deleteWishList(WishListRequest(
					userId: self.userId, makNumber: self.makHolyId)
				)
				print("deleteBookMark Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
				if response.result?.isSuccess == false {
					myReaction.isBookMarked.toggle()
					errorState = true
					return
				}
				MixpanelManager.shared.decreaseUserCount(property: .bookmark)
				mpParameters.deleteBookmarkCount += 1
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -deleteBookMark()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func deleteComment() {
		Task {
			do {
				let response = try await userRepo.deleteComment(DeleteCommentRequest(
					userId: self.userId, makNumber: self.makHolyId)
				)
				print("deleteComment Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
				
				if response.result?.isSuccess == true {
					self.myReaction.comment = nil
					MixpanelManager.shared.decreaseUserCount(property: .comment)
					mpParameters.deleteCommentCount += 1
				} else {
					errorState = true
				}
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -deleteComment()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func updateComment(myComment: MyComment) {
		Task {
			do {
				let response = try await userRepo.updateComment(
					UpdateCommentRequest(
						userId: self.userId,
						makNumber: self.makHolyId,
						contents: myComment.contents,
						isVisible: myComment.isVisible))
				if response.result?.isSuccess == true {
					self.myReaction.comment = myComment
					mpParameters.editCommentCount += 1
				} else {
					errorState = true
				}
				print("deleteComment Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -deleteComment()")
				errorState = true
			}
		}
	}
	
	@MainActor
	func insertComment(myComment: MyComment) {
		Task {
			do {
				let response = try await userRepo.insertComment(InsertCommentRequest(
					userId: self.userId, makNumber: self.makHolyId,
					contents: myComment.contents, isVisible: myComment.isVisible)
				)
				if response.result?.isSuccess == true {
					MixpanelManager.shared.increaseUserCount(property: .comment)
					mpParameters.addCommentCount += 1
					let result = try await maHolyRepo.fetchDetail(makNumber: self.makHolyId,
																  userId: self.userId)
					self.myReaction = result.1
				} else {
					errorState = true
				}
				print("deleteComment Completed : -------")
				print("response : \(response)")
				print("----------------------------------")
			} catch {
				Logger.debug(error: error, message: "InformationViewModel -deleteComment()")
				errorState = true
			}
		}
	}
}
