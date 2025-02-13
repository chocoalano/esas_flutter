import 'action.dart';

class Data {
  List<Action>? actions;
  String? body;
  dynamic color;
  String? duration;
  String? icon;
  String? iconColor;
  String? status;
  String? title;
  String? view;
  List<dynamic>? viewData;
  String? format;

  Data({
    this.actions,
    this.body,
    this.color,
    this.duration,
    this.icon,
    this.iconColor,
    this.status,
    this.title,
    this.view,
    this.viewData,
    this.format,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        actions: json["actions"] == null
            ? []
            : List<Action>.from(
                json["actions"]!.map((x) => Action.fromJson(x))),
        body: json["body"],
        color: json["color"],
        duration: json["duration"],
        icon: json["icon"],
        iconColor: json["iconColor"],
        status: json["status"],
        title: json["title"],
        view: json["view"],
        viewData: json["viewData"] == null
            ? []
            : List<dynamic>.from(json["viewData"]!.map((x) => x)),
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "actions": actions == null
            ? []
            : List<dynamic>.from(actions!.map((x) => x.toJson())),
        "body": body,
        "color": color,
        "duration": duration,
        "icon": icon,
        "iconColor": iconColor,
        "status": status,
        "title": title,
        "view": view,
        "viewData":
            viewData == null ? [] : List<dynamic>.from(viewData!.map((x) => x)),
        "format": format,
      };
}
