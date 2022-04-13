//
//  TextFieldView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 07.02.2022.
//

import SwiftUI

struct TextFieldView: View {
    
    let subtitle: String
    let typeTextField :TypeTextField
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12){
            VStack(alignment: .leading, spacing: 3){
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.black)
                
                TextField("", text: $text)
                    .font(.title3)
                    .foregroundColor(.black)
            }
            Spacer()
            if typeTextField == .password {
                        Button {
            
                        } label: {
                            Image("Eye")
                        }
                    }
            if typeTextField == .login {
                Image("outline-check-24px")
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 15)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(lineWidth: 1)
                .foregroundColor(.black))
    }
}

enum TypeTextField {
    case password
    case login
    case simple
}

