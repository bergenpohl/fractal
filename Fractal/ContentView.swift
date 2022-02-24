//
//  ContentView.swift
//  Fractal
//
//  Created by Bergen Pohl on 2/23/22.
//

import SwiftUI

struct ContentView: View {
	@State private var image: CGImage?
	
	init () {
		let width: Int = 400
		let height: Int = 400
		let defaultColor = PixelData(a: 255, r: 255, g: 0, b: 0)
		var pixels = [PixelData]()
		
		for _ in 1...(width * height) {
			pixels.append(defaultColor)
		}
		
		let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
		let bitsPerComponent = 8
		let bitsPerPixel = 32
		
		var data = pixels
		guard let providerRef = CGDataProvider(data: NSData(bytes: &data, length: data.count * MemoryLayout<PixelData>.size)) else {
			image = nil
			return
		}
		image = CGImage(
			width: width,
			height: height,
			bitsPerComponent: bitsPerComponent,
			bitsPerPixel: bitsPerPixel,
			bytesPerRow: width * MemoryLayout<PixelData>.size,
			space: rgbColorSpace,
			bitmapInfo: bitmapInfo,
			provider: providerRef,
			decode: nil,
			shouldInterpolate: true,
			intent: .defaultIntent
		)
	}
	
    var body: some View {
		GeometryReader { geometry in
			ZStack {
				if (image != nil) {
					Image(image!, scale: 1.0, orientation: .up, label: Text("Fractal"))
						.frame(width: geometry.size.width, height: geometry.size.height)
				} else {
					Text("No Image")
				}
				HStack {
					Button(action: {
						zoomIn()
					}) {
						Image(systemName: "plus")
					}
					Button(action: {
						zoomOut()
					}) {
						Image(systemName: "minus")
					}
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
			}
		}
    }
	
	private func zoomIn() {
		
	}
	
	private func zoomOut() {
		
	}
	
	private struct PixelData {
		var a: UInt8
		var r: UInt8
		var g: UInt8
		var b: UInt8
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
