//
//  HostControllerCommand.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 3/23/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

/**
 The Controller & Baseband Commands provide access and control to various capabilities of the Bluetooth hardware. These parameters provide control of BR/EDR Controllers and of the capabilities of the Link Manager and Baseband in the BR/EDR Controller, the PAL in an AMP Controller, and the Link Layer in an LE Controller. The Host can use these commands to modify the behavior of the local Controller.
 */
public enum HostControllerBasebandCommand: UInt16, HCICommand {
    
    public static let opcodeGroupField = HCIOpcodeGroupField.hostControllerBaseband
    
    /// Set Event Mask
    ///
    /// Used to control which events are generated by the HCI for the Host.
    case setEventMask = 0x0001

    /**
     Reset Command
     
     The Reset command will reset the Controller and the Link Manager on the BR/ EDR Controller, the PAL on an AMP Controller, or the Link Layer on an LE Controller. If the Controller supports both BR/EDR and LE then the Reset command shall reset the Link Manager, Baseband and Link Layer. The Reset command shall not affect the used HCI transport layer since the HCI transport layers may have reset mechanisms of their own. After the reset is completed, the current operational state will be lost, the Controller will enter standby mode and the Controller will automatically revert to the default values for the parameters for which default values are defined in the specification.
     
     - Note: The Reset command will not necessarily perform a hardware reset. This is implementation defined. On an AMP Controller, the Reset command shall reset the service provided at the logical HCI to its initial state, but beyond this the exact effect on the Controller device is implementation defined and should not interrupt the service provided to other protocol stacks.
     
     The Host shall not send additional HCI commands before the Command Complete event related to the Reset command has been received.
     */
    case reset = 0x0003
    
    /**
     Set Event Filter Command
     
     Used by the Host to specify different event filters.
     
     The Host may issue this command multiple times to request various conditions for the same type of event filter and for different types of event filters. The event filters are used by the Host to specify items of interest, which allow the BR/EDR Controller to send only events which interest the Host. Only some of the events have event filters. By default (before this command has been issued after power-on or Reset) no filters are set, and the Auto_Accept_Flag is off (incoming connections are not automatically accepted). An event filter is added each time this command is sent from the Host and the Filter_Condition_Type is not equal to 0x00. (The old event filters will not be overwritten). To clear all event filters, the Filter_Type = 0x00 is used. The Auto_Accept_Flag will then be set to off. To clear event filters for only a certain Filter_Type, the Filter_Condition_Type = 0x00 is used.
     The Inquiry Result filter allows the BR/EDR Controller to filter out Inquiry Result, Inquiry Result with RSSI, or Extended Inquiry Result events. The Inquiry Result filter allows the Host to specify that the BR/EDR Controller only sends Inquiry Results to the Host if the report meets one of the specified conditions set by the Host. For the Inquiry Result filter, the Host can specify one or more of the following Filter Condition Types:
     1. Return responses from all devices during the Inquiry process
     2. A device with a specific Class of Device responded to the Inquiry process 3. A device with a specific BD_ADDR responded to the Inquiry process
     The Inquiry Result filter is used in conjunction with the Inquiry and Periodic Inquiry command.
     The Connection Setup filter allows the Host to specify that the Controller only sends a Connection Complete or Connection Request event to the Host if the event meets one of the specified conditions set by the Host. For the Connection Setup filter, the Host can specify one or more of the following Filter Condition Types:
     1. Allow Connections from all devices
     2. Allow Connections from a device with a specific Class of Device 3. Allow Connections from a device with a specific BD_ADDR
     
     For each of these conditions, an Auto_Accept_Flag parameter allows the Host to specify what action should be done when the condition is met. The Auto_ Accept_Flag allows the Host to specify if the incoming connection should be auto accepted (in which case the BR/EDR Controller will send the Connection Complete event to the Host when the connection is completed) or if the Host should make the decision (in which case the BR/EDR Controller will send the Connection Request event to the Host, to elicit a decision on the connection).
     The Connection Setup filter is used in conjunction with the Read/Write_ Scan_Enable commands. If the local device is in the process of a page scan, and is paged by another device which meets one on the conditions set by the Host, and the Auto_Accept_Flag is off for this device, then a Connection Request event will be sent to the Host by the BR/EDR Controller. A Connection Complete event will be sent later on after the Host has responded to the incoming connection attempt. In this same example, if the Auto_Accept_Flag is on, then a Connection Complete event will be sent to the Host by the Controller. (No Connection Request event will be sent in that case.)
     The BR/EDR Controller will store these filters in volatile memory until the Host clears the event filters using the Set_Event_Filter command or until the Reset command is issued. The number of event filters the BR/EDR Controller can store is implementation dependent. If the Host tries to set more filters than the BR/EDR Controller can store, the BR/EDR Controller will return the Memory Full error code and the filter will not be installed.
     - Note: The Clear All Filters has no Filter Condition Types or Conditions.
     - Note: In the condition that a connection is auto accepted, a Link Key Request event and possibly also a PIN Code Request event and a Link Key Notification event could be sent to the Host by the Controller before the Connection Complete event is sent.
     If there is a contradiction between event filters, the latest set event filter will override older ones. An example is an incoming connection attempt where more than one Connection Setup filter matches the incoming connection attempt, but the Auto-Accept_Flag has different values in the different filters.
     */
    case setEventFilter = 0x0005
    
