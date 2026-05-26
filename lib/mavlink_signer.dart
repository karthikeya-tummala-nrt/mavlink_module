import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class MavlinkSigner {
  static const int signatureLength = 13;
  static const int hashLength = 6;

  Uint8List secretKey;
  int linkId;
  int timestamp;
  final Map<String, int> _lastTimestamps = {};

  MavlinkSigner({required this.secretKey, int? linkId, int? timestamp})
    : linkId = linkId ?? 0x01,
      timestamp =
          timestamp ??
          DateTime.now()
                  .toUtc()
                  .difference(DateTime.utc(2015, 1, 1))
                  .inMicroseconds ~/ 10; // 10 micro second units

  Uint8List signPacket({
    required Uint8List header,
    required Uint8List payload,
    required Uint8List crc,
  }) {
    final signature = Uint8List(signatureLength);
    // First 7 bytes: link ID + low 6 bytes of timestamp
    signature[0] = linkId;
    for (int i = 0; i < 6; i++) {
      signature[i + 1] = (timestamp >> (8 * i)) & 0xFF;
    }

    timestamp++;

    // Build SHA256 over: secretKey || header || payload || crc || signature[0..6]
    final digest = sha256.convert([
      ...secretKey,
      ...header,
      ...payload,
      ...crc,
      ...signature.sublist(0, 7),
    ]);

    signature.setRange(7, 13, digest.bytes.sublist(0, 6));
    return signature;
  }

  bool verifySignature({
    required int systemId,
    required int componentId,
    required Uint8List header,
    required Uint8List payload,
    required Uint8List crc,
    required Uint8List signature, // 13 bytes from packet
    int timestampWindow10Us =
        60 *
        100000,
  }) {
    if (signature.length != signatureLength) return false;

    int packetLinkId = signature[0];
    // Extract timestamp (little-endian)
    int packetTimestamp = 0;
    for (int i = 0; i < 6; i++) {
      packetTimestamp |= signature[i + 1] << (8 * i);
    }

    // Recompute SHA256: secretKey || header || payload || crc || signature[0..6]
    final digest = sha256.convert([
      ...secretKey,
      ...header,
      ...payload,
      ...crc,
      ...signature.sublist(0, 7),
    ]);

    // Compare first 6 bytes of digest with signature[7..12]
    for (int i = 0; i < hashLength; i++) {
      if (digest.bytes[i] != signature[7 + i]) return false;
    }

    final streamKey = '$systemId:$componentId:$packetLinkId';

    final lastTimestamp = _lastTimestamps[streamKey];

    if (lastTimestamp != null &&
        packetTimestamp + timestampWindow10Us < lastTimestamp) {
      return false;
    }

    _lastTimestamps[streamKey] = packetTimestamp;

    return true;
  }
}
