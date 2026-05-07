import 'dart:typed_data';
import 'package:mavlink_module/mavlink_dialect.dart';
import 'package:mavlink_module/mavlink_message.dart';
import 'package:mavlink_module/types.dart';

/// MAVLINK component type reported in HEARTBEAT message. Flight controllers must report the type of the vehicle on which they are mounted (e.g. MAV_TYPE_OCTOROTOR). All other components must report a value appropriate for their type (e.g. a camera must use MAV_TYPE_CAMERA).
/// MAV_TYPE
typedef MavType = int;

/// Generic micro air vehicle
/// MAV_TYPE_GENERIC
const MavType mavTypeGeneric = 0;

/// Onboard companion controller
/// MAV_TYPE_ONBOARD_CONTROLLER
const MavType mavTypeOnboardController = 18;

/// Micro air vehicle / autopilot classes. This identifies the individual model.
/// MAV_AUTOPILOT
typedef MavAutopilot = int;

/// Generic autopilot, full support for everything
/// MAV_AUTOPILOT_GENERIC
const MavAutopilot mavAutopilotGeneric = 0;

/// No valid autopilot, e.g. a GCS or other MAVLink component
/// MAV_AUTOPILOT_INVALID
const MavAutopilot mavAutopilotInvalid = 8;

/// MAV_STATE
typedef MavState = int;

/// Uninitialized system, state is unknown.
/// MAV_STATE_UNINIT
const MavState mavStateUninit = 0;

/// System is grounded and on standby. It can be launched any time.
/// MAV_STATE_STANDBY
const MavState mavStateStandby = 3;

/// System is active and might be already airborne. Motors are engaged.
/// MAV_STATE_ACTIVE
const MavState mavStateActive = 4;

/// Commands to be executed by the MAV. They can be executed on user request, or as part of a mission script. If the action is used in a mission, the parameter mapping to the waypoint/mission message is as follows: Param 1, Param 2, Param 3, Param 4, X: Param 5, Y:Param 6, Z:Param 7. This command list is similar what ARINC 424 is for commercial aircraft: A data format how to interpret waypoint/mission data. NaN and INT32_MAX may be used in float/integer params (respectively) to indicate optional/default values (e.g. to use the component's current yaw or latitude rather than a specific value). See https://mavlink.io/en/guide/xml_schema.html#MAV_CMD for information about the structure of the MAV_CMD entries
/// MAV_CMD
typedef MavCmd = int;

/// Set system mode.
/// MAV_CMD_DO_SET_MODE
const MavCmd mavCmdDoSetMode = 176;

/// Arms / Disarms a component
/// MAV_CMD_COMPONENT_ARM_DISARM
const MavCmd mavCmdComponentArmDisarm = 400;

/// Request the target system(s) emit a single instance of a specified message (i.e. a "one-shot" version of MAV_CMD_SET_MESSAGE_INTERVAL).
/// MAV_CMD_REQUEST_MESSAGE
const MavCmd mavCmdRequestMessage = 512;

/// Result from a MAVLink command (MAV_CMD)
/// MAV_RESULT
typedef MavResult = int;

/// Command is valid (is supported and has valid parameters), and was executed.
/// MAV_RESULT_ACCEPTED
const MavResult mavResultAccepted = 0;

/// Command is valid, but cannot be executed at this time. This is used to indicate a problem that should be fixed just by waiting (e.g. a state machine is busy, can't arm because have not got GPS lock, etc.). Retrying later should work.
/// MAV_RESULT_TEMPORARILY_REJECTED
const MavResult mavResultTemporarilyRejected = 1;

/// Command is invalid; it is supported but one or more parameter values are invalid (i.e. parameter reserved, value allowed by spec but not supported by flight stack, and so on). Retrying the same command and parameters will not work.
/// MAV_RESULT_DENIED
const MavResult mavResultDenied = 2;

/// Command is not supported (unknown).
/// MAV_RESULT_UNSUPPORTED
const MavResult mavResultUnsupported = 3;

/// Command is valid, but execution has failed. This is used to indicate any non-temporary or unexpected problem, i.e. any problem that must be fixed before the command can succeed/be retried. For example, attempting to write a file when out of memory, attempting to arm when sensors are not calibrated, etc.
/// MAV_RESULT_FAILED
const MavResult mavResultFailed = 4;

/// Command is valid and is being executed. This will be followed by further progress updates, i.e. the component may send further COMMAND_ACK messages with result MAV_RESULT_IN_PROGRESS (at a rate decided by the implementation), and must terminate by sending a COMMAND_ACK message with final result of the operation. The COMMAND_ACK.progress field can be used to indicate the progress of the operation.
/// MAV_RESULT_IN_PROGRESS
const MavResult mavResultInProgress = 5;

/// Command has been cancelled (as a result of receiving a COMMAND_CANCEL message).
/// MAV_RESULT_CANCELLED
const MavResult mavResultCancelled = 6;

/// Command is only accepted when sent as a COMMAND_LONG.
/// MAV_RESULT_COMMAND_LONG_ONLY
const MavResult mavResultCommandLongOnly = 7;

/// Command is only accepted when sent as a COMMAND_INT.
/// MAV_RESULT_COMMAND_INT_ONLY
const MavResult mavResultCommandIntOnly = 8;

/// Command is invalid because a frame is required and the specified frame is not supported.
/// MAV_RESULT_COMMAND_UNSUPPORTED_MAV_FRAME
const MavResult mavResultCommandUnsupportedMavFrame = 9;

/// WIP.
/// Command has been rejected because source system is not in control of the target system/component.
/// MAV_RESULT_NOT_IN_CONTROL
const MavResult mavResultNotInControl = 10;

/// Enum used to indicate true or false (also: success or failure, enabled or disabled, active or inactive).
/// MAV_BOOL
typedef MavBool = int;

/// False.
/// MAV_BOOL_FALSE
const MavBool mavBoolFalse = 0;

/// True.
/// MAV_BOOL_TRUE
const MavBool mavBoolTrue = 1;

/// Used to indicate the current state of the extra feature buttons
/// PUSH_BUTTONS
typedef PushButtons = int;

/// a single short press of extra feature 1 button.
/// EXTRA_FEATURE_1_PRESS
const PushButtons extraFeature1Press = 1;

/// a long press of extra feature 1 button.
/// EXTRA_FEATURE_1_LONG_PRESS
const PushButtons extraFeature1LongPress = 2;

/// a single short press of extra feature 2 button.
/// EXTRA_FEATURE_2_PRESS
const PushButtons extraFeature2Press = 4;

/// a long press of extra feature 2 button.
/// EXTRA_FEATURE_2_LONG_PRESS
const PushButtons extraFeature2LongPress = 8;

/// Used to indicate the position of the tristate toggle switches.
/// TOGGLE_SWITCH_POS
typedef ToggleSwitchPos = int;

