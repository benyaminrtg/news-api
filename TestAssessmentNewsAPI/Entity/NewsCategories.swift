//
//  NewsCategories.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation

class NewsCategory {
    var categories: [String] = [
        "Business",
        "Entertainment",
        "General",
        "Health",
        "Science",
        "Sports",
        "Technology"
    ]
}

enum NewsCategories: String {
    case business = "business"
    
}
