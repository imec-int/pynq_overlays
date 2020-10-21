from pynq import DefaultHierarchy
from . import sthv1600_regmap as reg
import numpy as np
from pynq.ps import Clocks


class STHV(DefaultHierarchy):
    def __init__(self, description):
        super().__init__(description)

    @staticmethod
    def checkhierarchy(description):
        if('S00_AXI_PRG' in description['ip']
           and 'S01_AXI_TRIG' in description['ip']
           and 'S_AXI_INTR' in description['ip']):
            return True
        return False

    def connect_BRAM(self, BRAM):
        '''
        function should be called after connecting the STHV in python, to be able to read the BRAM contents
        '''
        self.BRAM = BRAM
        self.S00_AXI_PRG.connect_BRAM(BRAM)

    def connect_TFT(self, TFT):
        '''
        function should be called after connecting the STHV in python, to be able to address the TFT
        '''
        self.TFT = TFT

    def STHV_PRG_RAM(self, amount, devId, address, data):
        self.S00_AXI_PRG.program_RAM(
            amount=amount, devId=devId, address=address, data=data)

    def STHV_READ_PRG_RAM(self, devId, address, data, or1_and0: bool):
        self.S00_AXI_PRG.read_write_RAM(
            devId=devId, address=address, data=data, or1_and0=or1_and0)

    def STHV_RAM_READ(self, amount, devId, address):
        return self.S00_AXI_PRG.read_RAM(amount, devId, address)

    def STHV_TRIG(self, tx_rxtime, cycle_amount=1, idle_time=1):
        print("programming STHV1600 trigger in ticks mode", tx_rxtime)
        self.S01_AXI_TRIG.program_trig_ticks(
            tx_rxtime, idle_time, cycle_amount)

    def nanos_to_ticks(self, data):
        '''
        this function takes an amount of nanoseconds (integer) and returns the amount of clockticks (rounded to integer)
        '''
        clk = Clocks.fclk0_mhz/reg.clock_offset_error
        print("clk ref is ",clk)
        if(type(data) == list):
            data = [int(i/(clk/10)) for i in data]
        else:
            data = int(data/int(clk/10))
        return data

    def example_case(self, devIdList, topology, cycle_amount = 5):
        '''
        An example use case for programming the PCBs
        devIdList: list of 4 bits: from sthv1600_regmap.py: choose which STHV1600 pulser chips to address
        topology: string: 'MEMS-ONLY' or 'MEMS-TFT'
        cycle_amount: integer: how many TX-RX loops do you want
        '''

        volt_states = ['HVP1', 'CLAMP',
                       'NOP', 'NOP']
        time_reg_ns = [250, 200, 0, 0]
        time_reg_ticks = self.nanos_to_ticks(time_reg_ns)
        print("time_reg_ticks", time_reg_ticks)
        amount_of_states = 2
        repetitions = 3  # subtract 2 when generating pulse table!
        delay_table = [10, 220, 30, 140, 250]
        startPointList = [0x0000, 0x0000, 0x0000,
                          0x0000, 0x0000, 0x0000, 0x0000, 0x0000]

        for i in devIdList:
            self.enableTx(devId=i, onChannels=0xFF) # 0b1111 0011 1111 1111
            self.enableRx(devId=i, onChannels=0xFF) # 0b1111 1100 1111 1111
            self.start_registers(devId=i, starting_point_table=startPointList)
            self.start_delay(devId=i, delay_table_nsec=delay_table)
            self.programPulseAtChannel(
                i, volt_states, time_reg_ticks, amount_of_states, repetitions, reg.channel_0, True)
        txtime = self.calc_tx_time_ticks(
            np.sum(time_reg_ticks)*(repetitions), self.nanos_to_ticks(delay_table))
        if(topology == 'MEMS-ONLY'):
            print("MEMS-ONLY programming")
            self.STHV_TRIG(tx_rxtime=txtime, idle_time=0x4000, cycle_amount=cycle_amount)
        else:
            if(topology == 'MEMS-TFT'):
                print("MEMS-TFT programming")
                self.STHV_TRIG(tx_rxtime=txtime)
                self.TFT.init_joint_passive(
                    data_l=0xC, read_sel_l=0xC, time_sel=0x200, time_restart=0x1000, cycle_amount=cycle_amount)
            else:
                print("wrong topology name, use 'MEMS-TFT' or 'MEMS-ONLY'")

    def example_datasheet_21(self, devId, topology):
        '''
        The datasheet shows an example on page 21.
        devId: 4 bits: from sthv1600_regmap.py: choose which STHV1600 pulser chip to address
        topology: string: 'MEMS-ONLY' or 'MEMS-TFT'
        '''

        self.STHV_PRG_RAM(devId=devId, address=0x0000, amount=1, data=0x006a)
        self.STHV_PRG_RAM(devId=devId, address=0x0001, amount=1, data=0x006a)
        self.STHV_PRG_RAM(devId=devId, address=0x0002, amount=1, data=0x006a)
        self.STHV_PRG_RAM(devId=devId, address=0x0003, amount=1, data=0x006a)
        self.STHV_PRG_RAM(devId=devId, address=0x0004, amount=1, data=0x0025)
        self.STHV_PRG_RAM(devId=devId, address=0x0005, amount=1, data=0x000a)
        self.STHV_PRG_RAM(devId=devId, address=0x0006, amount=1, data=0x0006)
        self.STHV_PRG_RAM(devId=devId, address=0x0007, amount=1, data=0x000E)
        self.STHV_PRG_RAM(
            devId=devId, address=reg.pointer_channel_1_0, amount=1, data=0x0000)
        self.enableTx(devId=devId, onChannels=0xFF)
        if(topology == 'MEMS-TFT'):
            self.STHV_TRIG(tx_rxtime=0x30)
            self.TFT.init_joint_passive(
                data_l=0xC, read_sel_l=0xC, time_sel=0x011, time_restart=0x1465, cycle_amount=5)
        else:
            self.STHV_TRIG(tx_rxtime=0x30,  idle_time=0x1000, cycle_amount=5)

    def programPulseAtChannel(self, devId, volt_states, time_list, amount_of_states, pulse_amount, channel, allChannels):
        # pulse_reg = [0x0, 0x0, 0x0, 0x0]
        volt_state_values = []
        for i in volt_states:
            volt_state_values.append(reg.Level_State[i].value)
        if(pulse_amount >= 2):
            pulse_reg = self.create_pulse_shape_registers(
                amount_of_states=amount_of_states, repetitions=pulse_amount-2, states=volt_state_values, timings=time_list)
        else:
            pulse_reg = self.create_pulse_shape_registers(
                amount_of_states=amount_of_states, repetitions=0, states=volt_state_values, timings=time_list)
        print("amount of pulse regs:", len(pulse_reg))
        for i in pulse_reg:
            print("--> pulse shape registers per channel: ",  hex(i))
        if(allChannels == True):
            self.all_channels_same_pattern(
                devId=devId, enable=reg.Channel_sharing.SHARING.value)
        self.STHV_PRG_RAM(amount=len(pulse_reg), devId=devId,
                          address=channel, data=pulse_reg)

        # self.all_channels_same_pattern(
        #     devId=devId, enable=reg.Channel_sharing.SHARING.value)

    def initRAM(self, devId):
        '''
        When bit 12 of register config_0, called RAM_initialization, is set to 1, an internal procedure starts and writes all
        bits of all SRAM cells to a 0 value. This initialization procedure takes 256 x Tclksys
        It is recommended to start this procedure after power-on of the device (to ensure that all states are set to NOP)
        and to avoid providing stimulus to the IC through Trigger and SPI interface.
        '''
        # self.STHV_READ_PRG_RAM(devId,reg.config_0, reg.Ram_init.RESET_RAM.value, or1_and0=1)
        self.STHV_PRG_RAM(1, devId, reg.config_0,
                          reg.Ram_init.RESET_RAM.value)

    def disable_HV(self, devId):
        '''
        Writing bit 9 of register config_0 to a 1 value, the manual management of reference power-down is enabled.
        To selectively switch on/off the reference blocks, refer to register HV_ref_voltage[7:4].
        For example, if half
        bridge TX1 is not used, the related HV reference voltage blocks can be turned OFF, by setting 0x1003 bits 7
        and 5 to 0.
        While, if half bridge TX0 is not used, the saving is given by setting 0x1003 bits 6 and 4 to 0.
        In case of negative pulses only, the bits 7 and 6 can be set low, instead.

        Writing bit 8 of register config_0 to a 1 value, HV references are automatically disabled during RX and
        enabled in TX and IDLE
        '''
        return False

    def low_power_test(self, devId):
        self.STHV_PRG_RAM(devId=devId, amount=0x1,
                          address=0x1008, data=0x0400)

    def start_registers(self, devId, starting_point_table):
        self.STHV_PRG_RAM(
            devId=devId, address=reg.pointer_channel_1_0, amount=len(starting_point_table), data=starting_point_table)

    def start_delay(self, devId, delay_table_nsec):
        # first convert to clock ticks
        delay_table_clockticks = self.nanos_to_ticks(delay_table_nsec)
        amount = len(delay_table_nsec)
        print("start delay:", delay_table_clockticks)
        # toticks = (Clocks.fclk0_mhz/reg.clock_offset_error)/reg.MHZTOSECONDS
        # for i in range(amount):
        #     delay_table_clockticks.append(int(delay_table_nsec[i] * toticks ))
        # *reg.NANOTICKS))
        # we start writing at delay channel 0 and automatically count up for all channels
        self.STHV_PRG_RAM(amount=amount, devId=devId,
                          address=reg.delay_channel_0,  data=delay_table_clockticks)

    def enableTx(self, devId, onChannels):
        '''active 1 enabling of driving of channels'''
        self.STHV_PRG_RAM(1, devId, reg.enable_tx, onChannels)

    def enableRx(self, devId, onChannels):
        '''active 1 enabling of driving of channels'''
        self.STHV_PRG_RAM(1, devId, reg.enable_rx, onChannels)

    def rx_start_mode(self, devId, mode):
        '''
        If rx_start_mode = 1 the RX channel starts receiving at the rising edge of the trigger signal, regardless the
        rx_mode value
        '''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.rx_delay, data=mode, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, rx_delay, mode, true)

    def rx_mode(self, devId, mode):
        '''    
        rx_mode defines if we wait for all TX channels to be finished before going to RX wait + RX mode, or each channel goes individually to RX wait + RX mode
        '''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.rx_delay, data=mode, or1_and0=True)

        # STHV1600_PRG_read_write_reg(devId, inst, rx_delay, mode, true)

    def set_rx_delay(self, devId, delay_clk):
        '''
        set_rx_delay
        we and the delay_clk value to make sure we're NOT overwriting the MSB of rx_delay as this is rx_mode bit
        '''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.rx_delay, data=delay_clk & 0x7FFF, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, rx_delay, delay_clk & 0x7FFF,
        #                             true)

    def inverse_state(self, devId, inversion):
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.config_0, data=inversion, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, config_0, inversion, true);

    def all_channels_same_pattern(self, devId, enable):
        '''
        write the pattern to channel 0, all other channels read this channel, with individual delay per channel.
            ‘0’ : Normal mode (each channel RAM is addressed individually)
            ‘1’ : all 16 SRAM blocks are written at the same time (with the same
        content)
        '''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.config_0, data=enable, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, config_0, enable,
        #                             true);

    def spi_read_mode(self, devId, mode):
        ''' 
        ‘0’: data on DATA_OUT takes 2 CLKSER pulses.
        ‘1’: data on DATA_OUT takes 4 CLKSER pulses.
        '''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.config_1, data=mode, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, config_1, mode, true);

    def tx_on_mode(self, devId, mode):
        '''tx_on_mode defines if TX_ON output goes low after the last channel ends transmitting, or if it goes low after the last wait_RX phase.'''
        self.STHV_READ_PRG_RAM(
            devId=devId, address=reg.config_1, data=mode, or1_and0=True)
        # STHV1600_PRG_read_write_reg(devId, inst, config_1, mode, true);

    def read_interrupt(self, devId):
        return self.STHV_RAM_READ(amount=1, devId=devId, address=reg.status_reg)

    def calc_tx_time_ticks(self, wavelength_array, start_delay_array):
        '''
        calc tx time ticks:
        calculates the (minimum) time we need to tie the trigger high, 
        wavelength_array: 1D array with each row the time values for a channel (consisting of times and repetitions multiplied and summed)
        start_delay_array: 1D array with start values for each channel
        defined by the the length of the pulse to be transmitted (sum of time_array gives a 1D array of all different channels, from which we take the max value) 
        and the longest time we have to wait for a pulse to start transmitting
        '''
        max_delay = np.amax(start_delay_array)
        max_pulse_time = np.amax(wavelength_array)
        return int(max_pulse_time+max_delay)

    def create_pulse_shape_registers(self, amount_of_states, repetitions, states, timings):
        reg0b15b14 = (amount_of_states - 1) & 0b00000011
        reg0b13b11 = repetitions & 0x00000007  # only last 3 bits
        regb15b11 = [0x0, 0x0, 0x0, 0x0]
        return_regs = []
        regb15b11[0] = reg0b15b14 << 3 | reg0b13b11
        # next 5 bits, yet shifted so they start from position 0
        regb15b11[1] = (repetitions & 0x000000F8) >> 3
        regb15b11[2] = (repetitions & 0x00001F00) >> 8
        regb15b11[3] = (repetitions & 0x0003E000) >> 13
        return_regs = []
        for i in range(amount_of_states):
            return_regs.append(regb15b11[i] << 11 | (
                timings[i] & 0x7F) << 4 | (states[i] & 0x0F))
        # append also the END_TX signal
        return_regs.append(0xE)
        return return_regs
