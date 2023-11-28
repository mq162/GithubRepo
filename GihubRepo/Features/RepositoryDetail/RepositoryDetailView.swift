//
//  RepositoryDetail.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import SwiftUI
import Networking

struct RepositoryDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let repository: Repository
    
    var body: some View {
        VStack {
            name
            if let description = repository.description {
                makeDescription(description: description)
            }
        }
    }
    
    private var name: some View {
        Text(repository.name)
            .font(.title2)
            .bold()
            .foregroundColor(.mint)
    }
    
    private func makeDescription(description: String) -> some View {
        Text(description)
            .font(.system(size: 14))
            .foregroundColor(colorScheme == .dark ? .white : .gray)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: Repository(id: 1,
                                                    name: "sdgsdg",
                                                    description: "ncxnvxcnmvb xcnmbvxnv nmxcvxcbvmnx nmcvx"))
    }
}
