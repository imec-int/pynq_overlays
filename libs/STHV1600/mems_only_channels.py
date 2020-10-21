import numpy as np
from enum import Enum
from . import sthv1600_regmap as reg
'''
file for reading the incoming JSON
'''


class ROW_COLUMN():
    def __init__(self):
        super().__init__()

    def channels_drive(self):
        return {
            0: {reg.DEVID0, reg.channel_0, reg.delay_channel_0, reg.pointer_channel_1_0},
            1: {reg.DEVID0, reg.channel_1, reg.delay_channel_1, reg.pointer_channel_1_0},
            2: {reg.DEVID0, reg.channel_2, reg.delay_channel_2, reg.pointer_channel_3_2},
            3: {reg.DEVID0, reg.channel_3, reg.delay_channel_3, reg.pointer_channel_3_2},
            4: {reg.DEVID0, reg.channel_4, reg.delay_channel_4, reg.pointer_channel_5_4},
            5: {reg.DEVID0, reg.channel_5, reg.delay_channel_5, reg.pointer_channel_5_4},
            6: {reg.DEVID0, reg.channel_6, reg.delay_channel_6, reg.pointer_channel_7_6},
            7: {reg.DEVID0, reg.channel_7, reg.delay_channel_7, reg.pointer_channel_7_6},
            8: {reg.DEVID1, reg.channel_0, reg.delay_channel_0, reg.pointer_channel_1_0},
            9: {reg.DEVID1, reg.channel_1, reg.delay_channel_1, reg.pointer_channel_1_0},
            10: {reg.DEVID1, reg.channel_2, reg.delay_channel_2, reg.pointer_channel_3_2},
            11: {reg.DEVID1, reg.channel_3, reg.delay_channel_3, reg.pointer_channel_3_2},
            12: {reg.DEVID1, reg.channel_4, reg.delay_channel_4, reg.pointer_channel_5_4},
            13: {reg.DEVID1, reg.channel_5, reg.delay_channel_5, reg.pointer_channel_5_4},
            14: {reg.DEVID1, reg.channel_6, reg.delay_channel_6, reg.pointer_channel_7_6},
            15: {reg.DEVID1, reg.channel_7, reg.delay_channel_7, reg.pointer_channel_7_6},
        }

    def channels_read(self):
        return {
            0: {reg.DEVID0, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            1: {reg.DEVID0, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            2: {reg.DEVID0, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            3: {reg.DEVID0, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            4: {reg.DEVID0, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            5: {reg.DEVID0, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            6: {reg.DEVID0, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            7: {reg.DEVID0, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
            8: {reg.DEVID1, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            9: {reg.DEVID1, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            10: {reg.DEVID1, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            11: {reg.DEVID1, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            12: {reg.DEVID1, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            13: {reg.DEVID1, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            14: {reg.DEVID1, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            15: {reg.DEVID1, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
        }

    def rx_channels(self):
        return {
            reg.DEVID0: 0xFF00,
            reg.DEVID1: 0xFF00
        }

    def tx_channels(self):
        return {
            reg.DEVID0: 0x00FF,
            reg.DEVID1: 0x00FF
        }


class ROW_ROW():
    def __init__(self):
        super().__init__()

    def channels_drive(self):
        return {
            0: {reg.DEVID0, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            1: {reg.DEVID0, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            2: {reg.DEVID0, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            3: {reg.DEVID0, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            4: {reg.DEVID0, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            5: {reg.DEVID0, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            6: {reg.DEVID0, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            7: {reg.DEVID0, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
            8: {reg.DEVID1, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            9: {reg.DEVID1, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            10: {reg.DEVID1, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            11: {reg.DEVID1, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            12: {reg.DEVID1, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            13: {reg.DEVID1, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            14: {reg.DEVID1, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            15: {reg.DEVID1, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
        }

    def channels_read(self):
        return {
            0: {reg.DEVID0, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            1: {reg.DEVID0, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            2: {reg.DEVID0, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            3: {reg.DEVID0, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            4: {reg.DEVID0, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            5: {reg.DEVID0, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            6: {reg.DEVID0, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            7: {reg.DEVID0, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
            8: {reg.DEVID1, reg.channel_8, reg.delay_channel_8, reg.pointer_channel_9_8},
            9: {reg.DEVID1, reg.channel_9, reg.delay_channel_9, reg.pointer_channel_9_8},
            10: {reg.DEVID1, reg.channel_10, reg.delay_channel_10, reg.pointer_channel_11_10},
            11: {reg.DEVID1, reg.channel_11, reg.delay_channel_11, reg.pointer_channel_11_10},
            12: {reg.DEVID1, reg.channel_12, reg.delay_channel_12, reg.pointer_channel_13_12},
            13: {reg.DEVID1, reg.channel_13, reg.delay_channel_13, reg.pointer_channel_13_12},
            14: {reg.DEVID1, reg.channel_14, reg.delay_channel_14, reg.pointer_channel_15_14},
            15: {reg.DEVID1, reg.channel_15, reg.delay_channel_15, reg.pointer_channel_15_14},
        }
    def rx_channels(self):
        return {
            reg.DEVID0: 0xFF00,
            reg.DEVID1: 0xFF00
        }
    def tx_channels(self):
        return {
            reg.DEVID0: 0xFF00,
            reg.DEVID1: 0xFF00
        }

# driving_types = {
#     0: "ROW_ROW",
#     1: "ROW_COLUMN"
# }


# def channel_setup(driving_type):
#     # if(driving_type=driving_types.get())
