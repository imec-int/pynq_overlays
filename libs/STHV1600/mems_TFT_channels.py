import numpy as np
from enum import Enum
from . import sthv1600_regmap as reg
'''
file for reading the incoming JSON
'''


class MEMS_TFT():
    def __init__(self):
        super().__init__()

    def channels_drive(self):
        return {
            0: {reg.DEVID0, reg.channel_1, reg.delay_channel_1, reg.pointer_channel_1_0},
            1: {reg.DEVID0, reg.channel_3, reg.delay_channel_3, reg.pointer_channel_3_2},
            2: {reg.DEVID0, reg.channel_5, reg.delay_channel_5, reg.pointer_channel_5_4},
            3: {reg.DEVID0, reg.channel_7, reg.delay_channel_7, reg.pointer_channel_7_6},
        }

    def channels_read(self):
        return {
            0: {reg.DEVID0, reg.channel_0, reg.delay_channel_0, reg.pointer_channel_1_0},
            1: {reg.DEVID0, reg.channel_2, reg.delay_channel_2, reg.pointer_channel_3_2},
            2: {reg.DEVID0, reg.channel_4, reg.delay_channel_4, reg.pointer_channel_5_4},
            3: {reg.DEVID0, reg.channel_6, reg.delay_channel_6, reg.pointer_channel_7_6},
        }

    def rx_channels(self):
        return {
            reg.DEVID0: 0x0055,
        }

    def tx_channels(self):
        return {
            reg.DEVID0: 0x00AA,
        }

