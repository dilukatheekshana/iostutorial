import SwiftUI

struct HomeView: View {

    var body: some View {

        NavigationStack {

            VStack(spacing: 30) {

                Text("Game Hub")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                NavigationLink("Tap Frenzy") {

                    TapFrenzyView()
                }
                .frame(width: 250, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                NavigationLink("Light It Up") {

                    LightItUpView()
                }
                .frame(width: 250, height: 60)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
    }
}

#Preview {
    HomeView()
}
