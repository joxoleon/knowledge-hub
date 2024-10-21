//
//  ContentView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        TabView {
            LessonSectionView(title: "Introduction", content: "Here we introduce and define the lesson.")
            
            LessonSectionView(title: "Lesson", content: "Full detailed lesson goes here with examples and diagrams.")
            
            LessonSectionView(title: "Discussion", content: "Discussion with pros and cons and comparisons.")
            
            LessonSectionView(title: "Summary", content: "Flashcard-style key takeaways.")
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // This hides the default tab bar and shows a dot indicator
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // Optional: Customize the dot indicator visibility
        .background(Color.customBackground.ignoresSafeArea()) // Custom background color applied to entire view
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct LessonSectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.customText) // Custom text color
                .padding()
            
            ScrollView {
                Text(content)
                    .foregroundColor(.customText) // Custom text color
                    .padding()
            }
        }
        .navigationTitle(title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

extension Color {
    static let customBackground = Color(red: 30/255, green: 34/255, blue: 45/255) // A custom dark gray with a blueish hue
    static let customText = Color(red: 220/255, green: 220/255, blue: 230/255) // Lighter gray text color
}