/// 0x01 Forward Direction
/// FORWARD_DIRECTION
const ToggleSwitchPos forwardDirection = 1;

/// 0x02 Reverse Direction
/// REVERSE_DIRECTION
const ToggleSwitchPos reverseDirection = 2;

/// 0x04 Medium Speed
/// MEDIUM_SPEED
const ToggleSwitchPos mediumSpeed = 4;

/// 0x08 High Speed
/// HIGH_SPEED
const ToggleSwitchPos highSpeed = 8;

/// These flags encode the MAV mode, see MAV_MODE enum for useful combinations.
/// MAV_MODE_FLAG
typedef MavModeFlag = int;

/// 0b10000000 MAV safety set to armed. Motors are enabled / running / can start. Ready to fly. Additional note: this flag is to be ignore when sent in the command MAV_CMD_DO_SET_MODE and MAV_CMD_COMPONENT_ARM_DISARM shall be used instead. The flag can still be used to report the armed state.
/// MAV_MODE_FLAG_SAFETY_ARMED
const MavModeFlag mavModeFlagSafetyArmed = 128;

/// 0b01000000 remote control input is enabled.
/// MAV_MODE_FLAG_MANUAL_INPUT_ENABLED
const MavModeFlag mavModeFlagManualInputEnabled = 64;

/// 0b00100000 hardware in the loop simulation. All motors / actuators are blocked, but internal software is full operational.
/// MAV_MODE_FLAG_HIL_ENABLED
const MavModeFlag mavModeFlagHilEnabled = 32;

/// 0b00010000 system stabilizes electronically its attitude (and optionally position). It needs however further control inputs to move around.
/// MAV_MODE_FLAG_STABILIZE_ENABLED
const MavModeFlag mavModeFlagStabilizeEnabled = 16;

/// 0b00001000 guided mode enabled, system flies waypoints / mission items.
/// MAV_MODE_FLAG_GUIDED_ENABLED
const MavModeFlag mavModeFlagGuidedEnabled = 8;

/// 0b00000100 autonomous mode enabled, system finds its own goal positions. Guided flag can be set or not, depends on the actual implementation.
/// MAV_MODE_FLAG_AUTO_ENABLED
const MavModeFlag mavModeFlagAutoEnabled = 4;

/// 0b00000010 system has a test mode enabled. This flag is intended for temporary system tests and should not be used for stable implementations.
/// MAV_MODE_FLAG_TEST_ENABLED
const MavModeFlag mavModeFlagTestEnabled = 2;

/// 0b00000001 system-specific custom mode is enabled. When using this flag to enable a custom mode all other flags should be ignored.
/// MAV_MODE_FLAG_CUSTOM_MODE_ENABLED
const MavModeFlag mavModeFlagCustomModeEnabled = 1;

/// These encode the sub systems whose status is sent as part of the UGV_MASTER_HEALTH message.
/// UGV_COMP_BITMASK
typedef UgvCompBitmask = int;

/// 0x01 Atlas Compute
/// UGV_COMP_COMP_COMPUTE
const UgvCompBitmask ugvCompCompCompute = 1;

/// 0x02 Vehicle Control Unit (VCU)
/// UGV_COMP_VCU
const UgvCompBitmask ugvCompVcu = 2;

/// 0x04 Motor Controller (front)
/// UGV_COMP_MOTOR_FRONT
const UgvCompBitmask ugvCompMotorFront = 4;

/// 0x08 Motor Controller (rear)
/// UGV_COMP_MOTOR_REAR
const UgvCompBitmask ugvCompMotorRear = 8;

/// 0x10 Battery Management System (BMS)
/// UGV_COMP_BMS
const UgvCompBitmask ugvCompBms = 16;

/// 0x20 Power Distribution Unit (PDU)
/// UGV_COMP_PDU
const UgvCompBitmask ugvCompPdu = 32;

/// 0x40 Inertial Navigation System (INS)
/// UGV_COMP_INS
const UgvCompBitmask ugvCompIns = 64;

/// 0x80 GNSS
/// UGV_COMP_GNSS
const UgvCompBitmask ugvCompGnss = 128;

/// 0x100 Ultrasonic sensors
/// UGV_COMP_ULTRASONIC
const UgvCompBitmask ugvCompUltrasonic = 256;

/// 0x200 3D Lidar
/// UGV_COMP_LIDAR
const UgvCompBitmask ugvCompLidar = 512;

/// 0x400 Display unit
/// UGV_COMP_DISPLAY
const UgvCompBitmask ugvCompDisplay = 1024;

/// 0x800 UHF Radio link
/// UGV_COMP_UHF_RADIO
const UgvCompBitmask ugvCompUhfRadio = 2048;

/// 0x1000 Hand Controller
/// UGV_COMP_HAND_CTRL
const UgvCompBitmask ugvCompHandCtrl = 4096;

/// 0x2000 Ground Control Station (GCS)
/// UGV_COMP_GCS
const UgvCompBitmask ugvCompGcs = 8192;

/// These encode the sub systems whose status is sent as part of the UGV_MASTER_HEALTH message.
/// UGV_MOTOR_ERROR_BITMASK
typedef UgvMotorErrorBitmask = int;

/// 0x01 Motor Overload
/// MOTOR_OVERLOAD
const UgvMotorErrorBitmask motorOverload = 1;

/// 0x02 Motor Overtemperature
/// MOTOR_OVERVTEMP
const UgvMotorErrorBitmask motorOvervtemp = 2;

/// 0x04 Motor Controller (left)
/// MOTOR_OVER_SPEED
const UgvMotorErrorBitmask motorOverSpeed = 4;

/// 0x08 Motor Controller (right)
/// MOTOR_STALLED
const UgvMotorErrorBitmask motorStalled = 8;

/// 0x10 Battery Management System (BMS)
/// MOTOR_PHASE_LOSS
const UgvMotorErrorBitmask motorPhaseLoss = 16;

/// 0x20 Power Distribution Unit (PDU)
/// MOTOR_HALL_FAULT
const UgvMotorErrorBitmask motorHallFault = 32;

/// 0x40 Display unit
/// MOTOR_ENCODER_FAULT
const UgvMotorErrorBitmask motorEncoderFault = 64;

/// 0x80 UHF Radio link
/// MOTOR_BRAKE_FAULT
const UgvMotorErrorBitmask motorBrakeFault = 128;

/// These encode the sub systems whose status is sent as part of the UGV_MASTER_HEALTH message.
/// UGV_SENSOR_ERROR_BITMASK
typedef UgvSensorErrorBitmask = int;

/// 0x01 Battery Under Voltage
/// BAT_UNDER_VOLTAGE
const UgvSensorErrorBitmask batUnderVoltage = 1;

/// 0x02 Battery Over Current
/// BAT_OVER_CURRENT
const UgvSensorErrorBitmask batOverCurrent = 2;

/// 0x04 Battery Over Voltage
/// BAT_OVER_VOLTAGE
const UgvSensorErrorBitmask batOverVoltage = 4;

