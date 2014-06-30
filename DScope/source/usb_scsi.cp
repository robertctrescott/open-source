#line 1 "Z:/Robs Folder/DScope/source/usb_scsi.c"
#line 1 "z:/robs folder/dscope/include/usb_scsi.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_lib.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_type.h"
#line 1 "z:/robs folder/dscope/include/usb_conf.h"
#line 31 "z:/robs folder/dscope/usblib/inc/usb_type.h"
typedef signed long s32;
typedef signed short s16;
typedef signed char s8;

typedef volatile signed long vs32;
typedef volatile signed short vs16;
typedef volatile signed char vs8;

typedef unsigned long u32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef unsigned long const uc32;
typedef unsigned short const uc16;
typedef unsigned char const uc8;

typedef volatile unsigned long vu32;
typedef volatile unsigned short vu16;
typedef volatile unsigned char vu8;

typedef volatile unsigned long const vuc32;
typedef volatile unsigned short const vuc16;
typedef volatile unsigned char const vuc8;


typedef enum
{
 FALSE = 0, TRUE = !FALSE
}
boolean;

typedef enum { RESET = 0, SET = !RESET } FlagStatus, ITStatus;

typedef enum { DISABLE = 0, ENABLE = !DISABLE} FunctionalState;

typedef enum { ERROR = 0, SUCCESS = !ERROR} ErrorStatus;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
typedef enum _EP_DBUF_DIR
{

 EP_DBUF_ERR,
 EP_DBUF_OUT,
 EP_DBUF_IN
}EP_DBUF_DIR;


enum EP_BUF_NUM
{
 EP_NOBUF,
 EP_BUF0,
 EP_BUF1
};
#line 554 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
extern volatile u16 wIstr;


void SetCNTR(u16 );
void SetISTR(u16 );
void SetDADDR(u16 );
void SetBTABLE(u16 );
void SetBTABLE(u16 );
u16 GetCNTR(void);
u16 GetISTR(void);
u16 GetFNR(void);
u16 GetDADDR(void);
u16 GetBTABLE(void);
void SetENDPOINT(u8 , u16 );
u16 GetENDPOINT(u8 );
void SetEPType(u8 , u16 );
u16 GetEPType(u8 );
void SetEPTxStatus(u8 , u16 );
void SetEPRxStatus(u8 , u16 );
void SetDouBleBuffEPStall(u8 , u8 bDir);
u16 GetEPTxStatus(u8 );
u16 GetEPRxStatus(u8 );
void SetEPTxValid(u8 );
void SetEPRxValid(u8 );
u16 GetTxStallStatus(u8 );
u16 GetRxStallStatus(u8 );
void SetEP_KIND(u8 );
void ClearEP_KIND(u8 );
void Set_Status_Out(u8 );
void Clear_Status_Out(u8 );
void SetEPDoubleBuff(u8 );
void ClearEPDoubleBuff(u8 );
void ClearEP_CTR_RX(u8 );
void ClearEP_CTR_TX(u8 );
void ToggleDTOG_RX(u8 );
void ToggleDTOG_TX(u8 );
void ClearDTOG_RX(u8 );
void ClearDTOG_TX(u8 );
void SetEPAddress(u8 , u8 );
u8 GetEPAddress(u8 );
void SetEPTxAddr(u8 , u16 );
void SetEPRxAddr(u8 , u16 );
u16 GetEPTxAddr(u8 );
u16 GetEPRxAddr(u8 );
void SetEPCountRxReg(u32 * , u16 );
void SetEPTxCount(u8 , u16 );
void SetEPRxCount(u8 , u16 );
u16 GetEPTxCount(u8 );
u16 GetEPRxCount(u8 );
void SetEPDblBuf0Addr(u8 , u16 );
void SetEPDblBuf1Addr(u8 , u16 );
void SetEPDblBuffAddr(u8 , u16 , u16 );
u16 GetEPDblBuf0Addr(u8 );
u16 GetEPDblBuf1Addr(u8 );
void SetEPDblBuffCount(u8 , u8 , u16 );
void SetEPDblBuf0Count(u8 , u8 , u16 );
void SetEPDblBuf1Count(u8 , u8 , u16 );
u16 GetEPDblBuf0Count(u8 );
u16 GetEPDblBuf1Count(u8 );
EP_DBUF_DIR GetEPDblBufDir(u8 );
void FreeUserBuffer(u8 bEpNum , u8 bDir);
u16 ToWord(u8, u8);
u16 ByteSwap(u16);
#line 1 "z:/robs folder/dscope/usblib/inc/usb_def.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_def.h"
typedef enum _RECIPIENT_TYPE
{
 DEVICE_RECIPIENT,
 INTERFACE_RECIPIENT,
 ENDPOINT_RECIPIENT,
 OTHER_RECIPIENT
} RECIPIENT_TYPE;


