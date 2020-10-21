from pynq import DefaultIP
from . import sthv1600_regmap as reg
import asyncio
import time


class STHV1600(DefaultIP):
    bindto = ['user.org:user:STHV1600:2.0']

    def __init__(self, description):
        super().__init__(description=description)

    def connect_BRAM(self, BRAM):
        self.BRAM = BRAM

    def create_header(self, devId, address, read1_write0: int):
        '''
        creates a header for writing and reading of the RAM of STHV1600 <VERIFIED>
        '''
        return (((address & 0x1FFF) << 7) | ((read1_write0 & 0x01) << 6) | ((devId & 0x000F) << 2) | 0b00)

    def program_RAM(self, amount, devId, address, data):
        header = self.create_header(
            devId=devId, address=address, read1_write0=0)
        print("-->header is {}".format(hex(header)))
        self.write(0x04, header)
        if(amount == 1):
            print("-> programming data {}".format(hex(data)))
            self.write(0x08, data)
        else:
            for i in range(amount):
                print("-> programming data {}".format(hex(data[i])))
                self.write(0x08+i*0x04, data[i])
        self.write(0x00, amount)
        if(self.read(0x00) != 0):
            print("read wrong value at config register, something went wrong?!")
            return False
        return True

    def read_RAM(self, amount, devId, address):
        header = self.create_header(
            devId=devId, address=address, read1_write0=1)
        # TODO Here we need an interrupt respons
        print("-->reading from reg {}".format(hex(header)))
        self.write(0x04, header)
        self.write(0x00, amount)
        if(self.read(0x00) != 0):
            print("read wrong value at config register, something went wrong?!")
            return False
        # await asyncio.sleep(0.01)
        # print("continuing")
        return_arr = []
        # READ BRAM Values
        for i in range(amount):
            return_arr.append(self.BRAM.read(0x4*i))
        return return_arr

    def read_write_RAM(self, devId, address, data, or1_and0: bool):
        '''this function reads a memory mapped address of the STHV1600 chip, alters the read data with <data> via a boolean or/and function and writes it back
        '''
        temp = self.read_RAM(1, devId, address)
        print("read 0x", (hex(temp[0])))
        if(or1_and0):
            temp[0] = temp[0] | data
        else:
            temp[0] = temp[0] & data
        result = self.program_RAM(1, devId, address, temp[0])
        return result

    def program_trig_usec(self, time_loop_usec, time_read_usec, cycle_amount):
        '''
        programs an amount of tx/rx loops with a certain duration for each part in microseconds.
        '''
        time_loop_ticks = time_loop_usec * reg.STHV1600_TRIG_CLK_USEC
        time_read_ticks = time_read_ticks * reg.STHV1600_TRIG_CLK_USEC
        return self.program_trig_ticks(time_loop_ticks=time_loop_ticks, time_read_ticks=time_read_ticks, cycle_amount=cycle_amount)

    def program_trig_ticks(self, time_loop_ticks, time_read_ticks, cycle_amount):
        '''
        programs an amount of tx/rx loops with a certain duration for each part in microseconds.
        '''
        self.write(0x0, time_loop_ticks)
        self.write(0x4, time_read_ticks)
        self.write(0x8, cycle_amount)
        self.write(0xC, 0x1)
        if(self.read(0x0C) != 0):
            print("read wrong value at config register, something went wrong?!")
            return False
        return True