    /// Flush Command
    ///
    /// The Flush command is used to discard all data that is currently pending for transmission in the Controller for the specified Connection_Handle
    case flush = 0x0008
    
    /// Read PIN Type Command
    ///
    /// The Read_PIN_Type command is used to read the PIN_Type configuration parameter.
    case readPINType = 0x0009
    
    /// Write PIN Type Command
    ///
    /// The Write_PIN_Type command is used to write the PIN Type configuration parameter.
    case writePINType = 0x000A
    
    /// Create New Unit Key Command
    ///
    /// The Create_New_Unit_Key command is used to create a new unit key.
    case createNewUnitKey = 0x000B
    
    /// Read Stored Link Key Command
    ///
    /// The Read_Stored_Link_Key command provides the ability to read whether one or more link keys are stored in the BR/EDR Controller.
    case readStoredLinkKey = 0x000D
    
    /// Write Stored Link Key Command
    ///
    /// The Write_Stored_Link_Key command provides the ability to write one or more link keys to be stored in the BR/EDR Controller.
    case writeStoredLinkKey = 0x0011
    
    /// Delete Stored Link Key Command
    ///
    /// The Delete_Stored_Link_Key command provides the ability to remove one or more of the link keys stored in the BR/EDR Controller.
    case deleteStoredLinkKey = 0x0012
    
    /// Write Local Name Command
    ///
    /// The Write Local Name command provides the ability to modify the user-friendly name for the BR/EDR Controller.
    case writeLocalName = 0x0013
    
    /// Read Local Name Command
    ///
    /// The Read Local Name command provides the ability to read the stored user- friendly name for the BR/EDR Controller.
    case readLocalName = 0x0014
    
    /// Read Connection Accept Timeout Command
    ///
    /// This command reads the value for the Connection Accept Timeout configuration parameter.
    case readConnectionAcceptTimeout = 0x0015
    
    /// Write Connection Accept Timeout Command
    ///
    /// This command writes the value for the Connection Accept Timeout configuration parameter.
    case writeConnectionAcceptTimeout = 0x0016
    
    /// Read Page Timeout Command
    ///
    /// This command reads the value for the Page_Timeout configuration parameter.
    case readPageTimeout = 0x0017
    
    /// Write Page Timeout Command
    ///
    /// This command writes the value for the Page_Timeout configuration parameter.
    case writePageTimeout = 0x0018
    
    /// Read Scan Enable Command
    ///
    /// This command reads the value for the Scan_Enable parameter configuration parameter.
    case readScanEnable = 0x0019
    
    /// Write Scan Enable Command
    ///
    /// This command writes the value for the Scan_Enable configuration parameter.
    case writeScanEnable = 0x001A
    
    /// Read Page Scan Activity Command
    ///
    /// This command reads the value for Page_Scan_Interval and Page_Scan_Window configuration parameters.
    case readPageScanActivity = 0x001B
    
