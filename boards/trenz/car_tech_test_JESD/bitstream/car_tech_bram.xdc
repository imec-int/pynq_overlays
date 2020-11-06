
#System Controller IP

#J3:31 LED_HD
set_property PACKAGE_PIN K11 [get_ports BASE_sc0]
#J3:41
set_property PACKAGE_PIN E14 [get_ports BASE_sc5]
#J3:45
set_property PACKAGE_PIN C12 [get_ports BASE_sc6]
#J3:47
set_property PACKAGE_PIN D12 [get_ports BASE_sc7]
#J3:32
set_property PACKAGE_PIN J12 [get_ports BASE_sc10_io]
#J3:34
set_property PACKAGE_PIN K13 [get_ports BASE_sc11]
#J3:36
set_property PACKAGE_PIN A13 [get_ports BASE_sc12]
#J3:38
set_property PACKAGE_PIN A14 [get_ports BASE_sc13]
#J3:40
set_property PACKAGE_PIN E12 [get_ports BASE_sc14]
#J3:42
set_property PACKAGE_PIN F12 [get_ports BASE_sc15]
#J3:46 CAN S
set_property PACKAGE_PIN A12 [get_ports BASE_sc16]
#J3:48 LED_XMOD
set_property PACKAGE_PIN B12 [get_ports BASE_sc17]
#J3:50 CAN TX 
set_property PACKAGE_PIN B14 [get_ports BASE_sc18]
#J3:52 CAN RX 
set_property PACKAGE_PIN C14 [get_ports BASE_sc19]

set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc0]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc5]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc6]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc7]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc10_io]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc11]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc12]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc13]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc14]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc15]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc16]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc17]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc18]
set_property IOSTANDARD LVCMOS18 [get_ports BASE_sc19]

# PLL
#J4:74
#set_property PACKAGE_PIN AF15 [get_ports {si570_clk_p[0]}]
#set_property IOSTANDARD LVDS [get_ports {si570_clk_p[0]}]
#set_property IOSTANDARD LVDS [get_ports {si570_clk_n[0]}]



# Audio Codec
#LRCLK		J3:49 B47_L9_N
#BCLK		J3:51 B47_L9_P
#DAC_SDATA	J3:53 B47_L7_N
#ADC_SDATA	J3:55 B47_L7_P
set_property PACKAGE_PIN G14 [get_ports I2S_lrclk ]
set_property PACKAGE_PIN H14 [get_ports I2S_bclk ]
set_property PACKAGE_PIN C13 [get_ports I2S_sdin ]
set_property PACKAGE_PIN D14 [get_ports I2S_sdout ]
set_property IOSTANDARD LVCMOS18 [get_ports I2S_lrclk ]
set_property IOSTANDARD LVCMOS18 [get_ports I2S_bclk ]
set_property IOSTANDARD LVCMOS18 [get_ports I2S_sdin ]
set_property IOSTANDARD LVCMOS18 [get_ports I2S_sdout ]


