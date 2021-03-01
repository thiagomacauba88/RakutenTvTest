//
//  RakutenTvTestTests.swift
//  RakutenTvTestTests
//
//  Created by Thiago Freitas on 22/02/21.
//

import XCTest
@testable import RakutenTvTest

class RakutenTvTestTests: XCTestCase {

    var sut: URLSession!
    let movieServices = MovieServices()

    func testGetMovieId() {
        let movieViewModel = createMovieList()
        XCTAssertEqual(movieViewModel.getMovieId(index: 0), "1")
    }
    
    func testGetMovieItem() {
        let movieViewModel = createMovieList()
        XCTAssertEqual(movieViewModel.getMovie(index: 0)?.id, "1")
    }
    
    func testMovieListServiceSucess() {
        sut = URLSession(configuration: .default)
        let url = URL(string: movieServices.getMovieListUrl())
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func createMovieList() -> MovieViewModel {
        let movieViewModel = MovieViewModel()
        let movieResponse = MovieResponse(id: "1", title: nil, original_title: nil, plot: nil, year: nil, duration: nil, label: nil, classification: nil, images: nil, highlighted_score: nil, rating: nil, scores: nil, order_options: nil)
        let contentResponse = ContentResponse(data: [movieResponse])
        let contentsResponse = ContentsResponse(contents: contentResponse)
        let movieListResponse = MovieListResponse(data: contentsResponse)
        movieViewModel.movieListResponse = movieListResponse
        movieViewModel.movieListResponse?.data?.contents?.data?.append(movieResponse)
        return movieViewModel
    }

    func testMovieListServiceFailure() {
        sut = URLSession(configuration: .default)
        let wrongUrl = "http:"
        let url = URL(string: movieServices.getMovieListUrl()+wrongUrl)
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 403)
    }

    func testMovieService() {
        sut = URLSession(configuration: .default)
        let movieId = "Matrix"
        let url = URL(string: movieServices.getMovieUrl(movieId: movieId))
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }    
    
    func testCallMovieSucess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movieId = "wonder-woman-1984"
        movieDetailViewController.viewDidLoad()
        sleep(10)
        XCTAssertNotNil(movieDetailViewController.viewModel.movieItemResponse)
    }
    
    func testCallMovieFailed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movieId = "wonder-woman-19841"
        movieDetailViewController.viewDidLoad()
        sleep(10)
        XCTAssertNil(movieDetailViewController.viewModel.movieItemResponse)
    }
    
    func testCallMovieListSucess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        movieViewController.viewDidLoad()
        sleep(10)
        XCTAssertNotNil(movieViewController.viewModel.movieListResponse)
    }
        
    func testCallMovieStreamingSucess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieViewController.movieStreaming(movieId: "wonder-woman-1984")
        sleep(10)
        XCTAssertNotNil(movieViewController.viewModel.movieStreamingResponse)
    }
    
    func testCallMovieStreamingFailed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieViewController.movieStreaming(movieId: "wonder-woman-19841")
        sleep(10)
        XCTAssertNil(movieViewController.viewModel.movieStreamingResponse)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
