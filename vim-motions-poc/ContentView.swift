import SwiftUI

struct ContentView: View {
    @State private var text: String = "This is a sample text."
    @State private var mode: VimMode = .Normal

    var body: some View {
        HStack(alignment: VerticalAlignment.top) {
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Normal mode").bold().padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text("h j k l:   Navigation")
                Text("i:   Enter insert mode")
                Text("a:   Enter insert mode after cursor")
                Text("w:   Jump to start of next word")
                Text("b:   Jump to start of prev word")

                Text("Insert mode").bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                Text("Escape:   Enter normal mode")
            }
            
            TextView(text: $text, mode: $mode)
                .frame(height: 200)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            VStack {
                Text("Mode:").bold()
                Text(mode.rawValue)
                
                Text("Command:").bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                Text("")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
