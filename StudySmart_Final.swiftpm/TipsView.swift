//
//  TipsView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 23/02/24.
//

import SwiftUI

struct TipsView: View {
    var body: some View {
        List {
            Text("Tips")
                .font(.title)
                .bold()
                .listRowBackground(Color.clear)
            
            Section(header: Text("TYPES OF LEARNERS")) {
                NavigationLink(destination: VisualLearners()) {
                    HStack {
                        Text("📚")
                        Text("Visual Learners: Learn best through visual aids such as charts, diagrams, and videos.")
                    }
                }
                NavigationLink(destination: AuditoryLearners()) {
                    HStack {
                        Text("🎧")
                        Text("Auditory Learners: Learn best through listening, such as lectures, discussions, and audiobooks.")
                    }
                }
                NavigationLink(destination: KinestheticLearners()) {
                    HStack {
                        Text("👐")
                        Text("Kinesthetic Learners: Learn best through hands-on activities, movement, and experimentation.")
                    }
                }
            }
            .listRowBackground(Color.clear)

            
            Section(header: Text("FIND OUT WHAT TYPE OF LEARNER YOU ARE")) {
                NavigationLink(destination: LearnerTypeQuiz()) {
                    Text("Discover Your Learning Style")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .listRowBackground(Color.clear)
            }


            
            Section(header: Text("TYPES OF STUDYING METHODS")) {
                VStack {
                    HStack {
                        StudyMethodView(emoji: "📝", description: "Note-taking: Write down key points and summaries while studying.")
                        StudyMethodView(emoji: "🧠", description: "Active Recall: Test yourself on the material without looking at your notes.")
                        StudyMethodView(emoji: "🔄", description: "Spaced Repetition: Review material at spaced intervals to improve retention.")
                    }
                    HStack {
                        StudyMethodView(emoji: "📚", description: "Reading: Engage with the material by reading and understanding concepts.")
                        StudyMethodView(emoji: "🔖", description: "Bookmarking: Mark important sections for quick reference during review.")
                        StudyMethodView(emoji: "📖", description: "Skimming: Quickly read through the material to get an overview.")
                    }
                    HStack {
                        StudyMethodView(emoji: "🧾", description: "Summarizing: Condense information into concise summaries for better understanding.")
                        StudyMethodView(emoji: "💡", description: "Mnemonic Devices: Use memory aids such as acronyms or rhymes to recall information.")
                        StudyMethodView(emoji: "💬", description: "Group Discussion: Collaborate with peers to discuss and reinforce learning.")
                    }
                }
                .listRowBackground(Color.clear)
            }
            
            Section(header: Text("THINGS TO TAKE NOTE WHEN STUDYING")) {
                Text("1. Find a quiet and comfortable study environment.")
                Text("2. Break your study sessions into manageable chunks.")
                Text("3. Stay organized with a planner or study schedule.")
            }
            
        }
    }
}

struct StudyMethodView: View {
    let emoji: String
    let description: String
    
    var body: some View {
        VStack {
            Text(emoji)
                .font(.largeTitle)
                .padding(.bottom, 5)
            Text(description)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 5)
    }
}

struct AuditoryLearners: View {
    var body: some View {
        VStack {
            Text("🎧")
                .font(.system(size: 125))
            Text("Auditory Learners")
                .font(.title)
            Text("Auditory learners learn best through listening, such as lectures, discussions, and audiobooks.")
                .padding()
            
            Section(header: Text("Best Practices for Visual Learners").font(.title2).padding(.bottom).bold()) {
                CalloutBoxView(emoji: "🎵", text: "Listen to audio recordings of lectures or discussions.")
                CalloutBoxView(emoji: "🗣️", text: "Engage in group discussions or debates about the topic.")
                CalloutBoxView(emoji: "📚", text: "Utilize audiobooks or podcasts related to the subject matter.")
            }
        }
    }
}

struct CalloutBoxView: View {
    let emoji: String
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(emoji)
                .font(.title)
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.bottom, 5)
    }
}


struct KinestheticLearners: View {
    var body: some View {
        VStack {
            Text("👐")
                .font(.system(size: 125))
            Text("Kinesthetic Learners")
                .font(.title)
            Text("Kinesthetic learners learn best through hands-on activities, movement, and experimentation.")
                .padding()
            
            Section(header: Text("Best Practices for Kinesthetic Learners").font(.title2).padding(.bottom).bold()) {
                CalloutBoxView(emoji: "👐", text: "Engage in hands-on activities to reinforce learning, such as experiments or interactive projects.")
                CalloutBoxView(emoji: "🏃‍♂️", text: "Incorporate movement into your learning process, such as pacing while studying or using tactile objects.")
                CalloutBoxView(emoji: "🔍", text: "Explore real-world examples and applications of concepts through field trips or practical experiences.")
            }
        }
    }
}

struct VisualLearners: View {
    var body: some View {
        VStack {
            Text("📚")
                .font(.system(size: 125))
            Text("Visual Learners")
                .font(.title)
            Text("Visual learners learn best through visual aids such as charts, diagrams, and videos.")
                .padding()
            
            Section(header: Text("Best Practices for Visual Learners").font(.title2).padding(.bottom).bold()) {
                CalloutBoxView(emoji: "✅", text: "Use color coding to organize information.")
                CalloutBoxView(emoji: "📊", text: "Utilize visual representations like charts and graphs.")
                CalloutBoxView(emoji: "📽️", text: "Watch educational videos or tutorials related to the topic.")
            }
        }
    }
}


#Preview {
    TipsView()
}