typedef enum _STANDARD_REQUESTS
{
 GET_STATUS = 0,
 CLEAR_FEATURE,
 RESERVED1,
 SET_FEATURE,
 RESERVED2,
 SET_ADDRESS,
 GET_DESCRIPTOR,
 SET_DESCRIPTOR,
 GET_CONFIGURATION,
 SET_CONFIGURATION,
 GET_INTERFACE,
 SET_INTERFACE,
 TOTAL_sREQUEST,
 SYNCH_FRAME = 12
} STANDARD_REQUESTS;


typedef enum _DESCRIPTOR_TYPE
{
 DEVICE_DESCRIPTOR = 1,
 CONFIG_DESCRIPTOR,
 STRING_DESCRIPTOR,
 INTERFACE_DESCRIPTOR,
 ENDPOINT_DESCRIPTOR
} DESCRIPTOR_TYPE;


typedef enum _FEATURE_SELECTOR
{
 ENDPOINT_STALL,
 DEVICE_REMOTE_WAKEUP
} FEATURE_SELECTOR;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_core.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_core.h"
typedef enum _CONTROL_STATE
{
 WAIT_SETUP,
 SETTING_UP,
 IN_DATA,
 OUT_DATA,
 LAST_IN_DATA,
 LAST_OUT_DATA,
 WAIT_STATUS_IN,
 WAIT_STATUS_OUT,
 STALLED,
 PAUSE
} CONTROL_STATE;

typedef struct OneDescriptor
{
 u8 *Descriptor;
 u16 Descriptor_Size;
}
ONE_DESCRIPTOR, *PONE_DESCRIPTOR;
#line 45 "z:/robs folder/dscope/usblib/inc/usb_core.h"
typedef enum _RESULT
{
 USB_SUCCESS = 0,
 USB_ERROR,
 USB_UNSUPPORT,
#line 51 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 USB_NOT_READY
} RESULT;



typedef struct _ENDPOINT_INFO
{
#line 80 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 u16 Usb_wLength;
 u16 Usb_wOffset;
 u16 PacketSize;
 u8 *(*CopyData)(u16 Length);
}
ENDPOINT_INFO;



typedef struct _DEVICE
{
 u8 Total_Endpoint;
 u8 Total_Configuration;
}
DEVICE;

typedef union
{
 u16 w;
 struct BW
 {
 u8 bb1;
 u8 bb0;
 }
 bw;
} u16_u8;

typedef struct _DEVICE_INFO
{
 u8 USBbmRequestType;
 u8 USBbRequest;
 u16_u8 USBwValues;
 u16_u8 USBwIndexs;
 u16_u8 USBwLengths;

 u8 ControlState;
 u8 Current_Feature;
 u8 Current_Configuration;
 u8 Current_Interface;
#line 120 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 u8 Current_AlternateSetting;

 ENDPOINT_INFO Ctrl_Info;
}
DEVICE_INFO;