    /// Write Page Scan Activity Command
    ///
    /// This command writes the values for the Page_Scan_Interval and Page_Scan_Window configuration parameters.
    case writePageScanActivity = 0x001C
    
    /// Read Inquiry Scan Activity Command
    ///
    /// This command reads the value for Inquiry_Scan_Interval and Inquiry_Scan_Window configuration parameter.
    case readInquiryScanActivity = 0x001D
    
    /// Write Inquiry Scan Activity Command
    ///
    /// This command writes the values for the Inquiry_Scan_Interval and Inquiry_Scan_Window configuration parameters.
    case writeInquiryScanActivity = 0x001E
    
    /// Read Authentication Enable Command
    ///
    /// This command reads the value for the Authentication_Enable configuration parameter.
    case readAuthenticationEnable = 0x001F
    
    /// Write Authentication Enable Command
    ///
    /// This command writes the value for the Authentication_Enable configuration parameter.
    case writeAuthenticationEnable = 0x0020
    
    /// Read Class of Device Command
    ///
    /// This command reads the value for the Class_of_Device parameter.
    case readClassOfDevice = 0x0023
    
    /// Write Class of Device Command
    ///
    /// This command writes the value for the Class_of_Device parameter.
    case writeClassOfDevice = 0x0024
    
    /// Read Voice Setting Command
    ///
    /// This command reads the values for the Voice_Setting configuration parameter.
    case readVoiceSetting = 0x0025
    
    /// Write Voice Setting Command
    ///
    /// This command writes the values for the Voice_Setting configuration parameter.
    case writeVoiceSetting = 0x0026
    
    /// Read Automatic Flush Timeout Command
    ///
    /// This command reads the value for the Flush_Timeout parameter for the specified Connection_Handle.
    case readAutomaticFlushTimeout = 0x0027
    
    /// Write Automatic Flush Timeout Command
    ///
    /// This command writes the value for the Flush_Timeout parameter for the speci- fied Connection_Handle
    case writeAutomaticFlushTimeout = 0x0028
    
    /// Read Num Broadcast Retransmissions Command
    ///
    /// This command reads the device’s parameter value for the Number of Broadcast Retransmissions.
    case readNumBroadcastRetransmissions = 0x0029
    
    /// Write Num Broadcast Retransmissions Command
    ///
    /// This command writes the device’s parameter value for the Number of Broadcast Retransmissions.
    case writeNumBroadcastRetransmissions = 0x002A
    
    /// Read Hold Mode Activity Command
    ///
    /// This command reads the value for the Hold_Mode_Activity parameter.
    case readHoldModeActivity = 0x002B
    
    /// Write Hold Mode Activity Command
    ///
    /// This command writes the value for the Hold_Mode_Activity parameter.
    case writeHoldModeActivity = 0x002C
    
    /// Read Transmit Power Level Command
    ///
    /// This command reads the values for the Transmit_Power_Level parameter for the specified Connection_Handle.
    case readTransmitPowerLevel = 0x002D
    
    /// Read Synchronous Flow Control Enable Command
    ///
    /// The Read_Synchronous_Flow_Control_Enable command provides the ability to read the Synchronous_Flow_Control_Enable parameter.
    case readSynchronousFlowControlEnable = 0x002E
    
    /// Write Synchronous Flow Control Enable Command
    ///
    /// The Write_Synchronous_Flow_Control_Enable command provides the ability to write the Synchronous_Flow_Control_Enable parameter.
    case writeSynchronousFlowControlEnable = 0x002F
    
    /// Set Controller To Host Flow Control Command
    ///
    /// This command is used by the Host to turn flow control on or off for data and/or voice sent in the direction from the Controller to the Host.
    case setControllerToHostFlowControl = 0x0031
    
    /// Host Buffer Size Command
    ///
    /// The Host_Buffer_Size command is used by the Host to notify the Controller about the maximum size of the data portion of HCI ACL and synchronous Data Packets sent from the Controller to the Host.
    case hostBufferSize = 0x0033
    
    /// Host Number Of Completed Packets Command
    ///
    /// The Host_Number_Of_Completed_Packets command is used by the Host to indicate to the Controller the number of HCI Data Packets that have been com- pleted for each Connection Handle since the previous Host_Number_Of_ Completed_Packets command was sent to the Controller.
    case hostNumberOfCompletedPackets = 0x0035
    
