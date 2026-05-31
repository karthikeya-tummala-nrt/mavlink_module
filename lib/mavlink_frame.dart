library mavlink_module;

import 'package:mavlink_module/crc.dart';
import 'package:mavlink_module/mavlink_signer.dart';

import 'mavlink_version.dart';
import 'mavlink_message.dart';
import 'dart:typed_data';

class MavlinkFrame {
  static const mavlinkStxV1 = 0xFE;
  static const mavlinkStxV2 = 0xFD;

  final MavlinkVersion version;
  final int sequence;
  final int systemId;
  final int componentId;
  MavlinkMessage message;
  final MavlinkSigner? signer;
  final bool signed;
  final int? linkId;
  final int? timestamp;

  MavlinkFrame(this.version, this.sequence, this.systemId, this.componentId,
      this.message,
      {this.signed = false, this.signer, this.linkId, this.timestamp})
      : assert(!signed || (signer != null && linkId != null && timestamp != null),
            'signer, linkId, and timestamp are required when signed is true');

  /// Create MavlinkFrame for MAVLink version1.
  factory MavlinkFrame.v1(
      int sequence, int systemId, int componentId, MavlinkMessage message) {
    return MavlinkFrame(
        MavlinkVersion.v1, sequence, systemId, componentId, message);
  }

  /// Create MavlinkFrame for MAVLink version2.
  factory MavlinkFrame.v2(
      int sequence, int systemId, int componentId, MavlinkMessage message,
      {bool signed = false,
      MavlinkSigner? signer,
      int? linkId,
      int? timestamp}) {
    return MavlinkFrame(
        MavlinkVersion.v2, sequence, systemId, componentId, message,
        signed: signed, signer: signer, linkId: linkId, timestamp: timestamp);
  }

  Uint8List serialize() {
    switch (version) {
      case MavlinkVersion.v1:
        return _serializeV1();
      case MavlinkVersion.v2:
        return _serializeV2();
      default:
        throw UnsupportedError('Unknown MAVLink message: $version');
    }
  }

  Uint8List _serializeV1() {
    if (version != MavlinkVersion.v1) {
      throw UnsupportedError('Unexpected MAVLink version($version)');
    }

    var payload = message.serialize();
    var payloadLength = payload.lengthInBytes;

    var bytes = ByteData(8 + payloadLength);
    bytes.setUint8(0, mavlinkStxV1);
    bytes.setUint8(1, payloadLength);
    bytes.setUint8(2, sequence);
    bytes.setUint8(3, systemId);
    bytes.setUint8(4, componentId);
    bytes.setUint8(5, message.mavlinkMessageId);

    var crc = CrcX25();
    crc.accumulate(payloadLength);
    crc.accumulate(sequence);
    crc.accumulate(systemId);
    crc.accumulate(componentId);
    crc.accumulate(message.mavlinkMessageId);

    var payloadBytes = payload.buffer.asUint8List();
    for (var i = 0; i < payloadLength; i++) {
      bytes.setUint8(6 + i, payloadBytes[i]);
      crc.accumulate(payloadBytes[i]);
    }
    crc.accumulate(message.mavlinkCrcExtra);

    bytes.setUint8(bytes.lengthInBytes - 2, crc.crc & 0xff);
    bytes.setUint8(bytes.lengthInBytes - 1, (crc.crc >> 8) & 0xff);

    return bytes.buffer.asUint8List();
  }

  Uint8List _serializeV2() {
    if (version != MavlinkVersion.v2) {
      throw UnsupportedError('Unexpected MAVLink version($version)');
    }

    int incompatibilityFlags = signed ? 0x01 : 0x00;
    int compatibilityFlags = 0;
    var payload = message.serialize();
    var payloadLength = payload.lengthInBytes;
    var messageIdBytes = [
      message.mavlinkMessageId & 0xff,
      (message.mavlinkMessageId >> 8) & 0xff,
      (message.mavlinkMessageId >> 16) & 0xff
    ];
    final signatureLength = MavlinkSigner.signatureLength;

    var bytes = ByteData(12 + payloadLength + (signed ? signatureLength : 0));
    bytes.setUint8(0, mavlinkStxV2);
    bytes.setUint8(1, payloadLength);
    bytes.setUint8(2, incompatibilityFlags);
    bytes.setUint8(3, compatibilityFlags);
    bytes.setUint8(4, sequence);
    bytes.setUint8(5, systemId);
    bytes.setUint8(6, componentId);
    bytes.setUint8(7, messageIdBytes[0]);
    bytes.setUint8(8, messageIdBytes[1]);
    bytes.setUint8(9, messageIdBytes[2]);

    var crc = CrcX25();
    crc.accumulate(payloadLength);
    crc.accumulate(incompatibilityFlags);
    crc.accumulate(compatibilityFlags);
    crc.accumulate(sequence);
    crc.accumulate(systemId);
    crc.accumulate(componentId);
    crc.accumulate(messageIdBytes[0]);
    crc.accumulate(messageIdBytes[1]);
    crc.accumulate(messageIdBytes[2]);

    var payloadBytes = payload.buffer.asUint8List(0, payloadLength);
    for (var i = 0; i < payloadLength; i++) {
      bytes.setUint8(10 + i, payloadBytes[i]);
      crc.accumulate(payloadBytes[i]);
    }
    crc.accumulate(message.mavlinkCrcExtra);

    final crcValue = crc.crc;

    // Little Endian
    final crcBytes = Uint8List(2)
      ..[0] = crcValue & 0xFF
      ..[1] = (crcValue >> 8) & 0xFF;

    final crcOffset = 10 + payloadLength;

    bytes.setUint8(crcOffset, crcBytes[0]);
    bytes.setUint8(crcOffset + 1, crcBytes[1]);

    final signatureHeader = Uint8List.fromList([
      mavlinkStxV2,
      payloadLength,
      incompatibilityFlags,
      compatibilityFlags,
      sequence,
      systemId,
      componentId,
      messageIdBytes[0],
      messageIdBytes[1],
      messageIdBytes[2],
    ]);

    if (signed) {
      final signature = signer!.signPacket(
        header: signatureHeader,
        payload: payloadBytes,
        crc: crcBytes,
        linkId: linkId!,
        timestamp: timestamp!,
      );

      final offset = 12 + payloadLength;

      for (int i = 0; i < signature.length; i++) {
        bytes.setUint8(offset + i, signature[i]);
      }
    }

    return bytes.buffer.asUint8List();
  }
}
