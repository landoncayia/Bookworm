//
//  ContentView.swift
//  Bookworm
//
//  Created by Landon Cayia on 8/4/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                if book.rating == 1 {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                } else if book.rating == 2 {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0))
                                } else if book.rating == 3 {
                                    Text(book.title ?? "Unknown Title")
                                        .foregroundColor(Color(red: 0.8, green: 0.75, blue: 0))
                                        .font(.headline)
                                } else if book.rating == 4 {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.6, green: 0.75, blue: 0))
                                } else {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.1, green: 0.65, blue: 0))
                                }
                                
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
