//
//  File.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 19.09.2023.
//

import Foundation
import Moya

class MovieViewModel: ObservableObject {
    
    private let provider = MoyaProvider<MovieService>()

    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var searchText = ""
    @Published var isGridMode = true
    @Published var isShowingAllMovies = false

    

   
 
//    func fetchMovies(page: Int) {
//        provider.request(.popularMovies(page: page)) { [weak self] result in
//            switch result {
//            case let .success(response):
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(MovieResponse.self, from: response.data)
//                    DispatchQueue.main.async {
//                        if let movies = self?.movies {
//                            // Eğer movies dizisi nil değilse, yeni filmleri mevcut filmlerle birleştirin.
//                            self?.movies.append(contentsOf: response.results)
//                            self?.filteredMovies = movies
//                        }
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            case let .failure(error):
//                print("API Error: \(error)")
//            }
//        }
//    }
    func fetchMovies(page:Int) {
        provider.request(.popularMovies(page:page)) { [weak self] result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MovieResponse.self, from: response.data)
                    DispatchQueue.main.async {
//                        self?.movies = response.results
                        self?.movies.append(contentsOf: response.results)
                        self?.filteredMovies.append(contentsOf: response.results)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case let .failure(error):
                print("API Error: \(error)")
            }
        }
    }
    
//    func fetchMovies() {
//        provider.request(.popularMovies) { [weak self] result in
//            switch result {
//            case let .success(response):
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(MovieResponse.self, from: response.data)
//                    DispatchQueue.main.async {
//                        self?.movies = response.results
//                        self?.filteredMovies = response.results
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            case let .failure(error):
//                print("API Error: \(error)")
//            }
//        }
//    }


    func searchMovies() {
        if searchText.count >= 3 {
            let searchResult = movies.filter { movie in
                return movie.title.lowercased().contains(searchText.lowercased())
            }
            self.filteredMovies = searchResult
        } else {
            self.filteredMovies = movies
        }
    }
}



//class MovieManager: ObservableObject {
//    @Published var movies: [Movie] = []
//    @Published var filteredMovies: [Movie] = []
//    @Published var searchText = ""
//    @Published var isGridMode = true
//    @Published var isShowingAllMovies = false
//
//    func fetchMovies() {
//        let apiKey = "11459cff1c1ce00e3202addab99f3a91"
//        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
//
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("Error fetching data: \(error)")
//                return
//            }
//
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(MovieResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.movies = response.results
//                        self.filteredMovies = self.movies
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
//        }.resume()
//    }
//
//
//    func searchMovies() {
//        if searchText.count >= 3 {
//            let searchResult = movies.filter { movie in
//                // Arama metni ile film başlığı karşılaştırması yapın
//                return movie.title.lowercased().contains(searchText.lowercased())
//            }
//            // Elde edilen arama sonuçlarını kullanabilirsiniz
//            // Örneğin, bu sonuçları bir property'e atayabilir veya MovieGridView veya MovieListView'e iletebilirsiniz.
//            self.filteredMovies = searchResult
//        }
//        else {
//                // Arama metni 3 karakterden kısa ise, tüm filmleri göstermek için filteredMovies dizisini movies dizisi ile güncelleyin.
//            self.filteredMovies = self.movies
//            }
//    }
//}
