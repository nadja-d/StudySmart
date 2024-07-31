//
//  FlashcardView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//


import SwiftUI

struct FlashcardView: View {
    let course: CourseModel
    @Binding var currentIndex: Int
    @State private var isFlipped = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(course.terms[currentIndex].term)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        )
                }
                .opacity(isFlipped ? 0 : 1)
                
                VStack {
                    Text(course.terms[currentIndex].definition)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        )
                }
                .opacity(isFlipped ? 1 : 0)
            }
            .rotation3DEffect(
                .degrees(isFlipped ? 1 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    self.isFlipped.toggle()
                }
            }
            
            HStack(spacing: 40) {
                Button(action: {
                    currentIndex = max(currentIndex - 1, 0)
                    self.isFlipped = false // Reset flipped state when navigating to previous card
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                }
                .disabled(currentIndex == 0)
                
                Spacer()
                
                Button(action: {
                    currentIndex = min(currentIndex + 1, course.terms.count - 1)
                    self.isFlipped = false // Reset flipped state when navigating to next card
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                }
                .disabled(currentIndex == course.terms.count - 1)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}


struct FlashcardsNavigationView: View {
    let course: CourseModel
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            Text("Flashcards")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Swipe left or right to navigate through the flashcards.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            
            VStack {
                Text("\(course.title) - \(course.subject)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text("Card \(currentIndex + 1) of \(course.terms.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
                FlashcardView(course: course, currentIndex: $currentIndex)
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        let biologyCourse = CourseModel(title: "Biology Basics", subject: "Biology", emoji: "🧬", color: .green, terms: [
            TermModel(term: "Cell", definition: "The basic structural and functional unit of all organisms."),
            TermModel(term: "DNA", definition: "Deoxyribonucleic acid, a molecule that carries most of the genetic instructions used in the development, functioning, and reproduction of all known living organisms."),
            TermModel(term: "Organelle", definition: "A specialized subunit within a cell that has a specific function."),
            TermModel(term: "Mitochondria", definition: "Known as the powerhouse of the cell, responsible for generating most of the cell's supply of adenosine triphosphate (ATP)."),
            TermModel(term: "Nucleus", definition: "The central and most important part of an atom, containing most of the cell's genetic material."),
            TermModel(term: "Cytoplasm", definition: "The jelly-like substance that fills the cell and surrounds the organelles."),
            TermModel(term: "Membrane", definition: "A selective barrier that separates the cell from its external environment and regulates the movement of substances in and out of the cell.")
        ])
        
        return FlashcardsNavigationView(course: biologyCourse)
    }
}
#endif
