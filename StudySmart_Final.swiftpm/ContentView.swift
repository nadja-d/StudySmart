import SwiftUI

struct ContentView: View {
        var body: some View {
            NavigationView {
                List {
                    NavigationLink(destination: HomeView()) {
                        Label("Dashboard", systemImage: "house")
                    }
                    NavigationLink(destination: ScheduleView()) {
                        Label("Schedule", systemImage: "calendar")
                    }
                    NavigationLink(destination: ToDoListView()) {
                        Label("To Do Lists", systemImage: "pencil.and.scribble")
                    }
                    NavigationLink(destination: StudyGuideView()) {
                        Label("Study Guide", systemImage: "book.pages")
                    }
                    NavigationLink(destination: TipsView()) {
                        Label("Tips", systemImage: "lightbulb.min")
                    }
                }
            }
            .navigationTitle("Menu Bar")
    }
}
