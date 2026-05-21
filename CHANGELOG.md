## 0.1.0
- Initial version.
- MAVLink code generator.
- Generate dialects (standard + custom).
- Package renamed throughout project.

# 0.2.0
- Added Equatable support to all MAVLink messages.
- Enabled props for equatable
- Update ugvcustom dialect using new generator

# 0.2.1
- Change UGV_SYSTEM_INFO message definition according to the ICD.

# 0.2.2
- Add Motor and Motor Controller Errors to UGV_SYSTEM_INFO (50001) message.
- Add snake case to field names in RADIO_STATUS (109) message
- Fix descriptions and minor typos
- Update the ugvcustom dialect with new message changes.

# 0.2.3
- Change data type of Manual Control X and Y fields to float 

# 0.2.4
- Remove standard MAVLink Dialects (Ardupilot, Common, etc.)
- Delete examples & tests directories
- Updated submodule reference to point to new changes
- Update generator tool input directory to match submodules structure
- Generator tool now generates only custom dialects. Input directory for the generator is (mavlink/message_definitions/v2.0)

# 0.2.5
- Add missing motor controller values and regenerate dialect

#0.2.6
- Remove forked mavlink submodule
- Add new submodule containing only XML files for MAVLink messages
- Update generator tool input directory to match submodules structure