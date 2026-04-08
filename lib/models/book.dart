class Book {
  final int numFound;
  final int start;
  final bool numFoundExact;
  final int num_found;
  final String documentation_url;
  final String q;
  final int? offset;
  final List<Docs> docs;

  Book({required this.numFound, required this.start, required this.numFoundExact, required this.num_found, required this.documentation_url, required this.q, this.offset, required this.docs});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    numFound: json['numFound'] as int,
    start: json['start'] as int,
    numFoundExact: json['numFoundExact'] as bool,
    num_found: json['num_found'] as int,
    documentation_url: json['documentation_url'] as String,
    q: json['q'] as String,
    offset: json['offset'] as int?,
    docs: (json['docs'] as List? ?? []).map((e) => Docs.fromJson(e as Map<String, dynamic>)).toList()
  );

  Map<String, dynamic> toJson() => {
    'numFound': numFound,
    'start': start,
    'numFoundExact': numFoundExact,
    'num_found': num_found,
    'documentation_url': documentation_url,
    'q': q,
    'offset': offset,
    'docs': docs.map((e) => e.toJson()).toList()
  };
}

class Docs {
  final List<String> author_key;
  final List<String> author_name;
  final String cover_edition_key;
  final int cover_i;
  final String ebook_access;
  final int edition_count;
  final int first_publish_year;
  final bool has_fulltext;
  final List<String> ia;
  final List<String> ia_collection;
  final String key;
  final List<String> language;
  final String lending_edition_s;
  final String lending_identifier_s;
  final bool public_scan_b;
  final String title;
  final List<String> id_standard_ebooks;

  Docs({required this.author_key, required this.author_name, required this.cover_edition_key, required this.cover_i, required this.ebook_access, required this.edition_count, required this.first_publish_year, required this.has_fulltext, required this.ia, required this.ia_collection, required this.key, required this.language, required this.lending_edition_s, required this.lending_identifier_s, required this.public_scan_b, required this.title, required this.id_standard_ebooks});

  static List<String> _stringList(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return [];
  }

  factory Docs.fromJson(Map<String, dynamic> json) => Docs(
    author_key: _stringList(json['author_key']),
    author_name: _stringList(json['author_name']),
    cover_edition_key: json['cover_edition_key'] as String? ?? '',
    cover_i: json['cover_i'] as int? ?? 0,
    ebook_access: json['ebook_access'] as String? ?? '',
    edition_count: json['edition_count'] as int? ?? 0,
    first_publish_year: json['first_publish_year'] as int? ?? 0,
    has_fulltext: json['has_fulltext'] as bool? ?? false,
    ia: _stringList(json['ia']),
    ia_collection: _stringList(json['ia_collection']),
    key: json['key'] as String? ?? '',
    language: _stringList(json['language']),
    lending_edition_s: json['lending_edition_s'] as String? ?? '',
    lending_identifier_s: json['lending_identifier_s'] as String? ?? '',
    public_scan_b: json['public_scan_b'] as bool? ?? false,
    title: json['title'] as String? ?? '',
    id_standard_ebooks: _stringList(json['id_standard_ebooks'])
  );

  Map<String, dynamic> toJson() => {
    'author_key': author_key,
    'author_name': author_name,
    'cover_edition_key': cover_edition_key,
    'cover_i': cover_i,
    'ebook_access': ebook_access,
    'edition_count': edition_count,
    'first_publish_year': first_publish_year,
    'has_fulltext': has_fulltext,
    'ia': ia,
    'ia_collection': ia_collection,
    'key': key,
    'language': language,
    'lending_edition_s': lending_edition_s,
    'lending_identifier_s': lending_identifier_s,
    'public_scan_b': public_scan_b,
    'title': title,
    'id_standard_ebooks': id_standard_ebooks
  };
}