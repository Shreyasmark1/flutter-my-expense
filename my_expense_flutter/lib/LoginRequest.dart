class LoginRequest {
  String status;
  LoginRequest({required this.status});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        status: json["status"],
      );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //     };
}
//factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }