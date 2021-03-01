//
//  MovieServices.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit

class MovieServices {

    // MARK: - Urls
    func getBaseUrl() -> String {
        let url = URLInfo.url(fromKey: "baseUrl")
        return url
    }
    
    func getMovieListUrl() -> String {
        let url = URLInfo.url(fromKey: "movieList")
        return self.getBaseUrl()+url
    }
    
    func getMovieUrl(movieId: String) -> String {
        var url = URLInfo.url(fromKey: "movie")
        url = url.replacingOccurrences(of: "{movieId}", with: movieId)
        return self.getBaseUrl()+url
    }
    
    func getMovieStreamingUrl() -> String {
        let url = URLInfo.url(fromKey: "movieStreaming")
        return self.getBaseUrl()+url
    }
    
    // MARK: - Services
    func movieList(success: @escaping ((_ sucessObject : MovieListResponse?, _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getMovieListUrl()) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil, auth: false).response(succeed: { (_ manutencao: MovieListResponse?, _ serviceResponse: ServiceResponse?) in
                if let response = manutencao, let content = serviceResponse {
                    success(response, content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    func movie(movieId: String, success: @escaping ((_ sucessObject : MovieItemResponse?, _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getMovieUrl(movieId: movieId)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil, auth: false).response(succeed: { (_ manutencao: MovieItemResponse?, _ serviceResponse: ServiceResponse?) in
                if let response = manutencao, let content = serviceResponse {
                    success(response, content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    func movieStreaming(movieStreamingRequest: MovieStreamingRequest, success: @escaping ((_ sucessObject : MovieStreamingResponse?, _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getMovieStreamingUrl()), let parameters = movieStreamingRequest.dictionaryValue {
            Service.shared.request(httpMethod: .post, url: url, payload: parameters, auth: false).response(succeed: { (_ manutencao: MovieStreamingResponse?, _ serviceResponse: ServiceResponse?) in
                if let response = manutencao, let content = serviceResponse {
                    success(response, content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
}
