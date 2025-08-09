//
//  PhotoCell.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import SwiftUI

struct PhotoCell: View {
    let photo: Photo

    var body: some View {
        VStack {
            AsyncImage(url: photo.imageUrl) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: cellWidth, height: cellHeight)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Color.red
                        .frame(height: cellHeight)
                default:
                    ProgressView()
                        .frame(height: cellHeight)
                }
            }

            Text(photo.title)
                .font(.caption)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(Color.clear)
    }
}
