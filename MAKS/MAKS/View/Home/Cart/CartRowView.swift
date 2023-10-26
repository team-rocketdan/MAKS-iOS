//
//  CartRowView.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI

struct CartRowView: View {
    @EnvironmentObject var menuViewModel: MenuViewModel
    let menu: Menu
    
    @State var count: Int = 1
    @State var downloadImage: Image?
    
    var menuImage: Image {
        guard let downloadImage
        else { return .imagePlaceHolder }
        return downloadImage
    }
    
    let action: () -> (Void)
   
    var body: some View {
        HStack(spacing: 20) {
            menuImage
                .resizable()
                .frame(width: 86, height: 86)
                .cornerRadius(8)
            
            VStack(alignment: .leading,
                   spacing: 0) {
                HStack(spacing: 0) {
                    Text(menu.name)
                        .font(.system(size: 18,
                                      weight: .semibold))
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("close")
                    }
                }
                .padding(.bottom, 1)
                
                Text("1개 가격: \(menu.price)원")
                    .font(.system(size: 14,
                                  weight: .light))
                    .padding(.bottom, 20)
                
                HStack(spacing: 0) {
                    Text("\(menu.price * count)원")
                        .font(.system(size: 16,
                                      weight: .medium))
                    
                    Spacer()
                    
                    MKStepper(count: $count)
                }
            }

        }
        .padding(.vertical, 10)
        .onAppear {
            updateImage()
        }
        .onChange(of: count) { newValue in
            menuViewModel.menusInCart[menu] = newValue
        }
    }
    
    //MARK: - updateImage
    
    func updateImage() {
        guard let url = menu.imageURL
        else { return }
        Task {
            do {
                self.downloadImage = try await FirebaseManager().downloadImage(path: url).convertToImage()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    CartRowView(menu: .defaultModel) {
    }
}
