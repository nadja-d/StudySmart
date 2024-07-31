//
//  HomeView.swift
//  StudySmart_Final
//
//  Created by Nadja Jasmine Donosepoetro on 26/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            Text("StudySmart")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text("StudySmart is a study app focused on enhancing a student's learning experience with their learner type in mind.")
                .font(.title2)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Text("By acknowledging and practicing their personalized learner types, students are able to maximize their studying experience and have comprehensive preparation and understanding of the materials they study.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Features")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HomeCalloutBoxView(emoji: "📝", text: "Create customizable study guides")
                    HomeCalloutBoxView(emoji: "📚", text: "Offer multilearning flashcards")
                }
                HStack {
                    HomeCalloutBoxView(emoji: "📅", text: "Schedule exams or study sessions")
                    HomeCalloutBoxView(emoji: "✅", text: "Create simple task lists")
                }

            }
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct HomeCalloutBoxView: View {
    var emoji: String
    var text: String
    
    var body: some View {
        HStack {
            Text(emoji)
                .font(.title)
                .frame(width: 40)
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 10)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .frame(minWidth: 0, maxWidth: 380)
    }
}


#Preview {
    HomeView()
}
