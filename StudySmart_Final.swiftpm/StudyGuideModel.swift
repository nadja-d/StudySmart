//
//  StudyGuideModel.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

class StudyGuideViewModel: ObservableObject {
    @Published var courses: [CourseModel]
    
    init() {
        self.courses = [
            CourseModel(title: "Cellular", subject: "Biology", emoji: "🧬", color: .green, terms: [
                TermModel(term: "Cell", definition: "The basic structural and functional unit of all organisms."),
                TermModel(term: "DNA", definition: "Deoxyribonucleic acid, a molecule that carries most of the genetic instructions used in the development, functioning, and reproduction of all known living organisms."),
                TermModel(term: "Organelle", definition: "A specialized subunit within a cell that has a specific function."),
                TermModel(term: "Mitochondria", definition: "Known as the powerhouse of the cell, responsible for generating most of the cell's supply of adenosine triphosphate (ATP)."),
                TermModel(term: "Nucleus", definition: "The central and most important part of an atom, containing most of the cell's genetic material."),
                TermModel(term: "Cytoplasm", definition: "The jelly-like substance that fills the cell and surrounds the organelles."),
                TermModel(term: "Membrane", definition: "A selective barrier that separates the cell from its external environment and regulates the movement of substances in and out of the cell.")
            ]),
            CourseModel(title: "Atomic Structure", subject: "Chemistry", emoji: "⚛️", color: .purple, terms: [
                TermModel(term: "Atom", definition: "The basic unit of a chemical element, consisting of a nucleus containing protons and neutrons, surrounded by electrons."),
                TermModel(term: "Proton", definition: "A subatomic particle with a positive electrical charge, found in the nucleus of an atom."),
                TermModel(term: "Neutron", definition: "A subatomic particle with no net electrical charge, found in the nucleus of an atom."),
                TermModel(term: "Electron", definition: "A subatomic particle with a negative electrical charge, orbiting the nucleus of an atom."),
                TermModel(term: "Nucleus", definition: "The central and most important part of an atom, containing most of the atom's mass in the form of protons and neutrons.")
            ]),
        ]
    }
    
    
    func addCourse(title: String, subject: String, emoji: String, color: Color) {
        let newCourse = CourseModel(title: title, subject: subject, emoji: emoji, color: color, terms: [])
        courses.append(newCourse)
    }
    
    func deleteCourse(at index: Int) {
        courses.remove(at: index)
    }
    
    func addTerm(toCourseIndex index: Int, term: TermModel) {
        courses[index].addTerm(term)
    }
}

struct CourseModel: Identifiable {
    let id = UUID()
    var title: String
    var subject: String
    var emoji: String
    var color: Color
    var terms: [TermModel]
    
    mutating func addTerm(_ term: TermModel) {
        terms.append(term)
    }
}

struct TermModel: Identifiable {
    let id = UUID()
    var term: String
    var definition: String
}