/// 0x08 Battery Over Temperature
/// BAT_OVER_TEMP
const UgvSensorErrorBitmask batOverTemp = 8;

/// The heartbeat message shows that a system or component is present and responding. The type and autopilot fields (along with the message component id), allow the receiving system to treat further messages from this system appropriately (e.g. by laying out the user interface based on the autopilot). This microservice is documented at https://mavlink.io/en/services/heartbeat.html
/// HEARTBEAT
class Heartbeat implements MavlinkMessage {
  static const int _mavlinkMessageId = 0;

  static const int _mavlinkCrcExtra = 50;

  static const int mavlinkEncodedLength = 9;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// A bitfield for use for autopilot-specific flags
  /// MAVLink type: uint32_t
  /// custom_mode
  final uint32_t customMode;

  /// Vehicle or component type. For a flight controller component the vehicle type (quadrotor, helicopter, etc.). For other components the component type (e.g. camera, gimbal, etc.). This should be used in preference to component id for identifying the component type.
  /// MAVLink type: uint8_t
  /// enum: [MavType]
  /// type
  final MavType type;

  /// Autopilot type / class. Use MAV_AUTOPILOT_INVALID for components that are not flight controllers.
  /// MAVLink type: uint8_t
  /// enum: [MavAutopilot]
  /// autopilot
  final MavAutopilot autopilot;

  /// System mode bitmap.
  /// MAVLink type: uint8_t
  /// enum: [MavModeFlag]
  /// base_mode
  final MavModeFlag baseMode;

  /// System status flag.
  /// MAVLink type: uint8_t
  /// enum: [MavState]
  /// system_status
  final MavState systemStatus;

  /// MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
  /// MAVLink type: uint8_t
  /// mavlink_version
  final uint8_t mavlinkVersion;

  Heartbeat({
    required this.customMode,
    required this.type,
    required this.autopilot,
    required this.baseMode,
    required this.systemStatus,
    required this.mavlinkVersion,
  });

  Heartbeat copyWith({
    uint32_t? customMode,
    MavType? type,
    MavAutopilot? autopilot,
    MavModeFlag? baseMode,
    MavState? systemStatus,
    uint8_t? mavlinkVersion,
  }) {
    return Heartbeat(
      customMode: customMode ?? this.customMode,
      type: type ?? this.type,
      autopilot: autopilot ?? this.autopilot,
      baseMode: baseMode ?? this.baseMode,
      systemStatus: systemStatus ?? this.systemStatus,
      mavlinkVersion: mavlinkVersion ?? this.mavlinkVersion,
    );
  }

  factory Heartbeat.parse(ByteData data_) {
    if (data_.lengthInBytes < Heartbeat.mavlinkEncodedLength) {
      var len = Heartbeat.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var customMode = data_.getUint32(0, Endian.little);
    var type = data_.getUint8(4);
    var autopilot = data_.getUint8(5);
    var baseMode = data_.getUint8(6);
    var systemStatus = data_.getUint8(7);
    var mavlinkVersion = data_.getUint8(8);

    return Heartbeat(
        customMode: customMode,
        type: type,
        autopilot: autopilot,
        baseMode: baseMode,
        systemStatus: systemStatus,
        mavlinkVersion: mavlinkVersion);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint32(0, customMode, Endian.little);
    data_.setUint8(4, type);
    data_.setUint8(5, autopilot);
    data_.setUint8(6, baseMode);
    data_.setUint8(7, systemStatus);
    data_.setUint8(8, mavlinkVersion);
    return data_;
  }
}

/// The system time is the time of the sender's master clock.
/// This can be emitted by flight controllers, onboard computers, or other components in the MAVLink network.
/// Components that are using a less reliable time source, such as a battery-backed real time clock, can choose to match their system clock to that of a system that indicates a more recent time.
/// This allows more broadly accurate date stamping of logs, and so on.
/// If precise time synchronization is needed then use TIMESYNC instead.
/// SYSTEM_TIME
class SystemTime implements MavlinkMessage {
  static const int _mavlinkMessageId = 2;

  static const int _mavlinkCrcExtra = 137;

  static const int mavlinkEncodedLength = 12;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Timestamp (UNIX epoch time).
  /// MAVLink type: uint64_t
  /// units: us
  /// time_unix_usec
  final uint64_t timeUnixUsec;

  /// Timestamp (time since system boot).
  /// MAVLink type: uint32_t
  /// units: ms
  /// time_boot_ms
  final uint32_t timeBootMs;

  SystemTime({
    required this.timeUnixUsec,
    required this.timeBootMs,
  });

  SystemTime copyWith({
    uint64_t? timeUnixUsec,
    uint32_t? timeBootMs,
  }) {
    return SystemTime(
      timeUnixUsec: timeUnixUsec ?? this.timeUnixUsec,
      timeBootMs: timeBootMs ?? this.timeBootMs,
    );
  }

  factory SystemTime.parse(ByteData data_) {
    if (data_.lengthInBytes < SystemTime.mavlinkEncodedLength) {
      var len = SystemTime.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var timeUnixUsec = data_.getUint64(0, Endian.little);
    var timeBootMs = data_.getUint32(8, Endian.little);

    return SystemTime(timeUnixUsec: timeUnixUsec, timeBootMs: timeBootMs);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint64(0, timeUnixUsec, Endian.little);
    data_.setUint32(8, timeBootMs, Endian.little);
    return data_;
  }
}

/// Manual (joystick) control message.
/// This message represents movement axes and button using standard joystick axes nomenclature. Unused axes can be disabled and buttons states are transmitted as individual on/off bits of a bitmask. For more information see https://mavlink.io/en/services/manual_control.html
/// MANUAL_CONTROL
class ManualControl implements MavlinkMessage {
  static const int _mavlinkMessageId = 69;

  static const int _mavlinkCrcExtra = 96;

  static const int mavlinkEncodedLength = 30;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
  /// MAVLink type: int16_t
  /// x
  final int16_t x;

  /// Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
  /// MAVLink type: int16_t
  /// y
  final int16_t y;

  /// Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle. Positive values are positive thrust, negative values are negative thrust.
  /// MAVLink type: int16_t
  /// z
  final int16_t z;

  /// R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with clockwise being 1000 and counter-clockwise being -1000, and the yaw of a vehicle.
  /// MAVLink type: int16_t
  /// r
  final int16_t r;

  /// A bitfield corresponding to the joystick buttons' 0-15 current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
  /// MAVLink type: uint16_t
  /// enum: [PushButtons]
  /// push_buttons
  final PushButtons pushButtons;

  /// The system to be controlled.
  /// MAVLink type: uint8_t
  /// target
  final uint8_t target;

  /// A bitfield corresponding to the joystick buttons' 16-31 current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 16.
  /// MAVLink type: uint16_t
  /// enum: [ToggleSwitchPos]
  /// Extensions field for MAVLink 2.
  /// tristate_toggle_switches
  final ToggleSwitchPos tristateToggleSwitches;

