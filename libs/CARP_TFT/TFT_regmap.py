from enum import Enum
'''offsets for programming the TFT IP'''
DATA = 0x0
SEL_DRIVE = 0x4
DESEL_DRIVE = 0x8
READ_SEL = 0xC
TIME_SEL = 0x10
TIME_DESEL = 0x14
TIME_RESTART = 0x18
TOPOLOGY = 0x1C
AMOUNT = 0x20

class TFT_topology(Enum):
    SPLIT_PASSIVE = 0x0
    JOINT_PASSIVE = 0x1
    SPLIT_ACTIVE = 0x2
    JOINT_ACTIVE =0x3
