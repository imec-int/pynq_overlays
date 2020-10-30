from enum import Enum

'''
AD9675_SPI_regmap
memory map register table
according to AD9675 datasheet pages 47-58
'''

'''
chip_configuration_registers
'''

CHIP_PORT_CONFIG = {'addr': 0x000,    'def_val': 0x18}

CHIP_ID = {'addr': 0x001,    'def_val': 0xA9}
CHIP_GRADE = {'addr': 0x002,    'def_val': 0x00}

'''
Device index and update registers
'''

DEVICE_INDEX_2 = {'addr': 0x004,    'def_val': 0x0F}
DEVICE_INDEX_1 = {'addr': 0x005,    'def_val': 0x3F}
DEVICE_UPDATE = {'addr': 0x0FF,    'def_val': 0x00}

'''
Program Function Registers
'''
GLOBAL_MODES = {'addr': 0x008, 'def_val': 0x01}
GLOBAL_CLOCK = {'addr': 0x009, 'def_val': 0x01}
PLL_STATUS = {'addr': 0x00A, 'def_val': 0x00}
TEST_IO = {'addr': 0x00D, 'def_val': 0x00}
GPO = {'addr': 0x00E, 'def_val': 0x00}
FLEX_CHANNEL_INPUT = {'addr': 0x00F, 'def_val': 0x18}
FLEX_OFFSET = {'addr': 0x010, 'def_val': 0x20}
FLEX_GAIN = {'addr': 0x011, 'def_val': 0x06}
BIAS_CURRENT = {'addr': 0x012, 'def_val': 0x09}
RESERVED_13 = {'addr': 0x013, 'def_val': 0x00}
OUTPUT_MODE = {'addr': 0x014, 'def_val': 0x01}
OUTPUT_ADJUST = {'addr': 0x015, 'def_val': 0x61}
RESERVED_16 = {'addr': 0x016, 'def_val': 0x00}
RESERVED_17 = {'addr': 0x017, 'def_val': 0x00}
FLEX_VREF = {'addr': 0x018, 'def_val': 0x04}
USER_PATT1_LSB = {'addr': 0x019, 'def_val': 0x00}
USER_PATT1_MSB = {'addr': 0x01A, 'def_val': 0x00}
USER_PATT2_LSB = {'addr': 0x01B, 'def_val': 0x00}
USER_PATT2_MSB = {'addr': 0x01C, 'def_val': 0x00}
USER_PATT3_LSB = {'addr': 0x01D, 'def_val': 0x00}
USER_PATT3_MSB = {'addr': 0x01E, 'def_val': 0x00}
USER_PATT4_LSB = {'addr': 0x01F, 'def_val': 0x00}
USER_PATT4_MSB = {'addr': 0x020, 'def_val': 0x00}
FLEX_SERIAL_CTRL = {'addr': 0x021, 'def_val': 0x00}
SERIAL_CH_STAT = {'addr': 0x022, 'def_val': 0x00}
FLEX_FILTER = {'addr': 0x02B, 'def_val': 0x00}
LNA_TERM = {'addr': 0x02C, 'def_val': 0x00}
CW_ENABLE_PHASE = {'addr': 0x02D, 'def_val': 0x00}
CW_LO_MODE = {'addr': 0x02E, 'def_val': 0x00}
CW_OUTPUT = {'addr': 0x02F, 'def_val': 0x80}
VGA_TEST = {'addr': 0x109, 'def_val': 0x00}
PROFILE_INDEX = {'addr': 0x10C, 'def_val': 0x00}
DIG_OFFSET_CAL = {'addr': 0x10F, 'def_val': 0x00}
DIG_OFFSET_CORR1 = {'addr': 0x110, 'def_val': 0x00}
DIG_OFFSET_CORR2 = {'addr': 0x111, 'def_val': 0x00}
POWER_MASK_CONFIG = {'addr': 0x112, 'def_val': 0x02}
DIG_CONFIG = {'addr': 0x113, 'def_val': 0x00}
CHIP_ADDR_EN = {'addr': 0x115, 'def_val': 0x00}
ANALOG_TEST_TONE = {'addr': 0x116, 'def_val': 0x00}
DIG_SINE_TEST_FREQ = {'addr': 0x117, 'def_val': 0x00}
DIG_SINE_TEST_AMP = {'addr': 0x118, 'def_val': 0x00}
DIG_SINE_TEST_OFFSET = {'addr': 0x119, 'def_val': 0x00}
TEST_MODE_CHENABLE = {'addr': 0x11A, 'def_val': 0x00}
TEST_MODE_CONFIG = {'addr': 0x11B, 'def_val': 0x00}
CW_TEST_TONE = {'addr': 0x120, 'def_val': 0x00}
JTX_LINK_CTRL1 = {'addr': 0x142, 'def_val': 0x00}
JTX_LINK_CTRL2 = {'addr': 0x143, 'def_val': 0x00}
JTX_LINK_CTRL3 = {'addr': 0x144, 'def_val': 0x00}
JTX_LINK_CTRL4 = {'addr': 0x145, 'def_val': 0x00}
JTX_DID_CFG = {'addr': 0x146, 'def_val': 0x00}
JTX_BID_CFG = {'addr': 0x147, 'def_val': 0x00}
JTX_LID0_CFG = {'addr': 0x148, 'def_val': 0x00}
JTX_LID1_CFG = {'addr': 0x149, 'def_val': 0x01}
JTX_LID2_CFG = {'addr': 0x14A, 'def_val': 0x02}
JTX_LID3_CFG = {'addr': 0x14B, 'def_val': 0x03}
JTX_SCR_L_CFG = {'addr': 0x150, 'def_val': 0x83}
JTX_F_CFG = {'addr': 0x151, 'def_val': 0x03}
JTX_K_CFG = {'addr': 0x152, 'def_val': 0x0F}
JTX_M_CFG = {'addr': 0x153, 'def_val': 0x07}
JTX_CS_N_CFG = {'addr': 0x154, 'def_val': 0x0F}
JTX_SCV_NP_CFG = {'addr': 0x155, 'def_val': 0x0F}
JTX_JV_S_CFG = {'addr': 0x156, 'def_val': 0x20}
JTX_HD_CF_CFG = {'addr': 0x157, 'def_val': 0x00}
JTX_RES1_CFG = {'addr': 0x158, 'def_val': 0x00}
JTX_RES2_CFG = {'addr': 0x159, 'def_val': 0x00}
JTX_CHKSUM0_CFG = {'addr': 0x15A, 'def_val': 0x3C}
JTX_CHKSUM1_CFG = {'addr': 0x15B, 'def_val': 0x3D}
JTX_CHKSUM2_CFG = {'addr': 0x15C, 'def_val': 0x3E}
JTX_CHKSUM3_CFG = {'addr': 0x15D, 'def_val': 0x3F}
JTX_CLK_CNTL_1 = {'addr': 0x180, 'def_val': 0x87}
JTX_CLK_CNTL_2 = {'addr': 0x181, 'def_val': 0x00}
PLL_STARTUP = {'addr': 0x182, 'def_val': 0x02}
DATA_VALID_RESYNC = {'addr': 0x186, 'def_val': 0xAE}
START_CODE_EN = {'addr': 0x188, 'def_val': 0x01}
START_CODE_MSB = {'addr': 0x18B, 'def_val': 0x27}
START_CODE_LSB = {'addr': 0x18C, 'def_val': 0x72}
FRAME_SIZE_MSB = {'addr': 0x190, 'def_val': 0x10}
SAMPLE_CLOCK_CONVERTER = {'addr': 0x199, 'def_val': 0x00}
JTX_FRAME_SIZE = {'addr': 0x19C, 'def_val': 0x10}


'''
Profile memory registers
32x64 bits
'''
PROFILE_MEMORY = {
    'addr': 0xF00,
    'start_addr': 0xF00,
    'def_val': 0x00,
    'end_addr': 0xFFF
}