  /// Set bits to 1 to indicate which of the following extension fields contain valid data: bit 0: pitch, bit 1: roll, bit 2: aux1, bit 3: aux2, bit 4: aux3, bit 5: aux4, bit 6: aux5, bit 7: aux6
  /// MAVLink type: uint8_t
  /// Extensions field for MAVLink 2.
  /// enabled_extensions
  final uint8_t enabledExtensions;

  /// Pitch-only-axis, normalized to the range [-1000,1000]. Generally corresponds to pitch on vehicles with additional degrees of freedom. Valid if bit 0 of enabled_extensions field is set. Set to 0 if invalid.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// s
  final int16_t s;

  /// Roll-only-axis, normalized to the range [-1000,1000]. Generally corresponds to roll on vehicles with additional degrees of freedom. Valid if bit 1 of enabled_extensions field is set. Set to 0 if invalid.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// t
  final int16_t t;

  /// Aux continuous input field 1. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 2 of enabled_extensions field is set. 0 if bit 2 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux1
  final int16_t aux1;

  /// Aux continuous input field 2. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 3 of enabled_extensions field is set. 0 if bit 3 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux2
  final int16_t aux2;

  /// Aux continuous input field 3. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 4 of enabled_extensions field is set. 0 if bit 4 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux3
  final int16_t aux3;

  /// Aux continuous input field 4. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 5 of enabled_extensions field is set. 0 if bit 5 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux4
  final int16_t aux4;

  /// Aux continuous input field 5. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 6 of enabled_extensions field is set. 0 if bit 6 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux5
  final int16_t aux5;

  /// Aux continuous input field 6. Normalized in the range [-1000,1000]. Purpose defined by recipient. Valid data if bit 7 of enabled_extensions field is set. 0 if bit 7 is unset.
  /// MAVLink type: int16_t
  /// Extensions field for MAVLink 2.
  /// aux6
  final int16_t aux6;

  ManualControl({
    required this.x,
    required this.y,
    required this.z,
    required this.r,
    required this.pushButtons,
    required this.target,
    required this.tristateToggleSwitches,
    required this.enabledExtensions,
    required this.s,
    required this.t,
    required this.aux1,
    required this.aux2,
    required this.aux3,
    required this.aux4,
    required this.aux5,
    required this.aux6,
  });

  ManualControl copyWith({
    int16_t? x,
    int16_t? y,
    int16_t? z,
    int16_t? r,
    PushButtons? pushButtons,
    uint8_t? target,
    ToggleSwitchPos? tristateToggleSwitches,
    uint8_t? enabledExtensions,
    int16_t? s,
    int16_t? t,
    int16_t? aux1,
    int16_t? aux2,
    int16_t? aux3,
    int16_t? aux4,
    int16_t? aux5,
    int16_t? aux6,
  }) {
    return ManualControl(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      r: r ?? this.r,
      pushButtons: pushButtons ?? this.pushButtons,
      target: target ?? this.target,
      tristateToggleSwitches:
          tristateToggleSwitches ?? this.tristateToggleSwitches,
      enabledExtensions: enabledExtensions ?? this.enabledExtensions,
      s: s ?? this.s,
      t: t ?? this.t,
      aux1: aux1 ?? this.aux1,
      aux2: aux2 ?? this.aux2,
      aux3: aux3 ?? this.aux3,
      aux4: aux4 ?? this.aux4,
      aux5: aux5 ?? this.aux5,
      aux6: aux6 ?? this.aux6,
    );
  }

  factory ManualControl.parse(ByteData data_) {
    if (data_.lengthInBytes < ManualControl.mavlinkEncodedLength) {
      var len = ManualControl.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var x = data_.getInt16(0, Endian.little);
    var y = data_.getInt16(2, Endian.little);
    var z = data_.getInt16(4, Endian.little);
    var r = data_.getInt16(6, Endian.little);
    var pushButtons = data_.getUint16(8, Endian.little);
    var target = data_.getUint8(10);
    var tristateToggleSwitches = data_.getUint16(11, Endian.little);
    var enabledExtensions = data_.getUint8(13);
    var s = data_.getInt16(14, Endian.little);
    var t = data_.getInt16(16, Endian.little);
    var aux1 = data_.getInt16(18, Endian.little);
    var aux2 = data_.getInt16(20, Endian.little);
    var aux3 = data_.getInt16(22, Endian.little);
    var aux4 = data_.getInt16(24, Endian.little);
    var aux5 = data_.getInt16(26, Endian.little);
    var aux6 = data_.getInt16(28, Endian.little);

    return ManualControl(
        x: x,
        y: y,
        z: z,
        r: r,
        pushButtons: pushButtons,
        target: target,
        tristateToggleSwitches: tristateToggleSwitches,
        enabledExtensions: enabledExtensions,
        s: s,
        t: t,
        aux1: aux1,
        aux2: aux2,
        aux3: aux3,
        aux4: aux4,
        aux5: aux5,
        aux6: aux6);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setInt16(0, x, Endian.little);
    data_.setInt16(2, y, Endian.little);
    data_.setInt16(4, z, Endian.little);
    data_.setInt16(6, r, Endian.little);
    data_.setUint16(8, pushButtons, Endian.little);
    data_.setUint8(10, target);
    data_.setUint16(11, tristateToggleSwitches, Endian.little);
    data_.setUint8(13, enabledExtensions);
    data_.setInt16(14, s, Endian.little);
    data_.setInt16(16, t, Endian.little);
    data_.setInt16(18, aux1, Endian.little);
    data_.setInt16(20, aux2, Endian.little);
    data_.setInt16(22, aux3, Endian.little);
    data_.setInt16(24, aux4, Endian.little);
    data_.setInt16(26, aux5, Endian.little);
    data_.setInt16(28, aux6, Endian.little);
    return data_;
  }
}

/// Send a command with up to seven parameters to the MAV. COMMAND_INT is generally preferred when sending MAV_CMD commands that include positional information; it offers higher precision and allows the MAV_FRAME to be specified (which may otherwise be ambiguous, particularly for altitude). The command microservice is documented at https://mavlink.io/en/services/command.html
/// COMMAND_LONG
class CommandLong implements MavlinkMessage {
  static const int _mavlinkMessageId = 76;

  static const int _mavlinkCrcExtra = 152;

  static const int mavlinkEncodedLength = 33;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Parameter 1 (for the specific command).
  /// MAVLink type: float
  /// param1
  final float param1;

  /// Parameter 2 (for the specific command).
  /// MAVLink type: float
  /// param2
  final float param2;

  /// Parameter 3 (for the specific command).
  /// MAVLink type: float
  /// param3
  final float param3;

  /// Parameter 4 (for the specific command).
  /// MAVLink type: float
  /// param4
  final float param4;