    /// Read Link Supervision Timeout Command
    ///
    /// This command reads the value for the Link_Supervision_Timeout parameter for the Controller.
    case readLinkSupervisionTimeout = 0x0036
    
    /// Write Link Supervision Timeout Command
    ///
    /// This command writes the value for the Link_Supervision_Timeout parameter for a BR/EDR or AMP Controller.
    case writeLinkSupervisionTimeout = 0x0037
    
    /// Read Number Of Supported IAC Command
    ///
    /// This command reads the value for the number of Inquiry Access Codes (IAC) that the local BR/EDR Controller can simultaneous listen for during an Inquiry Scan.
    case readNumberOfSupportedIAC = 0x0038
    
    /// Read Current IAC LAP Command
    ///
    /// This command reads the LAP(s) used to create the Inquiry Access Codes (IAC) that the local BR/EDR Controller is simultaneously scanning for during Inquiry Scans.
    case readCurrentIACLAP = 0x0039
    
    /// Write Current IAC LAP Command
    ///
    /// This command writes the LAP(s) used to create the Inquiry Access Codes (IAC) that the local BR/EDR Controller is simultaneously scanning for during Inquiry Scans.
    case writeCurrentIACLAP = 0x003A
    
    /// Set AFH Host Channel Classification Command
    ///
    /// The Set_AFH_Host_Channel_Classification command allows the Host to specify a channel classification based on its “local information”.
    case setAFHHostChannelClassification = 0x003F
    
    /// Read Inquiry Scan Type Command
    ///
    /// This command reads the Inquiry_Scan_Type configuration parameter from the local BR/EDR Controller.
    case readInquiryScanType = 0x0042
    
    /// Write Inquiry Scan Type Command
    ///
    /// This command writes the Inquiry Scan Type configuration parameter of the local BR/EDR Controller.
    case writeInquiryScanType = 0x0043
    
    /// Read Inquiry Mode Command
    ///
    /// This command reads the Inquiry_Mode configuration parameter of the local BR/EDR Controller.
    case readInquiryMode = 0x0044
    
    /// Write Inquiry Mode Command
    ///
    /// This command writes the Inquiry_Mode configuration parameter of the local BR/EDR Controller.
    case writeInquiryMode = 0x0045
    
    /// Read Page Scan Type Command
    ///
    /// This command reads the Page Scan Type configuration parameter of the local BR/EDR Controller.
    case readPageScanType = 0x0046
    
    /// Write Page Scan Type Command
    ///
    /// This command writes the Page Scan Type configuration parameter of the local BR/EDR Controller.
    case writePageScanType = 0x0047
    
    /// Read AFH Channel Assessment Mode Command
    ///
    /// The Read_AFH_Channel_Assessment_Mode command reads the value for the AFH_Channel_Assessment_Mode parameter.
    case readAFHChannelAssessmentMode = 0x0048
    
    /// Write AFH Channel Assessment Mode Command
    ///
    /// The Write_AFH_Channel_Assessment_Mode command writes the value for the AFH_Channel_Assessment_Mode parameter.
    case writeAFHChannelAssessmentMode = 0x0049
    
    /// Read Extended Inquiry Response Command
    ///
    /// The Read_Extended_Inquiry_Response command reads the extended inquiry response to be sent during the extended inquiry response procedure.
    case readExtendedInquiryResponse = 0x0051
    
    /// Write Extended Inquiry Response Command
    ///
    /// The Write_Extended_Inquiry_Response command writes the extended inquiry response to be sent during the extended inquiry response procedure.
    case writeExtendedInquiryResponse = 0x0052
    
    /// Refresh Encryption Key Command
    ///
    /// This command is used by the Host to cause the BR/EDR Controller to refresh the encryption key by pausing and resuming encryption.
    case refreshEncryptionKey = 0x0053
    
    /// Read Simple Pairing Mode Command
    ///
    /// This command reads the Simple_Pairing_Mode parameter in the BR/EDR Controller.
    case readSimplePairingMode = 0x0055
    