typedef struct _DEVICE_PROP
{
 void (*Init)(void);
 void (*Reset)(void);


 void (*Process_Status_IN)(void);
 void (*Process_Status_OUT)(void);
#line 151 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_Data_Setup)(u8 RequestNo);
#line 162 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_NoData_Setup)(u8 RequestNo);
#line 172 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_Get_Interface_Setting)(u8 Interface, u8 AlternateSetting);

 u8* (*GetDeviceDescriptor)(u16 Length);
 u8* (*GetConfigDescriptor)(u16 Length);
 u8* (*GetStringDescriptor)(u16 Length);

 u8* RxEP_buffer;
 u8 MaxPacketSize;

}
DEVICE_PROP;

typedef struct _USER_STANDARD_REQUESTS
{
 void (*User_GetConfiguration)(void);
 void (*User_SetConfiguration)(void);
 void (*User_GetInterface)(void);
 void (*User_SetInterface)(void);
 void (*User_GetStatus)(void);
 void (*User_ClearFeature)(void);
 void (*User_SetEndPointFeature)(void);
 void (*User_SetDeviceFeature)(void);
 void (*User_SetDeviceAddress)(void);
}
USER_STANDARD_REQUESTS;
#line 216 "z:/robs folder/dscope/usblib/inc/usb_core.h"
u8 Setup0_Process(void);
u8 Post0_Process(void);
u8 Out0_Process(void);
u8 In0_Process(void);

RESULT Standard_SetEndPointFeature(void);
RESULT Standard_SetDeviceFeature(void);

u8 *Standard_GetConfiguration(u16 Length);
RESULT Standard_SetConfiguration(void);
u8 *Standard_GetInterface(u16 Length);
RESULT Standard_SetInterface(void);
u8 *Standard_GetDescriptorData(u16 Length, PONE_DESCRIPTOR pDesc);

u8 *Standard_GetStatus(u16 Length);
RESULT Standard_ClearFeature(void);
void SetDeviceAddress(u8);
void NOP_Process(void);

extern DEVICE_PROP Device_Property;
extern USER_STANDARD_REQUESTS User_Standard_Requests;
extern DEVICE Device_Table;
extern DEVICE_INFO Device_Info;


extern u16 SaveRState;
extern u16 SaveTState;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_init.h"
#line 25 "z:/robs folder/dscope/usblib/inc/usb_init.h"
void USB_Init(void);



extern u8 EPindex;




extern DEVICE_INFO* pInformation;


extern DEVICE_PROP* pProperty;




extern USER_STANDARD_REQUESTS *pUser_Standard_Requests;

extern u16 SaveState ;
extern u16 wInterrupt_Mask;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
#line 25 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
void UserToPMABufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes);
void PMAToUserBufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes);
#line 1 "z:/robs folder/dscope/usblib/inc/usb_int.h"
#line 26 "z:/robs folder/dscope/usblib/inc/usb_int.h"
void CTR_LP(void);
void CTR_HP(void);
#line 74 "z:/robs folder/dscope/include/usb_scsi.h"
extern u8 Page00_Inquiry_Data[];
extern u8 Standard_Inquiry_Data[];
extern u8 Mode_Sense6_data[];
extern u8 Mode_Sense10_data[];
extern u8 Scsi_Sense_Data[];
extern u8 ReadCapacity10_Data[];
extern u8 ReadFormatCapacity_Data [];



void SCSI_Inquiry_Cmd(void);
void SCSI_ReadFormatCapacity_Cmd(void);
void SCSI_ReadCapacity10_Cmd(void);
void SCSI_RequestSense_Cmd (void);
void SCSI_Start_Stop_Unit_Cmd(void);
void SCSI_ModeSense6_Cmd (void);
void SCSI_ModeSense10_Cmd (void);
void SCSI_Write10_Cmd(void);
void SCSI_Read10_Cmd(void);
void SCSI_Verify10_Cmd(void);

void SCSI_Invalid_Cmd(void);
void SCSI_Valid_Cmd(void);

