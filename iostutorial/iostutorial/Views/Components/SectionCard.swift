import SwiftUI

struct SectionCard<Content: View>: View {

    let title: String

    @ViewBuilder
    let content: Content

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            content

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ZStack {

        Color.black.ignoresSafeArea()

        SectionCard(title: "Category") {

            Text("Science")
                .foregroundStyle(.white)

        }
        .padding()

    }
}
