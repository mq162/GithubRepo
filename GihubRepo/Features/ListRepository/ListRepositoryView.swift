//
//  ListRepositoryView.swift
//  GihubRepo
//
//  Created by Quang on 26/11/2023.
//

import SwiftUI
import AlertToast
import Common

struct ListRepositoryView: View {
        
    @StateObject private var viewModel = ListRepositoryViewModel()
    
    @State private var hasAppeared = false
        
    var body: some View {
        NavigationView {
            ZStack {
                if (viewModel.isLoading) {
                    loadingView
                } else {
                    contentView
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Repositories")
            .task {
                if !hasAppeared {
                    await viewModel.getRepositories()
                    hasAppeared = true
                }
            }
            .toast(isPresenting: $viewModel.showError) {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: "Something went wrong!")
            }
        }
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.repositories, id: \.id) { repository in
                NavigationLink {
                    RepositoryDetailView(repository: repository)
                } label: {
                    RepositoryView(repository: repository)
                        .onAppear {
                            Task {
                                if viewModel.shouldLoadMore(repo: repository) {
                                    await viewModel.loadMoreRepositories()
                                }
                            }
                        }
                }
            }
            if (viewModel.isFetching) {
                loadMoreIndicator.listRowSeparator(.hidden)
            }
        }.listStyle(.plain)
    }
    
    private var loadMoreIndicator: some View {
        HStack {
            Spacer()
            CustomActivityIndicator(isAnimating: .constant(true), style: .medium)
            Spacer()
        }
    }
    

    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .mint))
            .scaleEffect(2.0, anchor: .center)
    }
}

struct ListRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        ListRepositoryView()
    }
}
