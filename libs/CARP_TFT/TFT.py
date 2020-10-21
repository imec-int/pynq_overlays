from pynq import DefaultIP
import asyncio
import time
from . import TFT_regmap as reg


class TFT(DefaultIP):
    bindto = ['user.org:user:tft_states:1.0']

    def __init__(self, description):
        super().__init__(description=description)
        print("connecting TFT")

    def init_joint_passive(self, data_l, read_sel_l, time_sel, time_restart, cycle_amount):
        self.write(reg.DATA, (data_l & 0x0F))
        self.write(reg.READ_SEL, (read_sel_l & 0x0F))
        self.write(reg.TIME_SEL, time_sel)
        self.write(reg.TIME_RESTART, time_restart)
        self.write(reg.TOPOLOGY, reg.TFT_topology.JOINT_PASSIVE.value)
        self.write(reg.AMOUNT, cycle_amount)
        print("joint passive TFT initiated")

    def test_tft_lines(self, data_l, read_sel_l, drive_sel_l):
        self.write(reg.DATA, (data_l & 0x0F))
        self.write(reg.READ_SEL, (read_sel_l & 0x0F))
        self.write(reg.SEL_DRIVE, (drive_sel_l & 0x0F))
        self.write(reg.TOPOLOGY, reg.TFT_topology.SPLIT_PASSIVE.value)
        self.write(reg.AMOUNT, 1)
        print("testing TFT initiated")