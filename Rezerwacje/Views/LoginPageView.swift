import SwiftUI

struct LoginPageView: View {
    @State private var allertMessage = ""
    @State private var showingAlert = false
    @State var authenticationDidSucceed: Bool = false
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        
            VStack(alignment: .center) {
                Text("Zaloguj się!")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                TextField("Login", text: $username)
                    .padding()
                    .colorInvert()
                    .background(.gray)
                    .cornerRadius(20.0)
                    .padding(.bottom, 20)
                
                SecureField("Hasło", text: $password)
                    .padding()
                    .colorInvert()
                    .background(.gray)
                    .cornerRadius(20.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    print("Try login")
                    if (username == "Admin" && password == "admin1"){
                        self.authenticationDidSucceed = true
                    }
                    else{
                        allertMessage = "Niewłaściwy login lub hasło"
                        showingAlert = true
                    }
                }) {
                    Text("OK")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .cornerRadius(20.0)
                        .shadow(color: Color.orange, radius: 10)
                }
                .fullScreenCover(
                    isPresented: self.$authenticationDidSucceed,
                    content: {MainPageView()})
            }
            .padding()
            .background(.white.opacity(0.5))
            .cornerRadius(20.0)
            .padding(.all, 20.0)
            .frame(width: UIScreen.main.bounds.size.width)
        }
        .alert(allertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