  /// Parameter 5 (for the specific command).
  /// MAVLink type: float
  /// param5
  final float param5;

  /// Parameter 6 (for the specific command).
  /// MAVLink type: float
  /// param6
  final float param6;

  /// Parameter 7 (for the specific command).
  /// MAVLink type: float
  /// param7
  final float param7;

  /// Command ID (of command to send).
  /// MAVLink type: uint16_t
  /// enum: [MavCmd]
  /// command
  final MavCmd command;

  /// System which should execute the command
  /// MAVLink type: uint8_t
  /// target_system
  final uint8_t targetSystem;

  /// Component which should execute the command, 0 for all components
  /// MAVLink type: uint8_t
  /// target_component
  final uint8_t targetComponent;

  /// 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
  /// MAVLink type: uint8_t
  /// confirmation
  final uint8_t confirmation;

  CommandLong({
    required this.param1,
    required this.param2,
    required this.param3,
    required this.param4,
    required this.param5,
    required this.param6,
    required this.param7,
    required this.command,
    required this.targetSystem,
    required this.targetComponent,
    required this.confirmation,
  });

  CommandLong copyWith({
    float? param1,
    float? param2,
    float? param3,
    float? param4,
    float? param5,
    float? param6,
    float? param7,
    MavCmd? command,
    uint8_t? targetSystem,
    uint8_t? targetComponent,
    uint8_t? confirmation,
  }) {
    return CommandLong(
      param1: param1 ?? this.param1,
      param2: param2 ?? this.param2,
      param3: param3 ?? this.param3,
      param4: param4 ?? this.param4,
      param5: param5 ?? this.param5,
      param6: param6 ?? this.param6,
      param7: param7 ?? this.param7,
      command: command ?? this.command,
      targetSystem: targetSystem ?? this.targetSystem,
      targetComponent: targetComponent ?? this.targetComponent,
      confirmation: confirmation ?? this.confirmation,
    );
  }

  factory CommandLong.parse(ByteData data_) {
    if (data_.lengthInBytes < CommandLong.mavlinkEncodedLength) {
      var len = CommandLong.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var param1 = data_.getFloat32(0, Endian.little);
    var param2 = data_.getFloat32(4, Endian.little);
    var param3 = data_.getFloat32(8, Endian.little);
    var param4 = data_.getFloat32(12, Endian.little);
    var param5 = data_.getFloat32(16, Endian.little);
    var param6 = data_.getFloat32(20, Endian.little);
    var param7 = data_.getFloat32(24, Endian.little);
    var command = data_.getUint16(28, Endian.little);
    var targetSystem = data_.getUint8(30);
    var targetComponent = data_.getUint8(31);
    var confirmation = data_.getUint8(32);

    return CommandLong(
        param1: param1,
        param2: param2,
        param3: param3,
        param4: param4,
        param5: param5,
        param6: param6,
        param7: param7,
        command: command,
        targetSystem: targetSystem,
        targetComponent: targetComponent,
        confirmation: confirmation);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setFloat32(0, param1, Endian.little);
    data_.setFloat32(4, param2, Endian.little);
    data_.setFloat32(8, param3, Endian.little);
    data_.setFloat32(12, param4, Endian.little);
    data_.setFloat32(16, param5, Endian.little);
    data_.setFloat32(20, param6, Endian.little);
    data_.setFloat32(24, param7, Endian.little);
    data_.setUint16(28, command, Endian.little);
    data_.setUint8(30, targetSystem);
    data_.setUint8(31, targetComponent);
    data_.setUint8(32, confirmation);
    return data_;
  }
}

/// Report status of a command. Includes feedback whether the command was executed. The command microservice is documented at https://mavlink.io/en/services/command.html
/// COMMAND_ACK
class CommandAck implements MavlinkMessage {
  static const int _mavlinkMessageId = 77;

  static const int _mavlinkCrcExtra = 143;

  static const int mavlinkEncodedLength = 10;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Command ID (of acknowledged command).
  /// MAVLink type: uint16_t
  /// enum: [MavCmd]
  /// command
  final MavCmd command;

  /// Result of command.
  /// MAVLink type: uint8_t
  /// enum: [MavResult]
  /// result
  final MavResult result;

  /// The progress percentage when result is MAV_RESULT_IN_PROGRESS. Values: [0-100], or UINT8_MAX if the progress is unknown.
  /// MAVLink type: uint8_t
  /// units: %
  /// Extensions field for MAVLink 2.
  /// progress
  final uint8_t progress;

  /// Additional result information. Can be set with a command-specific enum containing command-specific error reasons for why the command might be denied. If used, the associated enum must be documented in the corresponding MAV_CMD (this enum should have a 0 value to indicate "unused" or "unknown").
  /// MAVLink type: int32_t
  /// Extensions field for MAVLink 2.
  /// result_param2
  final int32_t resultParam2;

  /// System ID of the target recipient. This is the ID of the system that sent the command for which this COMMAND_ACK is an acknowledgement.
  /// MAVLink type: uint8_t
  /// Extensions field for MAVLink 2.
  /// target_system
  final uint8_t targetSystem;

  /// Component ID of the target recipient. This is the ID of the system that sent the command for which this COMMAND_ACK is an acknowledgement.
  /// MAVLink type: uint8_t
  /// Extensions field for MAVLink 2.
  /// target_component
  final uint8_t targetComponent;

  CommandAck({
    required this.command,
    required this.result,
    required this.progress,
    required this.resultParam2,
    required this.targetSystem,
    required this.targetComponent,
  });

  CommandAck copyWith({
    MavCmd? command,
    MavResult? result,
    uint8_t? progress,
    int32_t? resultParam2,
    uint8_t? targetSystem,
    uint8_t? targetComponent,
  }) {
    return CommandAck(
      command: command ?? this.command,
      result: result ?? this.result,
      progress: progress ?? this.progress,
      resultParam2: resultParam2 ?? this.resultParam2,
      targetSystem: targetSystem ?? this.targetSystem,
      targetComponent: targetComponent ?? this.targetComponent,
    );
  }

