// Model class to represent the API response structure.
class ModelClass {
  List<Quotes>? quotes; // List of quotes
  int? total; // Total number of quotes
  int? skip; // Number of skipped quotes (for pagination)
  int? limit; // Number of quotes returned per request

  ModelClass({this.quotes, this.total, this.skip, this.limit});

  // Converts JSON response into a Dart object.
  ModelClass.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

// Represents a single quote item.
class Quotes {
  int? id; // Unique identifier for the quote
  String? quote; // The quote text
  String? author; // Author of the quote

  Quotes({this.id, this.quote, this.author});

  // Converts JSON object into a Dart object.
  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    author = json['author'];
  }
}
