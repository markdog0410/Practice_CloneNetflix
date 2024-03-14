//
//  APICaller.swift
//  TestCase_05_CloneNetflix
//
//  Created by Tsai Ming Chen on 2024/3/12.
//
//https://api.themoviedb.org/3/trending/movie/day?language=zh-tw

import Foundation

struct Constant {
    static let API_KEY = "9e4e7477516b86558137e8ba97d0d582"
    static let API_TOKEN_BEAR = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZTRlNzQ3NzUxNmI4NjU1ODEzN2U4YmE5N2QwZDU4MiIsInN1YiI6IjY1ZjAwNThjMWY3NDhiMDE2MTUxMDJjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cUxeX5p_Lg-XxrgaS7uxW7mf5T5RdC_Q9b0rqQOV4Ks"
    static let BASE = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completed: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constant.BASE)/3/trending/movie/day?language=zh-tw") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(result)            
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
                print(result.results)
            } catch {
//                print(error.localizedDescription)
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completed: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE)/3/trending/tv/day?language=zh-tw") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(result)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
                print(result.results)
            } catch {
//                print(error.localizedDescription)
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
        
    func getUpcomingMovies(completed: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE)/3/movie/upcoming?language=zh-TW&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
//                print(result.results)
            } catch {
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getPopularMovies(completed: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE)/3/movie/popular?language=zh-TW&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
//                print(result.results)
            } catch {
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completed: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE)/3/movie/top_rated?language=zh-TW&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
//                print(result.results)
            } catch {
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}