  factory CommandAck.parse(ByteData data_) {
    if (data_.lengthInBytes < CommandAck.mavlinkEncodedLength) {
      var len = CommandAck.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var command = data_.getUint16(0, Endian.little);
    var result = data_.getUint8(2);
    var progress = data_.getUint8(3);
    var resultParam2 = data_.getInt32(4, Endian.little);
    var targetSystem = data_.getUint8(8);
    var targetComponent = data_.getUint8(9);

    return CommandAck(
        command: command,
        result: result,
        progress: progress,
        resultParam2: resultParam2,
        targetSystem: targetSystem,
        targetComponent: targetComponent);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint16(0, command, Endian.little);
    data_.setUint8(2, result);
    data_.setUint8(3, progress);
    data_.setInt32(4, resultParam2, Endian.little);
    data_.setUint8(8, targetSystem);
    data_.setUint8(9, targetComponent);
    return data_;
  }
}

///
/// Time synchronization message.
/// The message is used for both timesync requests and responses.
/// The request is sent with `ts1=syncing component timestamp` and `tc1=0`, and may be broadcast or targeted to a specific system/component.
/// The response is sent with `ts1=syncing component timestamp` (mirror back unchanged), and `tc1=responding component timestamp`, with the `target_system` and `target_component` set to ids of the original request.
/// Systems can determine if they are receiving a request or response based on the value of `tc`.
/// If the response has `target_system==target_component==0` the remote system has not been updated to use the component IDs and cannot reliably timesync; the requester may report an error.
/// Timestamps are UNIX Epoch time or time since system boot in nanoseconds (the timestamp format can be inferred by checking for the magnitude of the number; generally it doesn't matter as only the offset is used).
/// The message sequence is repeated numerous times with results being filtered/averaged to estimate the offset.
/// See also: https://mavlink.io/en/services/timesync.html.
///
/// TIMESYNC
class Timesync implements MavlinkMessage {
  static const int _mavlinkMessageId = 111;

  static const int _mavlinkCrcExtra = 34;

  static const int mavlinkEncodedLength = 18;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Time sync timestamp 1. Syncing: 0. Responding: Timestamp of responding component.
  /// MAVLink type: int64_t
  /// units: ns
  /// tc1
  final int64_t tc1;

  /// Time sync timestamp 2. Timestamp of syncing component (mirrored in response).
  /// MAVLink type: int64_t
  /// units: ns
  /// ts1
  final int64_t ts1;

  /// Target system id. Request: 0 (broadcast) or id of specific system. Response must contain system id of the requesting component.
  /// MAVLink type: uint8_t
  /// Extensions field for MAVLink 2.
  /// target_system
  final uint8_t targetSystem;

  /// Target component id. Request: 0 (broadcast) or id of specific component. Response must contain component id of the requesting component.
  /// MAVLink type: uint8_t
  /// Extensions field for MAVLink 2.
  /// target_component
  final uint8_t targetComponent;

  Timesync({
    required this.tc1,
    required this.ts1,
    required this.targetSystem,
    required this.targetComponent,
  });

  Timesync copyWith({
    int64_t? tc1,
    int64_t? ts1,
    uint8_t? targetSystem,
    uint8_t? targetComponent,
  }) {
    return Timesync(
      tc1: tc1 ?? this.tc1,
      ts1: ts1 ?? this.ts1,
      targetSystem: targetSystem ?? this.targetSystem,
      targetComponent: targetComponent ?? this.targetComponent,
    );
  }

  factory Timesync.parse(ByteData data_) {
    if (data_.lengthInBytes < Timesync.mavlinkEncodedLength) {
      var len = Timesync.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var tc1 = data_.getInt64(0, Endian.little);
    var ts1 = data_.getInt64(8, Endian.little);
    var targetSystem = data_.getUint8(16);
    var targetComponent = data_.getUint8(17);

    return Timesync(
        tc1: tc1,
        ts1: ts1,
        targetSystem: targetSystem,
        targetComponent: targetComponent);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setInt64(0, tc1, Endian.little);
    data_.setInt64(8, ts1, Endian.little);
    data_.setUint8(16, targetSystem);
    data_.setUint8(17, targetComponent);
    return data_;
  }
}

/// UGV MASTER HEALTH
/// UGV_SYSTEM_INFO
class UgvSystemInfo implements MavlinkMessage {
  static const int _mavlinkMessageId = 50001;

  static const int _mavlinkCrcExtra = 182;

  static const int mavlinkEncodedLength = 31;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// subsystem present
  /// MAVLink type: uint32_t
  /// enum: [UgvCompBitmask]
  /// ugv_subsystem_present
  final UgvCompBitmask ugvSubsystemPresent;

  /// subsystem enabled
  /// MAVLink type: uint32_t
  /// enum: [UgvCompBitmask]
  /// ugv_subsystem_enabled
  final UgvCompBitmask ugvSubsystemEnabled;

  /// subsystem health
  /// MAVLink type: uint32_t
  /// enum: [UgvCompBitmask]
  /// ugv_subsystem_health
  final UgvCompBitmask ugvSubsystemHealth;

  /// Compute load (d%)
  /// MAVLink type: uint16_t
  /// compute_load
  final uint16_t computeLoad;

  /// System Voltage (mV)
  /// MAVLink type: uint16_t
  /// main_voltage
  final uint16_t mainVoltage;

  /// System Current (cA)
  /// MAVLink type: int16_t
  /// main_current
  final int16_t mainCurrent;

  /// PDU 12V Voltage (mV)
  /// MAVLink type: uint16_t
  /// pdu_12v_voltage
  final uint16_t pdu12vVoltage;

  /// Drop Rate (c%)
  /// MAVLink type: uint16_t
  /// drop_rate_comm
  final uint16_t dropRateComm;

  /// VCU Fault Errors Count
  /// MAVLink type: uint16_t
  /// vcu_fault_errors
  final uint16_t vcuFaultErrors;

  /// Front Motor Errors Count
  /// MAVLink type: uint16_t
  /// enum: [UgvMotorErrorBitmask]
  /// front_motor_errors
  final UgvMotorErrorBitmask frontMotorErrors;

  /// Rear Motor Errors Count
  /// MAVLink type: uint16_t
  /// enum: [UgvMotorErrorBitmask]
  /// rear_motor_errors
  final UgvMotorErrorBitmask rearMotorErrors;

  /// Sensor Bus Errors Count
  /// MAVLink type: uint16_t
  /// enum: [UgvSensorErrorBitmask]
  /// sensor_bus_errors
  final UgvSensorErrorBitmask sensorBusErrors;

  /// Remaining Battery (%)
  /// MAVLink type: int8_t
  /// battery_remaining
  final int8_t batteryRemaining;

  UgvSystemInfo({
    required this.ugvSubsystemPresent,
    required this.ugvSubsystemEnabled,
    required this.ugvSubsystemHealth,
    required this.computeLoad,
    required this.mainVoltage,
    required this.mainCurrent,
    required this.pdu12vVoltage,
    required this.dropRateComm,
    required this.vcuFaultErrors,
    required this.frontMotorErrors,
    required this.rearMotorErrors,
    required this.sensorBusErrors,
    required this.batteryRemaining,
  });

