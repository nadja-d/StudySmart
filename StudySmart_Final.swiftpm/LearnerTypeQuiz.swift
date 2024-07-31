import SwiftUI

struct LearnerTypeQuiz: View {
    @State private var questionIndex = 0
    @State private var answers: [Int] = []
    @State private var visualPoints = 0
    @State private var kinestheticPoints = 0
    @State private var auditoryPoints = 0
    @State private var showResult = false
    
    let questions = [
        "What is more likely to occur when you are having a difficult conversation with a person and consider what your next step should be:",
        "You know you've experienced something funny when you:",
        "When you have to describe a delicious dinner you have eaten to others, you:",
        "How would you explain a complicated topic to colleagues?",
        "What best describes your experience of an evening?",
        "When you want to tell a close friend or lover that you care about the person, are you more likely to:",
        "What do you have to experience in order for you to trust a friend?",
        "When you give someone directions, you prefer to:"
    ]

    let options = [
        ["Your inner gaze envisions the next step.", "You hear your own inner voice telling you what to do.", "You have an inner feeling of what you must do."],
        ["Hear a sound, for example, your own inner voice saying something.", "A mental image suddenly arises, e.g., of something or someone.", "An inner sensation that suddenly occurs, e.g., the feeling of a smile on your face."],
        ["Tell them about the sounds there, for example, what the dishes were called and what sounds were in the room.", "Physically indicate how you felt during dinner.", "Show or describe what the food looked like."],
        ["Find something tangible about the topic they can touch and feel.", "Tell them about the subject in great verbal detail.", "Illustrate it on a board or similar."],
        ["A sound, e.g., the sound of the wind rushing through the trees.", "A feeling, e.g., the feeling of moisture in the air or coldness in the body.", "A picture, for example, of how the shadows grow when the sun goes down."],
        ["Focus on how your voice sounds when telling them, e.g., is it calm and gentle?", "Take them by the hand and give them a hug.", "Send them a card or letter explaining yourself."],
        ["A sound, for example, the sound of a friend's voice.", "A sensation, for example, that of a hug.", "A picture, for example, the friend’s face."],
        ["Focus on the route, for example, by showing it on a map.", "Give the person little pointers to remember the way by, e.g., “when you see the red house, take a left.”", "Take the person by the hand and follow them on their way"]
    ]

    var body: some View {
        VStack {
            if !showResult {
                Text("Learning Styles Quiz")
                    .font(.title)
                    .bold()
                
                Text("Learning Styles refer to a range of theories that account for differences in an individual’s preferred way of learning. Although there is ample evidence that individuals express personal preferences for how they prefer to receive information, there is no one dominant theory of Learning Styles. This test tests you according to the classical framework of auditory, kinesthetic, and visual learning styles.")
                    .font(.body)
                    .padding([.horizontal, .top])
                    .multilineTextAlignment(.center)
                    
                Text("Credit: IDRlabs.com (Individual Differences Research)")
                    .font(.title3)
                    .padding()
            }
            
            if questionIndex < questions.count {
                VStack(alignment: .center, spacing: 20) {
                    Text("Question \(questionIndex + 1) of \(questions.count)")
                        .font(.headline)
                        .padding()
                    
                    Text(questions[questionIndex])
                        .font(.headline)
                    
                    ForEach(0..<options[questionIndex].count, id: \.self) { index in
                        Button(action: {
                            self.answerSelected(index)
                        }) {
                            Text(options[questionIndex][index])
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            } else {
                VStack {
                    Text("Quiz completed!")
                        .font(.title)
                        .padding()
                    Button(action: {
                        self.showResult = true
                    }) {
                        Text("Determine Learning Style")
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                }
                if showResult {
                    determineLearningStyle()
                        .padding()
                }
            }
        }
        .navigationBarTitle("Learner Styles Quiz", displayMode: .inline)
    }

    func answerSelected(_ index: Int) {
        answers.append(index)
        let selectedOptions = options[questionIndex]
        switch selectedOptions[index] {
        case options[questionIndex][0]:
            visualPoints += 1
        case options[questionIndex][1]:
            auditoryPoints += 1
        case options[questionIndex][2]:
            kinestheticPoints += 1
        default:
            break
        }
        nextQuestion()
    }

    func nextQuestion() {
        questionIndex += 1
    }

    func determineLearningStyle() -> some View {
        let learningStyle: String
        if visualPoints > auditoryPoints && visualPoints > kinestheticPoints {
            learningStyle = "Visual"
        } else if auditoryPoints > visualPoints && auditoryPoints > kinestheticPoints {
            learningStyle = "Auditory"
        } else if kinestheticPoints > visualPoints && kinestheticPoints > auditoryPoints {
            learningStyle = "Kinesthetic"
        } else {
            learningStyle = "Balanced"
        }
        return Text("Your predominant learning style is \(learningStyle).")
            .font(.headline)
    }
}

#Preview {
    LearnerTypeQuiz()
}
