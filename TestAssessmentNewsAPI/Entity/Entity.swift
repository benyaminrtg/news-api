//
//  Entity.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation

struct User: Codable {
    let name: String
}

struct Source: Codable {
    let id: String?
    let name: String
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct ArticleModel: Codable {
    let articles: [Article]
}

struct Status: Codable {
    let status: String
    let code: String
    let message: String
}

struct SourceDetailModel: Codable {
    let sources: [SourceDetail]
}

struct SourceDetail: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}