void Set_Scsi_Sense_Data(u8 Sens_Key, u8 Asc);
#line 1 "z:/robs folder/dscope/include/memory.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_lib.h"
#line 9 "z:/robs folder/dscope/include/memory.h"
void Read_Memory(void);
void Write_Memory(void);
int Address_Management_Test(u8 Cmd);
#line 1 "z:/robs folder/dscope/include/usb_bot.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_lib.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
#line 28 "z:/robs folder/dscope/include/usb_bot.h"
typedef struct _Bulk_Only_CBW
{
 u32 dSignature;
 u32 dTag;
 u32 dDataLength;
 u8 bmFlags;
 u8 bLUN;
 u8 bCBLength;
 u8 CB[16];
}
Bulk_Only_CBW;


typedef struct _Bulk_Only_CSW
{
 u32 dSignature;
 u32 dTag;
 u32 dDataResidue;
 u8 bStatus;
}
Bulk_Only_CSW;
#line 81 "z:/robs folder/dscope/include/usb_bot.h"
void Mass_Storage_In (void);
void Mass_Storage_Out (void);
void CBW_Decode(void);
void Transfer_Data_Request(u8* Data_Pointer, u16 Data_Len);
void Set_CSW (u8 CSW_Status, u8 Send_Permission);
void Bot_Abort(u8 Direction);
#line 1 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
#line 1 "z:/robs folder/dscope/include/hw_v1_config.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_type.h"
#line 152 "z:/robs folder/dscope/include/hw_v1_config.h"
void Set_System(void);
void NVIC_Configuration(void);
void GPIO_Configure(void);
void Get_Medium_Characteristics(void);
void SPI_Config(void);

void DMA_Configuration(void);
void ADC_Configuration(void);
void Timer_Configuration(void);
char KeyScan(void);
void MSD_WriteByte(u8 byte);
unsigned char MSD_ReadByte(void);

