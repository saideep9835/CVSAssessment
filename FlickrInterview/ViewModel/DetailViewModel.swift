import Foundation

class DetailViewModel: ObservableObject {
    private let item: Items

    init(item: Items) {
        self.item = item
    }

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
        extractUsingRegex(from: item.description, pattern: "<p>(.*?)<\\/p>", defaultValue: "No Description", at: 2)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var parsedAuthor: String {
        extractUsingRegex(from: item.author, pattern: "\\(\"(.*?)\"\\)", defaultValue: "Unknown Author").capitalized
    }

    var formattedPublishedDate: String {
        formatDate(from: item.published, inputFormat: ISO8601DateFormatter(), outputFormat: "MMM d, yyyy 'at' h:mm a") ?? "Unknown Date"
    }

    // MARK: - Private Helper Methods
    private func extractUsingRegex(from input: String?, pattern: String, defaultValue: String, at index: Int = 0) -> String {
        guard let input = input, let regex = try? NSRegularExpression(pattern: pattern) else { return defaultValue }
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        guard index < matches.count,
              let range = Range(matches[index].range(at: 1), in: input) else {
            return defaultValue
        }
        return String(input[range])
    }

    private func formatDate(from dateString: String?, inputFormat: ISO8601DateFormatter, outputFormat: String) -> String? {
        guard let dateString = dateString else { return nil }
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = outputFormat
        displayDateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = inputFormat.date(from: dateString) {
            return displayDateFormatter.string(from: date)
        }
        return nil
    }
}
