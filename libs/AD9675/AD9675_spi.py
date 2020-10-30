from pynq import DefaultIp
from . import AD9675_SPI_regmap as reg
import spidev
# https://ez.analog.com/linux-software-drivers/f/q-a/87344/is-3-wire-mode-supported-in-spi-axi-spi-engine


class AD9675_spi():
    def __init__(self, spi) -> None:
        print("initiating SPI for AD9675")
        self.spi = spi

    def SPI_example_startup_sequence(self):
        '''
        Example startup sequence of datasheet pg 46
        '''
        flow = [
            [reg.CHIP_PORT_CONFIG, 0x3C],
            [reg.CHIP_GRADE, 0x00],
            [reg.DEVICE_UPDATE, 0x01],
            [reg.DEVICE_INDEX_2, 0x0F],
            [reg.DEVICE_INDEX_1, 0x3F],
            [reg.DIG_CONFIG, 0x00],
            [reg.FLEX_GAIN, 0x06],
            [0xF00, 0xFF],
            [0xF01, 0x7F],
            [0xF02, 0x00],
            [0xF03, 0x80],
            [reg.PROFILE_INDEX, 0x00],
            [reg.OUTPUT_MODE, 0X00],
            [reg.GLOBAL_MODES, 0x00],
            [reg.FLEX_SERIAL_CTRL, 0x12],
            [reg.SAMPLE_CLOCK_CONVERTER, 0x80],
            [reg.JTX_LINK_CTRL1, 0x04],
            [reg.START_CODE_EN, 0x01],
            [reg.START_CODE_MSB, 0x27],
            [reg.START_CODE_LSB, 0x72],
            [reg.JTX_SCR_L_CFG, 0x03],
            [reg.PLL_STARTUP, 0x82],
            [reg.JTX_CLK_CNTL_2, 0x02],
            [reg.DATA_VALID_RESYNC, 0xAA],
            [reg.PROFILE_INDEX, 0x20],
            [reg.FLEX_CHANNEL_INPUT, 0x18],
            [reg.FLEX_FILTER, 0x40]
        ]
        for i in flow:
            self.writeReg(i[0], i[1])

    def address_unique_AD(self, devid):
        chip_addr_en_val = (0x20 | (devid & 0x1F))
        self.writeReg(reg.CHIP_ADDR_EN, chip_addr_en_val)

    def address_all_AD(self):
        self.writeReg(reg.CHIP_ADDR_EN, 0x00)

    def readReg(self, regAddr):
        address = 0x00 | regAddr
        resp = self.spi.xfer2([address, 0x00])
        return resp[1]

    def writeReg(self, regAddr, value):
        self.spi.xfer2([regAddr, value])


def main():
    spi = spidev.SpiDev()
    spi.open(0, 0)
    devid = 0b00000
    adc = AD9675_spi(spi, devid)
    adc.SPI_example_startup_sequence()


if __name__ == '__main__':
    main()
