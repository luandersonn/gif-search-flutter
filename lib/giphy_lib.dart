import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GiphyLibrary {
  GiphyLibrary({@required this.apiKey});
  final String apiKey;
  Future<GiphyRequest> fetchTrendingGifs(
      {int limit = 20, int offset = 0}) async {
    var url = Uri.encodeFull(
        'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=$limit&offset=$offset');
    print(url);
    var result = await request(Uri.parse(url));
    return GiphyRequest.fromJson(jsonDecode(result));
  }

  Future<String> request(Uri url) async {
    final response = await http.get(url).timeout(const Duration(seconds: 20));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load response');
    }
  }
}

class GiphyRequest {
  List<GiphyRequestData> data;
  Pagination pagination;
  Meta meta;

  GiphyRequest({this.data, this.pagination, this.meta});

  GiphyRequest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new GiphyRequestData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class GiphyRequestData {
  String id;
  String url;
  String title;
  Gifs images;

  GiphyRequestData({this.id, this.url, this.title, this.images});

  GiphyRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    images = json['images'] != null ? new Gifs.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    return data;
  }
}

class Gifs {
  Gif original;
  Gif fixedWidthDownsampled;

  Gifs({this.original, this.fixedWidthDownsampled});

  Gifs.fromJson(Map<String, dynamic> json) {
    original =
        json['original'] != null ? new Gif.fromJson(json['original']) : null;
    fixedWidthDownsampled = json['fixed_width_downsampled'] != null
        ? new Gif.fromJson(json['fixed_width_downsampled'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.original != null) {
      data['original'] = this.original.toJson();
    }
    if (this.fixedWidthDownsampled != null) {
      data['fixed_width_downsampled'] = this.fixedWidthDownsampled.toJson();
    }
    return data;
  }
}

class Gif {
  String url;

  Gif({this.url});

  Gif.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Pagination {
  int totalCount;
  int count;
  int offset;

  Pagination({this.totalCount, this.count, this.offset});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    count = json['count'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['count'] = this.count;
    data['offset'] = this.offset;
    return data;
  }
}

class Meta {
  int status;
  String msg;
  String responseId;

  Meta({this.status, this.msg, this.responseId});

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    responseId = json['response_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['response_id'] = this.responseId;
    return data;
  }
}
