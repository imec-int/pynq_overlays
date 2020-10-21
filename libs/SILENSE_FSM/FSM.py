from pynq import DefaultHierarchy, DefaultIP
import numpy as np


class FSM(DefaultHierarchy):
    def __init__(self, description):
        super().__init__(description)
        print("FSM found")

    @staticmethod
    def checkhierarchy(description):
        if('S00_AXI' in description['ip']
           and 'S_AXI_INTR' in description['ip']):
            return True
        return False


class FSM_PRG(DefaultIP):
    bindto = ['user.org:user:silense_FSM:1.0']

    def __init__(self, description):
        super().__init__(description=description)
        print("found FSM_PRG")
        self.MILLIVOLT_MAX = 4096
        self.MILLIVOLT_MIN = -4096
        self.ADC_BITS = 16

    def connect_BRAM(self, BRAM):
        self.BRAM = BRAM

    def sdi_config(self, sdi_config):
        print("writing {} as sdi config".format(hex(sdi_config)))
        self.write(0x4, sdi_config & 0x0fff)

    def FSM_init(self, data):
        self.write(0x0, data)

    def read_detections(self):
        detections = self.read(0x8)
        return detections

    def volt_conv(self, signal):
        return np.int16(signal)*(self.MILLIVOLT_MAX-self.MILLIVOLT_MIN)/np.power(2, self.ADC_BITS)

    def read_BRAM_val(self, BRAM, startpoint, val_range):
        BRAM_val = []
        BRAM_val.clear()
        for i in range(val_range):
            a = BRAM.read(0x4*i+startpoint)
            b = a & 0x0000FFFF
            c = a >> 16
            BRAM_val.append(self.volt_conv(b))
            BRAM_val.append(self.volt_conv(c))
        return BRAM_val
