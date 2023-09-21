//
//  MainMovieView.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 19.09.2023.
//
import SwiftUI

struct MainMovieView: View {
    @StateObject private var movieManager = MovieViewModel()
    @State private var currentpage = 1
    @State private var scrollPosition: CGFloat = .zero
    @State private var isAtBottom = false

    var body: some View {
        NavigationView {
    VStack{
            ScrollView{
            VStack {
                SearchBar(text: $movieManager.searchText,placeholder: "Film Ara", movieManager:movieManager)
                    .padding()
                
                if movieManager.isGridMode {
                    MovieGridView(movies: movieManager.filteredMovies)
                } else {
                    MovieListView(movies: movieManager.filteredMovies)
                }
                
                
            }
            .background(GeometryReader { geometry in
                                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin.y)
                            })
                            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                self.scrollPosition = value
                                checkIfAtBottom(value)
                                print(self.scrollPosition)
                                print(isAtBottom)
                                if (isAtBottom){ currentpage+=1
                                    movieManager .fetchMovies(page: currentpage)
                                }
                            }
            
            .navigationBarTitle("Filmler")
            .navigationBarItems(trailing: Button(action: {
                movieManager.isGridMode.toggle()
            }) {
                Image(systemName: movieManager.isGridMode ? "list.bullet" : "square.grid.2x2")
            })
        }
            .coordinateSpace(name: "name")
            if !movieManager.isShowingAllMovies {
                    Button("Daha Fazla Yükle") {
                        currentpage += 1
                        movieManager.fetchMovies(page: currentpage)
      
                    }
                    .padding()
                }
            }
            
        }
        .onAppear {
            movieManager.fetchMovies(page:currentpage)
        }
    }
    private func checkIfAtBottom(_ yOffset: CGFloat) {
            let threshold: CGFloat = 10 // Eşik değeri ayarlayın
        isAtBottom =   yOffset  < -1604.3
        print(UIScreen.main.bounds.height)
        }
    
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    }
}



//import SwiftUI
//
//struct MainMovieView: View {
//    @StateObject private var movieManager = MovieViewModel()
//    @State private var currentpage = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                SearchBar(text: $movieManager.searchText,placeholder: "Film Ara", movieManager:movieManager)
//                    .padding()
//
//                if movieManager.isGridMode {
//                    MovieGridView(movies: movieManager.filteredMovies)
//                } else {
//                    MovieListView(movies: movieManager.filteredMovies)
//                }
//
//                if !movieManager.isShowingAllMovies {
//                    Button("Daha Fazla Yükle") {
//                        currentpage += 1
//                        movieManager.fetchMovies(page: currentpage)
//                    }
//                    .padding()
//                }
//            }
//            .navigationBarTitle("Filmler")
//            .navigationBarItems(trailing: Button(action: {
//                movieManager.isGridMode.toggle()
//            }) {
//                Image(systemName: movieManager.isGridMode ? "list.bullet" : "square.grid.2x2")
//            })
//        }
//        .onAppear {
//            movieManager.fetchMovies(page:currentpage)
//        }
//    }
//}


struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct MovieGridView: View {
    var movies: [Movie]

    
    var body: some View {
        
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieItem(movie: movie)
                    }
                }
            }
            .padding()
        
    }
}

struct MovieListView: View {
    var movies: [Movie]
    
    
    var body: some View {
        List{
            ForEach(movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack(alignment: .center){
                        Spacer()
                        MovieItem(movie: movie)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MovieItem: View {
    let movie: Movie
    let baseimg = Constants.baseImg
    
    
    var body: some View {
        VStack(spacing:20) {
            AsyncImage(url: URL(string:baseimg + movie.posterPath)){
                image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fill)

                       } placeholder: {
                           Color.gray
                       }
                       .frame(width: 80, height: 80)
            
         
            Text(movie.title)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }

}


struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    var movieManager : MovieViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .textCase(.lowercase)
                .onChange(of: text) { newValue in
                    movieManager.searchText = newValue
                    movieManager.searchMovies()
                }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}





struct MainMovieView_Previews: PreviewProvider {
    static var previews: some View {
        MainMovieView()
    }
}
