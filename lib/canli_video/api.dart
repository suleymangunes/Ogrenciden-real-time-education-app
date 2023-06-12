import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJjZDFkODNlMS1kYmQzLTRkYzUtODI1Zi1hZDdiMDgyNDFiYTgiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY4NjI0NDI4MSwiZXhwIjoxNjg4ODM2MjgxfQ.QD01NQQevank-fbsSPbykE24qnYGFhe1oHDYlrGkOMs";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
