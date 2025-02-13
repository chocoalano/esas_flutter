class Action {
  String? name;
  dynamic color;
  dynamic event;
  List<dynamic>? eventData;
  bool? dispatchDirection;
  dynamic dispatchToComponent;
  List<dynamic>? extraAttributes;
  dynamic icon;
  String? iconPosition;
  dynamic iconSize;
  bool? isOutlined;
  bool? isDisabled;
  String? label;
  bool? shouldClose;
  bool? shouldMarkAsRead;
  bool? shouldMarkAsUnread;
  bool? shouldOpenUrlInNewTab;
  String? size;
  dynamic tooltip;
  String? url;
  String? view;

  Action({
    this.name,
    this.color,
    this.event,
    this.eventData,
    this.dispatchDirection,
    this.dispatchToComponent,
    this.extraAttributes,
    this.icon,
    this.iconPosition,
    this.iconSize,
    this.isOutlined,
    this.isDisabled,
    this.label,
    this.shouldClose,
    this.shouldMarkAsRead,
    this.shouldMarkAsUnread,
    this.shouldOpenUrlInNewTab,
    this.size,
    this.tooltip,
    this.url,
    this.view,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"],
        color: json["color"],
        event: json["event"],
        eventData: json["eventData"] == null
            ? []
            : List<dynamic>.from(json["eventData"]!.map((x) => x)),
        dispatchDirection: json["dispatchDirection"],
        dispatchToComponent: json["dispatchToComponent"],
        extraAttributes: json["extraAttributes"] == null
            ? []
            : List<dynamic>.from(json["extraAttributes"]!.map((x) => x)),
        icon: json["icon"],
        iconPosition: json["iconPosition"],
        iconSize: json["iconSize"],
        isOutlined: json["isOutlined"],
        isDisabled: json["isDisabled"],
        label: json["label"],
        shouldClose: json["shouldClose"],
        shouldMarkAsRead: json["shouldMarkAsRead"],
        shouldMarkAsUnread: json["shouldMarkAsUnread"],
        shouldOpenUrlInNewTab: json["shouldOpenUrlInNewTab"],
        size: json["size"],
        tooltip: json["tooltip"],
        url: json["url"],
        view: json["view"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
        "event": event,
        "eventData": eventData == null
            ? []
            : List<dynamic>.from(eventData!.map((x) => x)),
        "dispatchDirection": dispatchDirection,
        "dispatchToComponent": dispatchToComponent,
        "extraAttributes": extraAttributes == null
            ? []
            : List<dynamic>.from(extraAttributes!.map((x) => x)),
        "icon": icon,
        "iconPosition": iconPosition,
        "iconSize": iconSize,
        "isOutlined": isOutlined,
        "isDisabled": isDisabled,
        "label": label,
        "shouldClose": shouldClose,
        "shouldMarkAsRead": shouldMarkAsRead,
        "shouldMarkAsUnread": shouldMarkAsUnread,
        "shouldOpenUrlInNewTab": shouldOpenUrlInNewTab,
        "size": size,
        "tooltip": tooltip,
        "url": url,
        "view": view,
      };
}