    /// Write Simple Pairing Mode Command
    ///
    /// This command enables Simple Pairing mode in the BR/EDR Controller.
    case writeSimplePairingMode = 0x0056
    
    /// Read Local OOB Data Command
    ///
    /// This command obtains a Simple Pairing Hash C and Simple Pairing Randomizer R which are intended to be transferred to a remote device using an OOB mechanism.
    case readLocalOOBData = 0x0057
    
    /// Read Inquiry Response Transmit Power Level Command
    ///
    /// This command reads the inquiry Transmit Power level used to transmit the FHS and EIR data packets.
    case readInquiryResponseTransmitPowerLevel = 0x0058
    
    /// Write Inquiry Transmit Power Level Command
    ///
    /// This command writes the inquiry transmit power level used to transmit the inquiry (ID) data packets.
    case writeInquiryResponseTransmitPowerLevel = 0x0059
    
    /// Send Keypress Notification Command
    ///
    /// This command is used during the Passkey Entry protocol by a device with Key- boardOnly IO capabilities
    case sendKeypressNotification = 0x0060
    
    /// Read Default Erroneous Data Reporting
    ///
    /// This command reads the Erroneous_Data_Reporting parameter
    case readDefaultErroneousData = 0x005A
    
    /// Write Default Erroneous Data Reporting
    ///
    /// This command writes the Erroneous_Data_Reporting parameter.
    case writeDefaultErroneousData = 0x005B
    
    /// Enhanced Flush Command
    ///
    /// The Enhanced_Flush command is used to discard all L2CAP packets identified by Packet_Type that are currently pending for transmission in the Controller for the specified Handle
    case enhancedFlush = 0x005F
    
    /// Read Logical Link Accept Timeout Command
    ///
    /// This command reads the value for the Logical_Link_Accept_Timeout configuration parameter.
    case readLogicalLinkAcceptTimeout = 0x0061
    
    /// Write Logical Link Accept Timeout Command
    ///
    /// This command writes the value for the Logical_Link_Accept_Timeout configuration parameter. See Logical Link Accept Timeout.
    case writeLogicalLinkAcceptTimeout = 0x0062
    
    /// Set Event Mask Page 2 Command
    ///
    /// The Set_Event_Mask_Page_2 command is used to control which events are generated by the HCI for the Host
    case setEventMaskPage2 = 0x0063
    
    /// Read Location Data Command
    ///
    /// The Read_Location_Data command provides the ability to read any stored knowledge of environment or regulations or currently in use in the AMP Con- troller.
    case readLocationData = 0x0064
    
    /// Write Location Data Command
    ///
    /// The Write_Location_Data command writes information about the environment or regulations currently in force, which may affect the operation of the Control- ler.
    case writeLocationData = 0x0065
    
    /// Read Flow Control Mode Command
    ///
    /// This command reads the value for the Flow_Control_Mode configuration parameter.
    case readFlowControlMode = 0x0066
    
    /// Write Flow Control Mode Command
    ///
    /// This command writes the value for the Flow_Control_Mode configuration parameter.
    case writeFlowControlMode = 0x0067
    
    /// Read Enhanced Transmit Power Level Command
    ///
    /// This command reads the values for the Enhanced_Transmit_Power_Level parameters for the specified Connection Handle
    case radEnhancedTransmitPowerLevel = 0x0068
    
    /// Read Best Effort Flush Timeout Command
    ///
    /// This command reads the value of the Best Effort Flush Timeout from the AMP Controller.
    case readBestEffortFlushTimeout = 0x0069
    
    /// Write Best Effort Flush Timeout Command
    ///
    /// This command writes the value of the Best_Effort_Flush_Timeout into the AMP Controller.
    case writeBestEffortFlushTimeout = 0x006A
    
    /// Short Range Mode Command
    ///
    /// This command will configure the value of Short_Range_Mode to the AMP Controller and is AMP type specific
    case shortRangeMode = 0x006B
    
    /// Read LE Host Supported Command
    ///
    /// The Read_LE_Host_Support command is used to read the LE Supported (Host) and Simultaneous LE and BR/EDR to Same Device Capable (Host) Link Manager Protocol feature bits.
    case readLEHostSupported = 0x006C
    
