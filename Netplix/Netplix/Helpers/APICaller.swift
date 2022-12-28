//
//  APICaller.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

import Foundation

struct Constants {
    static let API_KEY = "7c50aa678ebbc4b291d33f513797fc9e"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDaQ1RLSDQNMklXoKG2b6tPKmnG7EmQwo0"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError : Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getAllMovies(completion : @escaping (Result<[Movie], Error>) -> Void) {
        
        if let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&sort_by=popularity.desc&page=1&") {
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let results = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(results.results))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Movie],Error>) -> Void) {
        if let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let results = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(results.results))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    func getLatestMovies(completion : @escaping (Result<[Movie],Error>) -> Void) {
        if let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&sort_by=release_date.desc&page=1") {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let results = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(results.results))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func searchMovie(for searchTerm: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard !searchTerm.isEmpty else {return}
        let query = searchTerm.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)&sort_by=release_date.desc&page=1") else {return}
        print("start fetching data for \(query)")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.results))
                }
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func actionMovie(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&sort_by=release_date.desc&with_genres=28&page=1") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(AllMoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.results))
                }
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func getTrailer(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrailerResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.items[0]))
                }

            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
