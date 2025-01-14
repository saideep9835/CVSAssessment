//
//  DetailViewModel.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//


import Foundation

class DetailViewModel: ObservableObject {
    let item: Items

    // MARK: - Initializer
    init(item: Items) {
        self.item = item
    }

    // MARK: - Computed Properties
    var imageUrl: URL? {
        if let mediaUrl = item.media?.m {
            return URL(string: mediaUrl)
        }
        return nil
    }

    var title: String {
        item.title ?? "No Title"
    }

    var parsedDescription: String {
        guard let description = item.description else { return "No Description" }
        return formatHTML(description)
    }

    var parsedAuthor: String {
        guard let author = item.author else { return "Unknown Author" }
        return extractUsingRegex(from: author, pattern: "\\(\"(.*?)\"\\)", defaultValue: "Unknown Author").capitalized
    }

    var formattedPublishedDate: String {
        guard let publishedDate = item.published else { return "Unknown Date" }
        return formatDate(publishedDate, inputFormat: ISO8601DateFormatter(), outputFormat: "MMM d, yyyy 'at' h:mm a") ?? "Unknown Date"
    }

    // MARK: - Private Helper Methods

    private func formatHTML(_ html: String) -> String {
        guard let data = html.data(using: .utf8) else { return html }
        if let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        ) {
            return attributedString.string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return html
    }

    private func extractUsingRegex(from input: String, pattern: String, defaultValue: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return defaultValue }
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        guard let range = matches.first?.range(at: 1), let result = Range(range, in: input) else {
            return defaultValue
        }
        return String(input[result])
    }

    private func formatDate(_ dateString: String, inputFormat: ISO8601DateFormatter, outputFormat: String) -> String? {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = inputFormat.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