  UgvSystemInfo copyWith({
    UgvCompBitmask? ugvSubsystemPresent,
    UgvCompBitmask? ugvSubsystemEnabled,
    UgvCompBitmask? ugvSubsystemHealth,
    uint16_t? computeLoad,
    uint16_t? mainVoltage,
    int16_t? mainCurrent,
    uint16_t? pdu12vVoltage,
    uint16_t? dropRateComm,
    uint16_t? vcuFaultErrors,
    UgvMotorErrorBitmask? frontMotorErrors,
    UgvMotorErrorBitmask? rearMotorErrors,
    UgvSensorErrorBitmask? sensorBusErrors,
    int8_t? batteryRemaining,
  }) {
    return UgvSystemInfo(
      ugvSubsystemPresent: ugvSubsystemPresent ?? this.ugvSubsystemPresent,
      ugvSubsystemEnabled: ugvSubsystemEnabled ?? this.ugvSubsystemEnabled,
      ugvSubsystemHealth: ugvSubsystemHealth ?? this.ugvSubsystemHealth,
      computeLoad: computeLoad ?? this.computeLoad,
      mainVoltage: mainVoltage ?? this.mainVoltage,
      mainCurrent: mainCurrent ?? this.mainCurrent,
      pdu12vVoltage: pdu12vVoltage ?? this.pdu12vVoltage,
      dropRateComm: dropRateComm ?? this.dropRateComm,
      vcuFaultErrors: vcuFaultErrors ?? this.vcuFaultErrors,
      frontMotorErrors: frontMotorErrors ?? this.frontMotorErrors,
      rearMotorErrors: rearMotorErrors ?? this.rearMotorErrors,
      sensorBusErrors: sensorBusErrors ?? this.sensorBusErrors,
      batteryRemaining: batteryRemaining ?? this.batteryRemaining,
    );
  }

  factory UgvSystemInfo.parse(ByteData data_) {
    if (data_.lengthInBytes < UgvSystemInfo.mavlinkEncodedLength) {
      var len = UgvSystemInfo.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var ugvSubsystemPresent = data_.getUint32(0, Endian.little);
    var ugvSubsystemEnabled = data_.getUint32(4, Endian.little);
    var ugvSubsystemHealth = data_.getUint32(8, Endian.little);
    var computeLoad = data_.getUint16(12, Endian.little);
    var mainVoltage = data_.getUint16(14, Endian.little);
    var mainCurrent = data_.getInt16(16, Endian.little);
    var pdu12vVoltage = data_.getUint16(18, Endian.little);
    var dropRateComm = data_.getUint16(20, Endian.little);
    var vcuFaultErrors = data_.getUint16(22, Endian.little);
    var frontMotorErrors = data_.getUint16(24, Endian.little);
    var rearMotorErrors = data_.getUint16(26, Endian.little);
    var sensorBusErrors = data_.getUint16(28, Endian.little);
    var batteryRemaining = data_.getInt8(30);

    return UgvSystemInfo(
        ugvSubsystemPresent: ugvSubsystemPresent,
        ugvSubsystemEnabled: ugvSubsystemEnabled,
        ugvSubsystemHealth: ugvSubsystemHealth,
        computeLoad: computeLoad,
        mainVoltage: mainVoltage,
        mainCurrent: mainCurrent,
        pdu12vVoltage: pdu12vVoltage,
        dropRateComm: dropRateComm,
        vcuFaultErrors: vcuFaultErrors,
        frontMotorErrors: frontMotorErrors,
        rearMotorErrors: rearMotorErrors,
        sensorBusErrors: sensorBusErrors,
        batteryRemaining: batteryRemaining);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint32(0, ugvSubsystemPresent, Endian.little);
    data_.setUint32(4, ugvSubsystemEnabled, Endian.little);
    data_.setUint32(8, ugvSubsystemHealth, Endian.little);
    data_.setUint16(12, computeLoad, Endian.little);
    data_.setUint16(14, mainVoltage, Endian.little);
    data_.setInt16(16, mainCurrent, Endian.little);
    data_.setUint16(18, pdu12vVoltage, Endian.little);
    data_.setUint16(20, dropRateComm, Endian.little);
    data_.setUint16(22, vcuFaultErrors, Endian.little);
    data_.setUint16(24, frontMotorErrors, Endian.little);
    data_.setUint16(26, rearMotorErrors, Endian.little);
    data_.setUint16(28, sensorBusErrors, Endian.little);
    data_.setInt8(30, batteryRemaining);
    return data_;
  }
}

/// Describes the current software version along with checksum of the particular component of UGV system.
/// UGV_COMPONENT_VERSION
class UgvComponentVersion implements MavlinkMessage {
  static const int _mavlinkMessageId = 50002;

  static const int _mavlinkCrcExtra = 161;

  static const int mavlinkEncodedLength = 38;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Software version. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: uint32_t
  /// software_version
  final uint32_t softwareVersion;

  /// SHA 256 Checksum of the build
  /// MAVLink type: uint8_t[32]
  /// checksum
  final List<int8_t> checksum;

  /// Target system id. Request: 0 (broadcast) or id of specific system. Response must contain system id of the requesting component.
  /// MAVLink type: uint8_t
  /// target_system
  final uint8_t targetSystem;

  /// Target component id. Request: 0 (broadcast) or id of specific component. Response must contain component id of the requesting component.
  /// MAVLink type: uint8_t
  /// target_component
  final uint8_t targetComponent;

  UgvComponentVersion({
    required this.softwareVersion,
    required this.checksum,
    required this.targetSystem,
    required this.targetComponent,
  });

  UgvComponentVersion copyWith({
    uint32_t? softwareVersion,
    List<int8_t>? checksum,
    uint8_t? targetSystem,
    uint8_t? targetComponent,
  }) {
    return UgvComponentVersion(
      softwareVersion: softwareVersion ?? this.softwareVersion,
      checksum: checksum ?? this.checksum,
      targetSystem: targetSystem ?? this.targetSystem,
      targetComponent: targetComponent ?? this.targetComponent,
    );
  }

  factory UgvComponentVersion.parse(ByteData data_) {
    if (data_.lengthInBytes < UgvComponentVersion.mavlinkEncodedLength) {
      var len = UgvComponentVersion.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var softwareVersion = data_.getUint32(0, Endian.little);
    var checksum = MavlinkMessage.asUint8List(data_, 4, 32);
    var targetSystem = data_.getUint8(36);
    var targetComponent = data_.getUint8(37);

    return UgvComponentVersion(
        softwareVersion: softwareVersion,
        checksum: checksum,
        targetSystem: targetSystem,
        targetComponent: targetComponent);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint32(0, softwareVersion, Endian.little);
    MavlinkMessage.setUint8List(data_, 4, checksum);
    data_.setUint8(36, targetSystem);
    data_.setUint8(37, targetComponent);
    return data_;
  }
}

/// Describes the current software version along with checksum of whole UGV system
/// UGV_SUBSYSTEM_VERSION
class UgvSubsystemVersion implements MavlinkMessage {
  static const int _mavlinkMessageId = 50003;

  static const int _mavlinkCrcExtra = 78;

  static const int mavlinkEncodedLength = 181;

  @override
  int get mavlinkMessageId => _mavlinkMessageId;

  @override
  int get mavlinkCrcExtra => _mavlinkCrcExtra;

  /// Type of the subsystem software.
  /// MAVLink type: uint8_t
  /// type
  final uint8_t type;

