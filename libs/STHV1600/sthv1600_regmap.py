from enum import Enum


# from pynq.ps import Clocks
clock_offset_error = 1.5 #todo for some reason, the clock is scaled with 1.5 difference??
# # common variables
# STHV1600_TRIG_CLK = Clocks.fclk0_mhz/clock_offset_error  # Hz
# STHV1600_TRIG_CLK_USEC = STHV1600_TRIG_CLK/1000000
# STHV_CLOCK  =  STHV1600_TRIG_CLK #Hz
# NANOTOSECONDS = 1000000000
# NANOTICKS = NANOTOSECONDS / STHV_CLOCK

# defines from VHDL generics
DATA_REG_AMOUNT = 16

# IP block offsets
# defines for RAM Programming
config = 0x0
header = 0x4
data = 0x8
# defines for Trigger Programming
tx_rx_time_ticks_reg = 0x0
idle_time_ticks_reg = 0x4
cycle_amount_reg = 0x8
start_reg = 0xC

DEVID0 = 0x0
DEVID1 = 0x1
DEVID_SIL_DRIVE = 0x0
DEVID_SIL_READ = 0xF

'''
* SRAM BLOCKS
* xxxx xxxx xxxx xxxx
* b15-b14: repetition type (?)
* b13-b11: repetition number (?)
* b10-b4 state time duration T[10-4]
* b3-b0: state type bit S[3-0]
'''
channel_0 = 0x0000
channel_1 = 0x0100
channel_2 = 0x0200
channel_3 = 0x0300
channel_4 = 0x0400
channel_5 = 0x0500
channel_6 = 0x0600
channel_7 = 0x0700
channel_8 = 0x0800
channel_9 = 0x0900
channel_10 = 0x0A00
channel_11 = 0x0B00
channel_12 = 0x0C00
channel_13 = 0x0D00
channel_14 = 0x0E00
channel_15 = 0x0F00


class Level_State(Enum):
    '''
    Level_State
    drive status S[3-0]
    T[10-4]: time duration is set using the following formula: T = (2 + n) x Tclk
    (2x Tclk) < T < (129 x Tclk)
    '''
    NOP = 0x0   # No operations (Pulser HV output clamped to ground)
    HZ = 0x2     # Pulser HV output in high impedance
    CLAMP = 0xF  # Pulser HV output clamped to ground
    END_TX = 0xE  # End TX sequence, RX starts if enabled
    HVM0 = 0xA   # Enable pull down of TX0
    HVP0 = 0x5   # Enable pull up of TX0
    HVM1 = 0x9  # Enable pull down of TX1
    HVP1 = 0x6   # Enable pull up of TX1
    HVMM = 0xB   # Enable pull down of both TX0 and TX1
    HVPP = 0x4    # Enable pull up of both TX0 and TX1


''' 
CONFIGURATION
STHV1600 specific registers
'''
bridge_delay = 0x1000
clamp_delay = 0x1001
IO_config = 0x1002
HV_ref_voltage = 0x1003
timeout_config = 0x1004
rx_delay = 0x1005


class Rx_mode(Enum):
    ALL_TX_END = 1
    RX_MODE_DEFAULT = 0


''' 
Enable TX/RX
bit 0 = ch0, bit 15 = bit 15
'''
enable_tx = 0x1006
enable_rx = 0x1007
config_0 = 0x1008
config_1 = 0x1009


class Rx_start_mode(Enum):
    RX_DELAY_SETTING = 0x0000
    RX_AFTER_TRIGGER = 0x2000


class Ram_init(Enum):
    RESET_RAM = 0x1000
    NO_RESET = 0x0000


class State_inversion(Enum):
    INVERSION = 0x0010
    NO_INVERSION = 0x0000


class Channel_sharing(Enum):
    SHARING = 0x0002
    NO_SHARING = 0x0000


class Spi_read_mode(Enum):
    PULSES_2 = 0x0000
    PULSES_4 = 0x0008


class Tx_on_mode(Enum):
    TX_ONLY = 0x0000
    TX_WAIT_RX = 0x0004


'''
DELAY TABLE
maximum delay allowed is 216-1 x Tclk
Beamformer delay values
'''
delay_channel_0 = 0x100A
delay_channel_1 = 0x100B
delay_channel_2 = 0x100C
delay_channel_3 = 0x100D
delay_channel_4 = 0x100E
delay_channel_5 = 0x100F
delay_channel_6 = 0x1010
delay_channel_7 = 0x1011
delay_channel_8 = 0x1012
delay_channel_9 = 0x1013
delay_channel_10 = 0x1014
delay_channel_11 = 0x1015
delay_channel_12 = 0x1016
delay_channel_13 = 0x1017
delay_channel_14 = 0x1018
delay_channel_15 = 0x1019

'''
WF_SEL_OPT
Wave form table registers, storing the address from which waveform generation starts
Wave form start TX
bits[15:8] upper, bits [7:0] lower channel
'''
pointer_channel_1_0 = 0x101A
pointer_channel_3_2 = 0x101B
pointer_channel_5_4 = 0x101C
pointer_channel_7_6 = 0x101D
pointer_channel_9_8 = 0x101E
pointer_channel_11_10 = 0x101F
pointer_channel_13_12 = 0x1020
pointer_channel_15_14 = 0x1021

'''CHECKSUM'''
checksum = 0x1022
'''STATUS'''
status_reg = 0x1028
