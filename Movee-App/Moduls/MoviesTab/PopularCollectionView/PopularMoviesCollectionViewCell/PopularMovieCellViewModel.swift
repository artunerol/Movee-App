//
//  PopularMovieCellViewModel.swift
//  Movee-App
//
//  Created by Erol, Artun on 7.02.2022.
//

import Foundation

class PopularMovieCellViewModel {
    let apiResult: PopularMoviesAPIResultResponse
    let imageSize: ServiceURL


    init(apiResult: PopularMoviesAPIResultResponse, imageSize: ServiceURL) {
        self.apiResult = apiResult
        self.imageSize = imageSize
    }
}