    /// Write LE Host Supported Command
    ///
    /// The Write_LE_Host_Support command is used to set the LE Supported (Host) and Simultaneous LE and BR/EDR to Same Device Capable (Host) Link Man- ager Protocol feature bits.
    case writeLEHostSupported = 0x006D
}

// MARK: - Name

public extension HostControllerBasebandCommand {
    
    public var name: String {
        
        return type(of: self).names[Int(rawValue)]
    }
    
    private static let names = [
        "Unknown",
        "Set Event Mask",
        "Unknown",
        "Reset",
        "Unknown",
        "Set Event Filter",
        "Unknown",
        "Unknown",
        "Flush",
        "Read PIN Type ",
        "Write PIN Type",
        "Create New Unit Key",
        "Unknown",
        "Read Stored Link Key",
        "Unknown",
        "Unknown",
        "Unknown",
        "Write Stored Link Key",
        "Delete Stored Link Key",
        "Write Local Name",
        "Read Local Name",
        "Read Connection Accept Timeout",
        "Write Connection Accept Timeout",
        "Read Page Timeout",
        "Write Page Timeout",
        "Read Scan Enable",
        "Write Scan Enable",
        "Read Page Scan Activity",
        "Write Page Scan Activity",
        "Read Inquiry Scan Activity",
        "Write Inquiry Scan Activity",
        "Read Authentication Enable",
        "Write Authentication Enable",
        "Read Encryption Mode",
        "Write Encryption Mode",
        "Read Class of Device",
        "Write Class of Device",
        "Read Voice Setting",
        "Write Voice Setting",
        "Read Automatic Flush Timeout",
        "Write Automatic Flush Timeout",
        "Read Num Broadcast Retransmissions",
        "Write Num Broadcast Retransmissions",
        "Read Hold Mode Activity ",
        "Write Hold Mode Activity",
        "Read Transmit Power Level",
        "Read Synchronous Flow Control Enable",
        "Write Synchronous Flow Control Enable",
        "Unknown",
        "Set Host Controller To Host Flow Control",
        "Unknown",
        "Host Buffer Size",
        "Unknown",
        "Host Number of Completed Packets",
        "Read Link Supervision Timeout",
        "Write Link Supervision Timeout",
        "Read Number of Supported IAC",
        "Read Current IAC LAP",
        "Write Current IAC LAP",
        "Read Page Scan Period Mode",
        "Write Page Scan Period Mode",
        "Read Page Scan Mode",
        "Write Page Scan Mode",
        "Set AFH Host Channel Classification",
        "Unknown",
        "Unknown",
        "Read Inquiry Scan Type",
        "Write Inquiry Scan Type",
        "Read Inquiry Mode",
        "Write Inquiry Mode",
        "Read Page Scan Type",
        "Write Page Scan Type",
        "Read AFH Channel Assessment Mode",
        "Write AFH Channel Assessment Mode",
        "Unknown",
        "Unknown",
        "Unknown",
        "Unknown",
        "Unknown",
        "Unknown",
        "Unknown",
        "Read Extended Inquiry Response",
        "Write Extended Inquiry Response",
        "Refresh Encryption Key",
        "Unknown",
        "Read Simple Pairing Mode",
        "Write Simple Pairing Mode",
        "Read Local OOB Data",
        "Read Inquiry Response Transmit Power Level",
        "Write Inquiry Transmit Power Level",
        "Read Default Erroneous Data Reporting",
        "Write Default Erroneous Data Reporting",
        "Unknown",
        "Unknown",
        "Unknown",
        "Enhanced Flush",
        "Unknown",
        "Read Logical Link Accept Timeout",
        "Write Logical Link Accept Timeout",
        "Set Event Mask Page 2",
        "Read Location Data",
        "Write Location Data",
        "Read Flow Control Mode",
        "Write Flow Control Mode",
        "Read Enhanced Transmit Power Level",
        "Read Best Effort Flush Timeout",
        "Write Best Effort Flush Timeout",
        "Short Range Mode",
        "Read LE Host Supported",
        "Write LE Host Supported"
    ]
}