import SwiftUI
import Foundation


struct PresidentialDecisionMakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

enum GameState {
    case ongoing
    case victory
    case defeat
}

struct Effects {
    var popularity: Int = 0
    var economy: Int = 0
    var corruption: Int = 0
    var militaryFunds: Int = 0
    var invadedLands: Int = 0
}

struct Scenario {
    let title: String
    let description: String
    let choices: [Choice]
}

struct Choice {
    let title: String
    let effects: Effects
    let nextScenarioIndex: Int?
    let isBestOption: Bool
}

struct GameView: View {
    @State private var currentScenarioIndex: Int = 0
    @State private var popularity: Int = 50
    @State private var economy: Int = 50
    @State private var corruption: Int = 0
    @State private var militaryFunds: Int = 0
    @State private var invadedLands: Int = 0
    @State private var gameState: GameState = .ongoing
    @State private var score: Int = 0
    
    let maxScore = 130 // Adjust as needed
    
    let scenarios: [Scenario] = [
        Scenario(
            title: "Starting Scenario",
            description: "You've just become the president. Make your first decision.",
            choices: [
                Choice(title: "Raise Taxes", effects: Effects(popularity: -5, economy: 10), nextScenarioIndex: 1, isBestOption: false),
                Choice(title: "Cut Spending", effects: Effects(popularity: 5, economy: -10), nextScenarioIndex: 1, isBestOption: true)
            ]
        ),
        Scenario(
            title: "Scenario 2",
            description: "You face a tough international crisis. What will you do?",
            choices: [
                Choice(title: "Negotiate Diplomatically", effects: Effects(popularity: 10, economy: -5), nextScenarioIndex: 2, isBestOption: true),
                Choice(title: "Deploy Military", effects: Effects(popularity: -10, economy: -15, militaryFunds: -20), nextScenarioIndex: 3, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 3",
            description: "You've successfully negotiated a trade deal. How will you allocate the gains?",
            choices: [
                Choice(title: "Invest in Infrastructure", effects: Effects(popularity: 5, economy: 15), nextScenarioIndex: 4, isBestOption: true),
                Choice(title: "Increase Personal Wealth", effects: Effects(popularity: -5, economy: 20, corruption: 10), nextScenarioIndex: 4, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 4",
            description: "A major health crisis has emerged. What's your response?",
            choices: [
                Choice(title: "Implement Strict Quarantine", effects: Effects(popularity: -5, economy: -10), nextScenarioIndex: 5, isBestOption: false),
                Choice(title: "Promote Hygiene Awareness", effects: Effects(popularity: 10, economy: -5), nextScenarioIndex: 5, isBestOption: true)
            ]
        ),
        Scenario(
            title: "Scenario 5",
            description: "Environmental activists demand action against pollution. What's your stance?",
            choices: [
                Choice(title: "Enforce Stringent Regulations", effects: Effects(popularity: 15, economy: -10), nextScenarioIndex: 6, isBestOption: true),
                Choice(title: "Ignore the Activists", effects: Effects(popularity: -10, economy: 5), nextScenarioIndex: 6, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 6",
            description: "Economic growth is slowing down. How do you boost the economy?",
            choices: [
                Choice(title: "Invest in Innovation", effects: Effects(popularity: 10, economy: 15), nextScenarioIndex: 7, isBestOption: true),
                Choice(title: "Lower Interest Rates", effects: Effects(popularity: -5, economy: 10), nextScenarioIndex: 7, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 7",
            description: "Labor unions demand higher wages. What's your response?",
            choices: [
                Choice(title: "Support Wage Increase", effects: Effects(popularity: 5, economy: -5), nextScenarioIndex: 8, isBestOption: true),
                Choice(title: "Oppose Wage Increase", effects: Effects(popularity: -10, economy: 10), nextScenarioIndex: 8, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 8",
            description: "An epidemic threatens livestock. How do you address the crisis?",
            choices: [
                Choice(title: "Cull Infected Animals", effects: Effects(popularity: -5, economy: 10), nextScenarioIndex: 9, isBestOption: false),
                Choice(title: "Implement Quarantine Measures", effects: Effects(popularity: 10, economy: -5), nextScenarioIndex: 9, isBestOption: true)
            ]
        ),
        Scenario(
            title: "Scenario 9",
            description: "Your popularity is declining. How do you regain public trust?",
            choices: [
                Choice(title: "Launch Public Welfare Programs", effects: Effects(popularity: 15, economy: -10), nextScenarioIndex: 10, isBestOption: true),
                Choice(title: "Blame the Opposition", effects: Effects(popularity: -10, economy: 5), nextScenarioIndex: 10, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 10",
            description: "A neighboring country wants to form an alliance. What's your decision?",
            choices: [
                Choice(title: "Accept the Alliance", effects: Effects(popularity: 10, economy: -5), nextScenarioIndex: 11, isBestOption: true),
                Choice(title: "Decline the Alliance", effects: Effects(popularity: -10, economy: 5), nextScenarioIndex: 11, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 11",
            description: "Your country faces a massive drought. How will you respond?",
            choices: [
                Choice(title: "Provide Relief Aid", effects: Effects(popularity: 10, economy: -5), nextScenarioIndex: 12, isBestOption: true),
                Choice(title: "Ignore the Situation", effects: Effects(popularity: -10, economy: 5), nextScenarioIndex: 12, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 12",
            description: "Foreign diplomats request your assistance in a peace treaty. What will you do?",
            choices: [
                Choice(title: "Mediate the Peace Talks", effects: Effects(popularity: 5, economy: -5), nextScenarioIndex: 13, isBestOption: true),
                Choice(title: "Stay Neutral", effects: Effects(), nextScenarioIndex: 13, isBestOption: false)
            ]
        ),
        Scenario(
            title: "Scenario 13",
            description: "Your tenure as president comes to an end. How will you be remembered?",
            choices: [
                Choice(title: "Legacy of Prosperity", effects: Effects(popularity: 15, economy: 10), nextScenarioIndex: nil, isBestOption: true),
                Choice(title: "Legacy of Controversy", effects: Effects(popularity: -15, economy: -10), nextScenarioIndex: nil, isBestOption: false)
            ]
        )
    ]
    
    var currentScenario: Scenario {
        scenarios[currentScenarioIndex]
    }
    
    var body: some View {
        VStack {
            if gameState == .victory || gameState == .defeat {
                GameOverView(gameState: gameState, score: score, maxScore: maxScore)
                Button(action: {
                    restartGame()
                }) {
                    Text("Restart")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            } else {
                Text(currentScenario.title)
                    .font(.title)
                    .padding()
                Text(currentScenario.description)
                    .padding()
                ForEach(currentScenario.choices.indices, id: \.self) { choiceIndex in
                    Button(action: {
                        handleChoice(choiceIndex)
                    }) {
                        Text(currentScenario.choices[choiceIndex].title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                ScoreView(score: score, maxScore: maxScore)
            }
        }
        .onAppear {
            restartGame()
        }
    }
    
    func handleChoice(_ choiceIndex: Int) {
        let choice = currentScenario.choices[choiceIndex]
        applyEffects(choice.effects)
        score += choice.isBestOption ? 15 : 10 // Increment the score for each correct decision
        
        if let nextScenarioIndex = choice.nextScenarioIndex {
            currentScenarioIndex = nextScenarioIndex
        } else {
            updateGameState()
        }
    }
    
    func applyEffects(_ effects: Effects) {
        popularity += effects.popularity
        economy += effects.economy
        corruption += effects.corruption
        militaryFunds += effects.militaryFunds
        invadedLands += effects.invadedLands
        
        updateGameState()
    }
    
    func updateGameState() {
        if score >= Int(Double(maxScore) * 0.9) {
            gameState = .victory
        } else if popularity <= 0 || economy <= 0 || corruption >= 100 {
            gameState = .defeat
        } else {
            gameState = .ongoing
        }
    }
    
    func restartGame() {
        currentScenarioIndex = 0
        popularity = 50
        economy = 50
        corruption = 0
        militaryFunds = 0
        invadedLands = 0
        gameState = .ongoing
        score = 0
    }
}

struct GameOverView: View {
    let gameState: GameState
    let score: Int
    let maxScore: Int
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.title)
                .padding()
            Text(gameStateDescription())
                .font(.headline)
                .foregroundColor(gameStateColor())
                .padding()
            Text("Score: \(score)")
                .font(.headline)
                .padding()
            Text("Max Score: \(maxScore)")
                .font(.headline)
                .padding()
        }
    }
    
    func gameStateDescription() -> String {
        switch gameState {
            case .victory:
                return "Congratulations! You have achieved victory."
            case .defeat:
                return "You have been defeated."
            default:
                return ""
        }
    }
    
    func gameStateColor() -> Color {
        switch gameState {
            case .victory:
                return .green
            case .defeat:
                return .red
            default:
                return .clear
        }
    }
}

struct ScoreView: View {
    let score: Int
    let maxScore: Int
    
    var body: some View {
        HStack {
            Text("Score: \(score)")
            Spacer()
            Text("Max Score: \(maxScore)")
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

