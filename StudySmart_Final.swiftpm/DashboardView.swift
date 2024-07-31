//
//  DashboardView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct DashboardView: View {
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

#Preview {
    NavigationView {
        DashboardView()
    }
}
