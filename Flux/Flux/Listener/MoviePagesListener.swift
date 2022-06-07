//
//  MoviePagesListener.swift
//  FluxCore
//
//  Created by ExecutionLab's Macbook on 03/06/2022.
//

import Foundation

class MoviesPagesListener {
    var currentPage: Int = 1 {
        didSet {
            loadPage()
        }
    }
    
    func loadPage() {
        
    }
}