  /// Software version of component 1. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[4]
  /// component1_sw
  final List<char> component1Sw;

  /// Software checksum of component 1. The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[32]
  /// component1_checksum
  final List<char> component1Checksum;

  /// Software version of component 2. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[4]
  /// component2_sw
  final List<char> component2Sw;

  /// Software checksum of component 2. The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[32]
  /// component2_checksum
  final List<char> component2Checksum;

  /// Software version of component 3. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[4]
  /// component3_sw
  final List<char> component3Sw;

  /// Software checksum of component 3. The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[32]
  /// component3_checksum
  final List<char> component3Checksum;

  /// Software version of component 4. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[4]
  /// component4_sw
  final List<char> component4Sw;

  /// Software checksum of component 4. The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[32]
  /// component4_checksum
  final List<char> component4Checksum;

  /// Software version of component 5. The recommended format is SEMVER: 'major.minor.patch'  (any format may be used). The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[4]
  /// component5_sw
  final List<char> component5Sw;

  /// Software checksum of component 5. The field must be zero terminated if it has a value. The field is optional and can be empty/all zeros.
  /// MAVLink type: char[32]
  /// component5_checksum
  final List<char> component5Checksum;

  UgvSubsystemVersion({
    required this.type,
    required this.component1Sw,
    required this.component1Checksum,
    required this.component2Sw,
    required this.component2Checksum,
    required this.component3Sw,
    required this.component3Checksum,
    required this.component4Sw,
    required this.component4Checksum,
    required this.component5Sw,
    required this.component5Checksum,
  });

  UgvSubsystemVersion copyWith({
    uint8_t? type,
    List<char>? component1Sw,
    List<char>? component1Checksum,
    List<char>? component2Sw,
    List<char>? component2Checksum,
    List<char>? component3Sw,
    List<char>? component3Checksum,
    List<char>? component4Sw,
    List<char>? component4Checksum,
    List<char>? component5Sw,
    List<char>? component5Checksum,
  }) {
    return UgvSubsystemVersion(
      type: type ?? this.type,
      component1Sw: component1Sw ?? this.component1Sw,
      component1Checksum: component1Checksum ?? this.component1Checksum,
      component2Sw: component2Sw ?? this.component2Sw,
      component2Checksum: component2Checksum ?? this.component2Checksum,
      component3Sw: component3Sw ?? this.component3Sw,
      component3Checksum: component3Checksum ?? this.component3Checksum,
      component4Sw: component4Sw ?? this.component4Sw,
      component4Checksum: component4Checksum ?? this.component4Checksum,
      component5Sw: component5Sw ?? this.component5Sw,
      component5Checksum: component5Checksum ?? this.component5Checksum,
    );
  }

  factory UgvSubsystemVersion.parse(ByteData data_) {
    if (data_.lengthInBytes < UgvSubsystemVersion.mavlinkEncodedLength) {
      var len = UgvSubsystemVersion.mavlinkEncodedLength - data_.lengthInBytes;
      var d = data_.buffer.asUint8List().sublist(0, data_.lengthInBytes) +
          List<int>.filled(len, 0);
      data_ = Uint8List.fromList(d).buffer.asByteData();
    }
    var type = data_.getUint8(0);
    var component1Sw = MavlinkMessage.asInt8List(data_, 1, 4);
    var component1Checksum = MavlinkMessage.asInt8List(data_, 5, 32);
    var component2Sw = MavlinkMessage.asInt8List(data_, 37, 4);
    var component2Checksum = MavlinkMessage.asInt8List(data_, 41, 32);
    var component3Sw = MavlinkMessage.asInt8List(data_, 73, 4);
    var component3Checksum = MavlinkMessage.asInt8List(data_, 77, 32);
    var component4Sw = MavlinkMessage.asInt8List(data_, 109, 4);
    var component4Checksum = MavlinkMessage.asInt8List(data_, 113, 32);
    var component5Sw = MavlinkMessage.asInt8List(data_, 145, 4);
    var component5Checksum = MavlinkMessage.asInt8List(data_, 149, 32);

    return UgvSubsystemVersion(
        type: type,
        component1Sw: component1Sw,
        component1Checksum: component1Checksum,
        component2Sw: component2Sw,
        component2Checksum: component2Checksum,
        component3Sw: component3Sw,
        component3Checksum: component3Checksum,
        component4Sw: component4Sw,
        component4Checksum: component4Checksum,
        component5Sw: component5Sw,
        component5Checksum: component5Checksum);
  }

  @override
  ByteData serialize() {
    var data_ = ByteData(mavlinkEncodedLength);
    data_.setUint8(0, type);
    MavlinkMessage.setInt8List(data_, 1, component1Sw);
    MavlinkMessage.setInt8List(data_, 5, component1Checksum);
    MavlinkMessage.setInt8List(data_, 37, component2Sw);
    MavlinkMessage.setInt8List(data_, 41, component2Checksum);
    MavlinkMessage.setInt8List(data_, 73, component3Sw);
    MavlinkMessage.setInt8List(data_, 77, component3Checksum);
    MavlinkMessage.setInt8List(data_, 109, component4Sw);
    MavlinkMessage.setInt8List(data_, 113, component4Checksum);
    MavlinkMessage.setInt8List(data_, 145, component5Sw);
    MavlinkMessage.setInt8List(data_, 149, component5Checksum);
    return data_;
  }
}

class MavlinkDialectUgvcustom implements MavlinkDialect {
  static const int mavlinkVersion = 2;

  @override
  int get version => mavlinkVersion;

  @override
  MavlinkMessage? parse(int messageID, ByteData data) {
    switch (messageID) {
      case 0:
        return Heartbeat.parse(data);
      case 2:
        return SystemTime.parse(data);
      case 69:
        return ManualControl.parse(data);
      case 76:
        return CommandLong.parse(data);
      case 77:
        return CommandAck.parse(data);
      case 111:
        return Timesync.parse(data);
      case 50001:
        return UgvSystemInfo.parse(data);
      case 50002:
        return UgvComponentVersion.parse(data);
      case 50003:
        return UgvSubsystemVersion.parse(data);
      default:
        return null;
    }
  }

  @override
  int crcExtra(int messageID) {
    switch (messageID) {
      case 0:
        return Heartbeat._mavlinkCrcExtra;
      case 2:
        return SystemTime._mavlinkCrcExtra;
      case 69:
        return ManualControl._mavlinkCrcExtra;
      case 76:
        return CommandLong._mavlinkCrcExtra;
      case 77:
        return CommandAck._mavlinkCrcExtra;
      case 111:
        return Timesync._mavlinkCrcExtra;
      case 50001:
        return UgvSystemInfo._mavlinkCrcExtra;
      case 50002:
        return UgvComponentVersion._mavlinkCrcExtra;
      case 50003:
        return UgvSubsystemVersion._mavlinkCrcExtra;
      default:
        return -1;
    }
  }
}
