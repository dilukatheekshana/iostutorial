import SwiftUI

struct HomeView: View {

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 30) {

                    Spacer()

                    // MARK: Header

                    VStack(spacing: 12) {

                        Image(systemName: "gamecontroller.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.purple)

                        Text("Arcade Hub")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        Text("Choose a game to begin")
                            .foregroundStyle(.gray)

                    }

                    Spacer()

                    // MARK: Tap Frenzy

                    NavigationLink {

                        TapFrenzyView()

                    } label: {

                        HStack {

                            Image(systemName: "hand.tap.fill")
                                .font(.title2)

                            VStack(alignment: .leading) {

                                Text("Tap Frenzy")
                                    .font(.headline)

                                Text("Tap as fast as possible")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))

                            }

                            Spacer()

                            Image(systemName: "chevron.right")

                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(18)

                    }

                    // MARK: Light It Up

                    NavigationLink {

                        LightItUpView()

                    } label: {

                        HStack {

                            Image(systemName: "lightbulb.fill")
                                .font(.title2)

                            VStack(alignment: .leading) {

                                Text("Light It Up")
                                    .font(.headline)

                                Text("Memory puzzle game")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))

                            }

                            Spacer()

                            Image(systemName: "chevron.right")

                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(18)

                    }

                    // MARK: Quiz Rush

                    NavigationLink {

                        QuizSetupView()

                    } label: {

                        HStack {

                            Image(systemName: "brain.head.profile")
                                .font(.title2)

                            VStack(alignment: .leading) {

                                Text("Quiz Rush")
                                    .font(.headline)

                                Text("Test your knowledge")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))

                            }

                            Spacer()

                            Image(systemName: "chevron.right")

                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(18)

                    }

                    Spacer()


                }
                .padding()

            }
            .navigationBarHidden(true)

        }

    }

}

#Preview {
    HomeView()
}
