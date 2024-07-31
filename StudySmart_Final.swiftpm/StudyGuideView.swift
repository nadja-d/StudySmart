//
//  StudyGuideView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct StudyGuideView: View {
    @ObservedObject var viewModel = StudyGuideViewModel()
    @State private var isPresentingAddCourse = false
    
    var body: some View {
            VStack {
                List {
                    ForEach(viewModel.courses) { course in
                        NavigationLink(destination: CourseDetailView(course: course, viewModel: viewModel)) {
                            CourseRow(course: course)
                        }
                    }
                    .onDelete(perform: deleteCourses)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Study Guide")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    isPresentingAddCourse = true
                }) {
                    Text("Add Study Guide")
                }
            )
            .sheet(isPresented: $isPresentingAddCourse) {
                AddCoursePopupView(viewModel: viewModel, isPresented: $isPresentingAddCourse)
            }
    }
    
    private func deleteCourses(at offsets: IndexSet) {
        viewModel.deleteCourse(at: offsets.first ?? 0)
    }
}

struct CourseRow: View {
    let course: CourseModel
    
    var body: some View {
        HStack {
            Text(course.emoji)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.headline)
                Text(course.subject)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}


import SwiftUI

struct CourseDetailView: View {
    let course: CourseModel
    @ObservedObject var viewModel: StudyGuideViewModel
    @State private var isPresentingAddTerm = false
    @State private var newTerm = ""
    @State private var newDefinition = ""
    @State private var isShowingFlashcards = false
    
    var body: some View {
        VStack {
            Text(course.title)
                .font(.title)
            Text(course.subject)
                .font(.headline)
            List {
                ForEach(course.terms) { term in
                    TermRow(term: term)
                }
                .onDelete(perform: deleteTerms)
            }
            .listStyle(InsetGroupedListStyle())
            
            VStack {
                HStack {
                    Button(action: {
                        isPresentingAddTerm = true
                    }) {
                        Text("Add Term")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $isPresentingAddTerm) {
                        AddTermPopupView(course: course, viewModel: viewModel, isPresented: $isPresentingAddTerm, newTerm: $newTerm, newDefinition: $newDefinition)
                    }
                    
                    Button(action: {
                        isShowingFlashcards = true
                    }) {
                        Text("View Flashcards")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $isShowingFlashcards) {
                        FlashcardsNavigationView(course: course)
                    }
                }
            }
            .padding()
        }
    }
    
    private func deleteTerms(at offsets: IndexSet) {
        guard let index = viewModel.courses.firstIndex(where: { $0.id == course.id }) else { return }
        viewModel.courses[index].terms.remove(atOffsets: offsets)
    }
}

struct TermRow: View {
    let term: TermModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(term.term)
                .font(.headline)
            Text(term.definition)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct AddCourseView: View {
    @ObservedObject var viewModel: StudyGuideViewModel
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var subject = ""
    @State private var emoji = ""
    @State private var color = Color.blue
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Course Details")) {
                        TextField("Title", text: $title)
                        TextField("Subject", text: $subject)
                        TextField("Emoji", text: $emoji)
                        ColorPicker("Color", selection: $color)
                    }
                }
                Button(action: {
                    addCourse()
                }) {
                    Text("Add Study Guide")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationBarTitle("Add Study Guide")
        }
    }
    
    private func addCourse() {
        guard !title.isEmpty && !subject.isEmpty && !emoji.isEmpty else { return }
        viewModel.addCourse(title: title, subject: subject, emoji: emoji, color: color)
        isPresented = false
    }
}

#Preview {
    StudyGuideView()
}

