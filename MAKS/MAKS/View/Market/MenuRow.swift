//
//  MenuRow.swift
//  MAKS
//
//  Created by sole on 2023/09/05.
//

import SwiftUI

struct MenuRow: View {
    let menu: Menu
    
    let action: () -> (Void)
    
    @State var downloadImage: Image?
    
    var menuImage: Image {
        guard let downloadImage
        else { return .imagePlaceHolder }
        return downloadImage
    }
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 10) {
            
            Button {
                action()
            } label: {
                HStack(spacing: 20) {
                    menuImage
                        .resizable()
                        .frame(width: 82,
                               height: 82)
                        .cornerRadius(8)
                    
                    menuInformationSection
                }
                .padding(.trailing, 20)
            }
            
            Divider()
                
        }
        .padding(.top, 10)
        .padding(.leading, 20)
        .onAppear {
            updateImage()
        }
        
    }
    
    //MARK: - menuInformationSection
    
    private var menuInformationSection: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text(menu.name)
                .font(.system(size: 18,
                              weight: .semibold))
                .padding(.bottom, 6)
            
            Text(menu.description)
                .font(.system(size: 14,
                              weight: .light))
                .foregroundColor(.mkGray500)
                .padding(.bottom, 20)
            
            Text("\(menu.price)원")
                .font(.system(size: 16,
                              weight: .medium))
        }
    } // - menuInformationSection
    
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
