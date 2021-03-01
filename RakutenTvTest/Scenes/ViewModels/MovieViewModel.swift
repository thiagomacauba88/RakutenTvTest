//
//  MovieViewModel.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit
import RxSwift

class MovieViewModel {

    // MARK: - Properties
    let service = MovieServices()
    var movieListResponse: MovieListResponse?
    var movieItemResponse: MovieItemResponse?
    var movieStreamingResponse: MovieStreamingResponse?
    
    // MARK: - MISC
    func movieList() -> Observable<MovieListResponse?> {
        return Observable.create { observable in
            self.service.movieList(success: { (manutencaoResponse, serviceResponse) in
                if let response = manutencaoResponse  {
                    self.movieListResponse = response
                    observable.onNext(self.movieListResponse)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func movie(movieId: String) -> Observable<MovieItemResponse?> {
        return Observable.create { observable in
            self.service.movie(movieId: movieId, success: { (manutencaoResponse, serviceResponse) in
                if let response = manutencaoResponse  {
                    self.movieItemResponse = response
                    observable.onNext(self.movieItemResponse)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func movieStreaming(movieStreamingRequest: MovieStreamingRequest) -> Observable<MovieStreamingResponse?> {
        return Observable.create { observable in
            self.service.movieStreaming(movieStreamingRequest: movieStreamingRequest, success: { (manutencaoResponse, serviceResponse) in
                if let response = manutencaoResponse  {
                    self.movieStreamingResponse = response
                    observable.onNext(self.movieStreamingResponse)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getMovie(index: Int) -> MovieResponse? {
        return self.movieListResponse?.data?.contents?.data?[index]
    }
    
    func getMovieId(index: Int) -> String? {
        return self.movieListResponse?.data?.contents?.data?[index].id
    }
}
