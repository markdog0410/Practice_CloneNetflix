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
    static let YoutubeAPI_KEY = "AIzaSyDdoGMLGCrfYsjVspC0XJtUzVkFnOc06ng"
    static let YoutubeBASE_URL = "https://youtube.googleapis.com/youtube/v3/search?"
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
    
    func getDiscoverMovies(completed: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.BASE)/3/discover/movie?include_adult=false&include_video=false&language=zh-TW&page=1&sort_by=popularity.desc") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
            } catch {
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completed: @escaping (Result<[Title], Error>) -> Void) {
        /*
         目的是將變數 query 中的字串進行百分比編碼，以便在 URL 中使用，".urlHostAllowed "是一個 CharacterSet，代表允許 URL 主機部分的字符，這些字符不需要被百分比編碼。
         
         除了 .urlHostAllowed 之外，常用的 URL 字符集合還包括：
         1, .urlFragmentAllowed: 允許 URL 片段部分的字符，如 #。
         2, .urlQueryAllowed: 允許 URL 查詢部分的字符，如 ?。
         3, .urlPasswordAllowed: 允許 URL 密碼部分的字符。
         4, .urlPathAllowed: 允許 URL 路徑部分的字符，例如 /。
         5, .urlUserAllowed: 允許 URL 使用者部分的字符。
         */
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constant.BASE)/3/search/movie?query=\(query)&api_key=\(Constant.API_KEY)") else {return}
        
        var request = URLRequest(url: url)
        request.setValue(Constant.API_TOKEN_BEAR, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completed(.success(result.results))
            } catch {
                completed(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovieByYoutube(with query: String, completed: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.YoutubeBASE_URL)q=\(query)&key=\(Constant.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//                這兩種差異在於上面這種未定義Response物件並轉為Any的資料結構，使用上較為彈性；
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(result)
//                下方寫法更為現代和類型安全的方式來處理 JSON 資料，Response用TrendingTitleResponse接起來
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completed(.success(results.items[0]))
            } catch {
                completed(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

