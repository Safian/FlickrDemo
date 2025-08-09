//
//  PhotoDetailView.swift
//  FlickrDemo
//
//  Created by Szabolcs Sáfián on 2025. 08. 08..
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo

    @State var screenW = 0.0
    @State var screenH = 0.0
    @State var scale = 1.0
    @State var lastScale = 1.0
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero

    private let minScale = 1.0
    private let maxScale = 4.0

    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: photo.largeImageUrl ?? photo.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenW, height: screenH)
                        .scaleEffect(scale)
                        .offset(offset)
                        .clipped()
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let newScale = lastScale * value
                                    scale = min(max(newScale, minScale), maxScale)
                                    offset = clampedOffset(offset)
                                }
                                .onEnded { _ in
                                    lastScale = scale
                                    offset = clampedOffset(offset)
                                }
                                .simultaneously(with:
                                    DragGesture()
                                        .onChanged { value in
                                            offset = clampedOffset(CGSize(
                                                width: lastOffset.width + value.translation.width,
                                                height: lastOffset.height + value.translation.height
                                            ))
                                        }
                                        .onEnded { _ in
                                            lastOffset = offset
                                        })
                        )
                        .onAppear {
                            screenW = geometry.size.width
                            screenH = geometry.size.height * 0.6
                        }
                } placeholder: {
                    ProgressView()
                }

                Text(photo.title)
                    .font(.headline)
                    .padding()

                Spacer()
            }
        }
        .navigationTitle("Photo Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    func clampedOffset(_ proposed: CGSize) -> CGSize {
        let maxX = max((scale - 1) * screenW / 2, 0)
        let maxY = max((scale - 1) * screenH / 2, 0)

        return CGSize(
            width: min(max(proposed.width, -maxX), maxX),
            height: min(max(proposed.height, -maxY), maxY)
        )
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo.mock)
    }
}
