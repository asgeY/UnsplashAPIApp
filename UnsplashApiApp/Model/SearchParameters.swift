//
//  SearchParameters.swift
//  UnsplashApiApp
//
//  Created by Berta Devant on 19/08/2019.
//  Copyright © 2019 Berta Devant. All rights reserved.
//

import Foundation

struct SearchParameters {
    let searchType: SearchType
    let query: String
    let page: Int
}

extension SearchParameters {
    init(query: String) {
        self.query = query
        self.searchType = .photos
        self.page = 1
    }
    
    init(type: SearchType) {
        self.query = ""
        self.searchType = type
        self.page = 1
    }
}

extension SearchParameters {
    func nextPage() -> SearchParameters {
        return SearchParameters(searchType: searchType, query: query, page: page + 1)
    }
}


enum SearchType: String {
    case curated = "/photos/curated"
    case random = "random"
    case photos = "/search/photos"
    case collections = "collections"
    case download = "/photos"
}
