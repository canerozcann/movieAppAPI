//
//  MovieDetailView.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 19.09.2023.
//

import SwiftUI


struct MovieDetailView: View {
    let movie: Movie
    let baseimg = Constants.baseImg
    
    var body: some View {
    ScrollView{
        VStack(spacing:20){
            Text(movie.title)
                .font(.title)
                .padding()
            
            Spacer()
            
            AsyncImage(url: URL(string:baseimg + movie.posterPath)){
                image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                Color.gray
            }
            .frame(width: 200, height: 200)
            
            Spacer()
            
            Text(movie.overview)
                .font(.body)
                .padding()
            
            Text("Popularity = " + String(movie.popularity))
                .font(.body)
                .padding()
            
            Text("Vote Average = " + String(movie.voteAverage))
                .font(.body)
                .padding()
        }
                   
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
