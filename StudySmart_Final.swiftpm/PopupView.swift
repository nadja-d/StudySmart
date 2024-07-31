//
//  PopupView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct AddCoursePopupView: View {
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
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
    
    private func addCourse() {
        guard !title.isEmpty && !subject.isEmpty && !emoji.isEmpty else { return }
        viewModel.addCourse(title: title, subject: subject, emoji: emoji, color: color)
        isPresented = false
    }
}

struct AddTermPopupView: View {
    let course: CourseModel
    @ObservedObject var viewModel: StudyGuideViewModel
    @Binding var isPresented: Bool
    @Binding var newTerm: String
    @Binding var newDefinition: String
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("New Term")) {
                        TextField("Term", text: $newTerm)
                        TextField("Definition", text: $newDefinition)
                    }
                }
                Button(action: {
                    addTerm()
                }) {
                    Text("Add Term")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationBarTitle("Add Term")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
    
    private func addTerm() {
        guard !newTerm.isEmpty && !newDefinition.isEmpty else { return }
        guard let index = viewModel.courses.firstIndex(where: { $0.id == course.id }) else { return }
        viewModel.courses[index].addTerm(TermModel(term: newTerm, definition: newDefinition))
        newTerm = ""
        newDefinition = ""
        isPresented = false
    }
}