void Battery_Detect(void);
void Set_Range(char Range);
void Set_Base(char Base);
void ADC_Start(void);
void Set_Y_Pos(unsigned short Y0);
char Test_USB_ON(void);
char SD_Card_ON(void);
#line 29 "Z:/Robs Folder/DScope/source/usb_scsi.c"
extern u8 Bulk_Data_Buff[ 0x00000040 ];
extern u8 Bot_State;
extern Bulk_Only_CBW CBW;
extern Bulk_Only_CSW CSW;
u32 Mass_Memory_Size;
u32 Mass_Block_Size;
u32 Mass_Block_Count;
#line 47 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Inquiry_Cmd(void)
{
 u8* Inquiry_Data;
 u16 Inquiry_Data_Length;

 if (CBW.CB[1] & 0x01)
 {
 Inquiry_Data = Page00_Inquiry_Data;
 Inquiry_Data_Length = 5;
 }
 else
 {
 Inquiry_Data = Standard_Inquiry_Data;
 if (CBW.CB[4] <=  0x24 )
 Inquiry_Data_Length = CBW.CB[4];
 else
 Inquiry_Data_Length =  0x24 ;
 }
 Transfer_Data_Request(Inquiry_Data, Inquiry_Data_Length);
}
#line 75 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_ReadFormatCapacity_Cmd(void)
{
 ReadFormatCapacity_Data[4] = (u8)(Mass_Block_Count >> 24);
 ReadFormatCapacity_Data[5] = (u8)(Mass_Block_Count >> 16);
 ReadFormatCapacity_Data[6] = (u8)(Mass_Block_Count >> 8);
 ReadFormatCapacity_Data[7] = (u8)(Mass_Block_Count);

 ReadFormatCapacity_Data[9] = (u8)(Mass_Block_Size >> 16);
 ReadFormatCapacity_Data[10] = (u8)(Mass_Block_Size >> 8);
 ReadFormatCapacity_Data[11] = (u8)(Mass_Block_Size);
 Transfer_Data_Request(ReadFormatCapacity_Data,  0x0C );
}
#line 95 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_ReadCapacity10_Cmd(void)
{
 ReadCapacity10_Data[0] = (u8)(Mass_Block_Count - 1 >> 24);
 ReadCapacity10_Data[1] = (u8)(Mass_Block_Count - 1 >> 16);
 ReadCapacity10_Data[2] = (u8)(Mass_Block_Count - 1 >> 8);
 ReadCapacity10_Data[3] = (u8)(Mass_Block_Count - 1);

 ReadCapacity10_Data[4] = (u8)(Mass_Block_Size >> 24);
 ReadCapacity10_Data[5] = (u8)(Mass_Block_Size >> 16);
 ReadCapacity10_Data[6] = (u8)(Mass_Block_Size >> 8);
 ReadCapacity10_Data[7] = (u8)(Mass_Block_Size);
 Transfer_Data_Request(ReadCapacity10_Data,  0x08 );
}
#line 116 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_ModeSense6_Cmd (void)
{
 Transfer_Data_Request(Mode_Sense6_data,  0x04 );
}
#line 128 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_ModeSense10_Cmd (void)
{
 Transfer_Data_Request(Mode_Sense10_data,  0x08 );
}
#line 140 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_RequestSense_Cmd (void)
{
 u8 Request_Sense_data_Length;

 if (CBW.CB[4] <=  0x12 )
 {
 Request_Sense_data_Length = CBW.CB[4];
 }
 else
 {
 Request_Sense_data_Length =  0x12 ;
 }
 Transfer_Data_Request(Scsi_Sense_Data, Request_Sense_data_Length);
}
#line 163 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void Set_Scsi_Sense_Data(u8 Sens_Key, u8 Asc)
{
 Scsi_Sense_Data[2] = Sens_Key;
 Scsi_Sense_Data[12] = Asc;
}
#line 176 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Start_Stop_Unit_Cmd(void)
{
 Set_CSW ( 0x00 ,  1 );
}
#line 188 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Read10_Cmd(void)
{

 if (Bot_State ==  0 )
 {
 if (!(Address_Management_Test( 0x28 )))
 {
 return;
 }

 if ((CBW.bmFlags & 0x80) != 0)
 {
 Bot_State =  2 ;
 Read_Memory();
 }
 else
 {
 Bot_Abort( 2 );
 Set_Scsi_Sense_Data( 0x05 ,  0x24 );
 Set_CSW ( 0x01 ,  1 );
 }
 return;
 }
 else if (Bot_State ==  2 )
 {
 Read_Memory();
 }
}
#line 224 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Write10_Cmd(void)
{

 if (Bot_State ==  0 )
 {
 if (!(Address_Management_Test( 0x2A )))
 {
 return;
 }

 if ((CBW.bmFlags & 0x80) == 0)
 {
 Bot_State =  1 ;
 SetEPRxStatus( ((u8)2) ,  (0x3000) );
 }
 else
 {
 Bot_Abort( 0 );
 Set_Scsi_Sense_Data( 0x05 ,  0x24 );
 Set_CSW ( 0x01 ,  0 );
 }
 return;
 }
 else if (Bot_State ==  1 )
 {
 Write_Memory();
 }
}
#line 260 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Verify10_Cmd(void)
{
 if ((CBW.dDataLength == 0) && !(CBW.CB[1] &  0x04 ))
 {
 Set_CSW ( 0x00 ,  1 );
 }
 else
 {
 Bot_Abort( 2 );
 Set_Scsi_Sense_Data( 0x05 ,  0x24 );
 Set_CSW ( 0x01 ,  0 );
 }
}
#line 281 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Valid_Cmd(void)
{
 if (CBW.dDataLength != 0)
 {
 Bot_Abort( 2 );
 Set_Scsi_Sense_Data( 0x05 ,  0x20 );
 Set_CSW ( 0x01 ,  0 );
 }
 else
 Set_CSW ( 0x00 ,  1 );
}
#line 300 "Z:/Robs Folder/DScope/source/usb_scsi.c"
void SCSI_Invalid_Cmd(void)
{
 if (CBW.dDataLength == 0)
 {
 Bot_Abort( 0 );
 }
 else
 {
 if ((CBW.bmFlags & 0x80) != 0)
 {
 Bot_Abort( 0 );
 }
 else
 {
 Bot_Abort( 2 );
 }
 }
 Set_Scsi_Sense_Data( 0x05 ,  0x20 );
 Set_CSW ( 0x01 ,  0 );
}