# # MGT Lanes
# # Bank 224 - GTH
# # lane 0
# set_property PACKAGE_PIN V2 [get_ports B224_RX0_P]
# set_property PACKAGE_PIN V1 [get_ports B224_RX0_N]
# set_property PACKAGE_PIN W4 [get_ports B224_TX0_P]
# set_property PACKAGE_PIN W3 [get_ports B224_TX0_N]
# # lane 1
# set_property PACKAGE_PIN U4 [get_ports B224_RX1_P]
# set_property PACKAGE_PIN U3 [get_ports B224_RX1_N]
# set_property PACKAGE_PIN V6 [get_ports B224_TX1_P]
# set_property PACKAGE_PIN V5 [get_ports B224_TX1_N]
# # lane 2
# set_property PACKAGE_PIN T2 [get_ports B224_RX2_P]
# set_property PACKAGE_PIN T1 [get_ports B224_RX2_N]
# set_property PACKAGE_PIN T6 [get_ports B224_TX2_P]
# set_property PACKAGE_PIN T5 [get_ports B224_TX2_N]
# # lane 3
# set_property PACKAGE_PIN V2 [get_ports B224_RX3_P]
# set_property PACKAGE_PIN V1 [get_ports B224_RX3_N]
# set_property PACKAGE_PIN W4 [get_ports B224_TX3_P]
# set_property PACKAGE_PIN W3 [get_ports B224_TX3_N]
# #clocks
# set_property PACKAGE_PIN R8 [get_ports B224_CLK0_P]; # carrier board
# set_property PACKAGE_PIN R7 [get_ports B224_CLK0_N]; # carrier board
# set_property PACKAGE_PIN N8 [get_ports B224_CLK1_P]; # On-board Si5345A
# set_property PACKAGE_PIN N7 [get_ports B224_CLK1_N]; # On-board Si5345A
# # Bank 225 - GTH
# # lane 0
# set_property PACKAGE_PIN N4 [get_ports B225_RX0_P]
# set_property PACKAGE_PIN N3 [get_ports B225_RX0_N]
# set_property PACKAGE_PIN P6 [get_ports B225_TX0_P]
# set_property PACKAGE_PIN P5 [get_ports B225_TX0_N]
# # lane 1
# set_property PACKAGE_PIN M2 [get_ports B225_RX1_P]
# set_property PACKAGE_PIN M1 [get_ports B225_RX1_N]
# set_property PACKAGE_PIN M6 [get_ports B225_TX1_P]
# set_property PACKAGE_PIN M5 [get_ports B225_TX1_N]
# # lane 2
# set_property PACKAGE_PIN K2 [get_ports B225_RX2_P]
# set_property PACKAGE_PIN K1 [get_ports B225_RX2_N]
# set_property PACKAGE_PIN L4 [get_ports B225_TX2_P]
# set_property PACKAGE_PIN L3 [get_ports B225_TX2_N]
# # lane 3
# set_property PACKAGE_PIN J4 [get_ports B225_RX3_P]
# set_property PACKAGE_PIN J3 [get_ports B225_RX3_N]
# set_property PACKAGE_PIN K6 [get_ports B225_TX3_P]
# set_property PACKAGE_PIN K5 [get_ports B225_TX3_N]
# #clocks
# set_property PACKAGE_PIN L8 [get_ports B225_CLK0_P]; # carrier board
# set_property PACKAGE_PIN L7 [get_ports B225_CLK0_N]; # carrier board
# set_property PACKAGE_PIN J8 [get_ports B225_CLK1_P]; # On-board Si5345A
# set_property PACKAGE_PIN J7 [get_ports B225_CLK1_N]; # On-board Si5345A
# # Bank 226 - GTH
# # lane 0
# set_property PACKAGE_PIN H2 [get_ports B226_RX0_P]
# set_property PACKAGE_PIN H1 [get_ports B226_RX0_N]
# set_property PACKAGE_PIN H6 [get_ports B226_TX0_P]
# set_property PACKAGE_PIN H5 [get_ports B226_TX0_N]
# # lane 1
# set_property PACKAGE_PIN G4 [get_ports B226_RX1_P]
# set_property PACKAGE_PIN G3 [get_ports B226_RX1_N]
# set_property PACKAGE_PIN G8 [get_ports B226_TX1_P]
# set_property PACKAGE_PIN G7 [get_ports B226_TX1_N]
# # lane 2
# set_property PACKAGE_PIN F2 [get_ports B226_RX2_P]
# set_property PACKAGE_PIN F1 [get_ports B226_RX2_N]
# set_property PACKAGE_PIN F6 [get_ports B226_TX2_P]
# set_property PACKAGE_PIN F5 [get_ports B226_TX2_N]
# # lane 3
# set_property PACKAGE_PIN E4 [get_ports B226_RX3_P]
# set_property PACKAGE_PIN E3 [get_ports B226_RX3_N]
# set_property PACKAGE_PIN E8 [get_ports B226_TX3_P]
# set_property PACKAGE_PIN E7 [get_ports B226_TX3_N]
# #clocks
# set_property PACKAGE_PIN H10 [get_ports B226_CLK0_P]; # On-board Si5345A
# set_property PACKAGE_PIN H9 [get_ports B226_CLK0_N]; # On-board Si5345A
# set_property PACKAGE_PIN F10 [get_ports B226_CLK1_P]; # carrier board
# set_property PACKAGE_PIN F9 [get_ports B226_CLK1_N]; # carrier board
# # Bank 227 - GTH
# # lane 0
# set_property PACKAGE_PIN D5 [get_ports B227_RX0_P]
# set_property PACKAGE_PIN D6 [get_ports B227_RX0_N]
# set_property PACKAGE_PIN D1 [get_ports B227_TX0_P]
# set_property PACKAGE_PIN D2 [get_ports B227_TX0_N]
# # lane 1
# set_property PACKAGE_PIN C7 [get_ports B227_RX1_P]
# set_property PACKAGE_PIN C8 [get_ports B227_RX1_N]
# set_property PACKAGE_PIN C3 [get_ports B227_TX1_P]
# set_property PACKAGE_PIN C4 [get_ports B227_TX1_N]
# # lane 2
# set_property PACKAGE_PIN B5 [get_ports B227_RX2_P]
# set_property PACKAGE_PIN B6 [get_ports B227_RX2_N]
# set_property PACKAGE_PIN B1 [get_ports B227_TX2_P]
# set_property PACKAGE_PIN B2 [get_ports B227_TX2_N]
# # lane 3
# set_property PACKAGE_PIN A7 [get_ports B227_RX3_P]
# set_property PACKAGE_PIN A8 [get_ports B227_RX3_N]
# set_property PACKAGE_PIN A3 [get_ports B227_TX3_P]
# set_property PACKAGE_PIN A4 [get_ports B227_TX3_N]
# #clocks
# set_property PACKAGE_PIN D10 [get_ports B227_CLK0_P]; # On-board Si5345A
# set_property PACKAGE_PIN D9 [get_ports B227_CLK0_N]; # On-board Si5345A
# set_property PACKAGE_PIN B10 [get_ports B227_CLK1_P]; # carrier board
# set_property PACKAGE_PIN B9 [get_ports B227_CLK1_N]; # carrier board
# # Bank 505 - GTR
# # lane 0
# set_property PACKAGE_PIN L29 [get_ports B505_RX0_P]
# set_property PACKAGE_PIN L30 [get_ports B505_RX0_N]
# set_property PACKAGE_PIN M27 [get_ports B505_TX0_P]
# set_property PACKAGE_PIN M28 [get_ports B505_TX0_N]
# # lane 1
# set_property PACKAGE_PIN J29 [get_ports B505_RX1_P]
# set_property PACKAGE_PIN J30 [get_ports B505_RX1_N]
# set_property PACKAGE_PIN K27 [get_ports B505_TX1_P]
# set_property PACKAGE_PIN K28 [get_ports B505_TX1_N]
# # lane 2
# set_property PACKAGE_PIN H27 [get_ports B505_RX2_P]
# set_property PACKAGE_PIN H28 [get_ports B505_RX2_N]
# set_property PACKAGE_PIN J25 [get_ports B505_TX2_P]
# set_property PACKAGE_PIN J26 [get_ports B505_TX2_N]
# # lane 3
# set_property PACKAGE_PIN G29 [get_ports B505_RX3_P]
# set_property PACKAGE_PIN G30 [get_ports B505_RX3_N]
# set_property PACKAGE_PIN G25 [get_ports B505_TX3_P]
# set_property PACKAGE_PIN G26 [get_ports B505_TX3_N]
# #clocks
# set_property PACKAGE_PIN M23 [get_ports B505_CLK0_P]; # carrier board
# set_property PACKAGE_PIN M24 [get_ports B505_CLK0_N]; # carrier board
# set_property PACKAGE_PIN L25 [get_ports B505_CLK1_P]; # carrier board
# set_property PACKAGE_PIN L26 [get_ports B505_CLK1_N]; # carrier board
# set_property PACKAGE_PIN K23 [get_ports B505_CLK2_P]; # On-board Si5345A
# set_property PACKAGE_PIN K24 [get_ports B505_CLK2_N]; # On-board Si5345A
# set_property PACKAGE_PIN H23 [get_ports B505_CLK3_P]; # On-board Si5345A
# set_property PACKAGE_PIN H24 [get_ports B505_CLK3_N]; # On-board Si5345A

