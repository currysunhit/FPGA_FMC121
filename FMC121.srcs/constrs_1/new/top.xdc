###################################################
set_property PACKAGE_PIN F33 [get_ports {rxp[7]}]
set_property PACKAGE_PIN H33 [get_ports {rxp[6]}]
set_property PACKAGE_PIN K33 [get_ports {rxp[5]}]
set_property PACKAGE_PIN L31 [get_ports {rxp[4]}]

# DP3_M2C_P
set_property PACKAGE_PIN B33 [get_ports {rxp[3]}]
# DP2_M2C_P
set_property PACKAGE_PIN C31 [get_ports {rxp[2]}]
# DP1_M2C_P
set_property PACKAGE_PIN D33 [get_ports {rxp[1]}]
# DP0_M2C_P
set_property PACKAGE_PIN E31 [get_ports {rxp[0]}]

## GBTCLK1_M2C_P
set_property PACKAGE_PIN L27  [get_ports ADgtx_refclk_p]
set_property PACKAGE_PIN L28  [get_ports ADgtx_refclk_n]
create_clock -period 8 -name jesd204_0_refclk [get_ports ADgtx_refclk_p]
# LA04_P
set_property PACKAGE_PIN L13  [get_ports rx_sync_p]
set_property PACKAGE_PIN K13  [get_ports rx_sync_n]
set_property IOSTANDARD LVDS [get_ports rx_sync_p]
set_property IOSTANDARD LVDS [get_ports rx_sync_n]


#LA13_P
set_property PACKAGE_PIN L16 [get_ports adc_sclk]
#LA13_N
set_property PACKAGE_PIN K16 [get_ports adc_sdio]
#LA06_P
set_property PACKAGE_PIN M11 [get_ports adc_sen]
#LA06_N
set_property PACKAGE_PIN L11 [get_ports AD1_DETA_ADJ]
#LA23_P
set_property PACKAGE_PIN W2 [get_ports AD1_DETB_ADJ]


set_property IOSTANDARD LVCMOS18 [get_ports adc_sclk]
set_property IOSTANDARD LVCMOS18 [get_ports adc_sen]
set_property IOSTANDARD LVCMOS18 [get_ports adc_sdio]
set_property IOSTANDARD LVCMOS18 [get_ports AD1_DETA_ADJ]
set_property IOSTANDARD LVCMOS18 [get_ports AD1_DETB_ADJ]



#CLK0_M2C_P H4/5 HMC4
set_property PACKAGE_PIN P10  [get_ports ADsysref_p]
set_property PACKAGE_PIN P9  [get_ports ADsysref_n]
#set_property PACKAGE_PIN F20  [get_ports ADsysref_p]   
#set_property PACKAGE_PIN E20  [get_ports ADsysref_n]
set_property IOSTANDARD LVDS [get_ports ADsysref_p]
set_property IOSTANDARD LVDS [get_ports ADsysref_n]
create_clock -period 160 -name ADsysref_p [get_ports ADsysref_p]
#LA18_P_CC   HMC_CLK6    
set_property PACKAGE_PIN Y8  [get_ports fmc_375mhz_p]
set_property PACKAGE_PIN Y7  [get_ports fmc_375mhz_n]
set_property IOSTANDARD LVDS [get_ports fmc_375mhz_p]
set_property IOSTANDARD LVDS [get_ports fmc_375mhz_n]
create_clock -period 4.000 -name fmc_375mhz_p [get_ports fmc_375mhz_p]


####################################################
set_property PACKAGE_PIN AP12 [get_ports LED_0]
set_property PACKAGE_PIN AM13 [get_ports LED_1]

set_property PACKAGE_PIN AN12 [get_ports rstin]

set_property IOSTANDARD LVCMOS18 [get_ports LED_0]
set_property IOSTANDARD LVCMOS18 [get_ports LED_1]

set_property IOSTANDARD LVCMOS18 [get_ports rstin]


set_property PACKAGE_PIN AL8  [get_ports PL_CLK0_P]
set_property PACKAGE_PIN AL7  [get_ports PL_CLK0_N]
set_property IOSTANDARD LVDS [get_ports PL_CLK0_P]
set_property IOSTANDARD LVDS [get_ports PL_CLK0_N]
create_clock -period 5 -name PL_CLK0_P [get_ports PL_CLK0_P]

########################################################################################################
#LA03_P
set_property PACKAGE_PIN L12 [get_ports h7044_slen_in]
# LA03_N
set_property PACKAGE_PIN K12 [get_ports h7044_sclkin]
# LA08_P
set_property PACKAGE_PIN M15 [get_ports h7044_sdata_in]
# LA08_N
set_property PACKAGE_PIN M14 [get_ports reset_h7044_h_in]
# LA26_P
set_property PACKAGE_PIN AC2 [get_ports h7044_sync_in]
# # LA10_N
set_property PACKAGE_PIN R12   [get_ports OSCON_CTRL] 


##VADJ_FMC_BUS DEFAULT = 1.80V
set_property IOSTANDARD LVCMOS18 [get_ports h7044_slen_in]
set_property IOSTANDARD LVCMOS18 [get_ports h7044_sclkin]
set_property IOSTANDARD LVCMOS18 [get_ports h7044_sdata_in]
set_property IOSTANDARD LVCMOS18 [get_ports h7044_sync_in]
set_property IOSTANDARD LVCMOS18 [get_ports reset_h7044_h_in]
set_property IOSTANDARD LVCMOS18 [get_ports OSCON_CTRL]


##########################################dac
#LA00_P_CC   HMC_CLK5
set_property PACKAGE_PIN T8 [get_ports tx_sysref_p]
set_property PACKAGE_PIN R8 [get_ports tx_sysref_n]
set_property IOSTANDARD LVDS [get_ports tx_sysref_p]
set_property IOSTANDARD LVDS [get_ports tx_sysref_n]

#DP7_C2M_P  118
set_property PACKAGE_PIN G31 [get_ports {txp[7]}]
#DP6_C2M_P
set_property PACKAGE_PIN H29 [get_ports {txp[6]}]
#DP5_C2M_P
set_property PACKAGE_PIN J31 [get_ports {txp[5]}]
#DP4_C2M_P
set_property PACKAGE_PIN K29 [get_ports {txp[4]}]
#DP3_C2M_P 117
set_property PACKAGE_PIN A31 [get_ports {txp[3]}]
#DP2_C2M_P
set_property PACKAGE_PIN B29 [get_ports {txp[2]}]
#DP1_C2M_P
set_property PACKAGE_PIN D29 [get_ports {txp[1]}]
#DP0_C2M_P
set_property PACKAGE_PIN F29 [get_ports {txp[0]}]
#LA02_P
set_property PACKAGE_PIN T7 [get_ports tx_syncp]
set_property PACKAGE_PIN T6 [get_ports tx_syncn]
set_property IOSTANDARD LVDS [get_ports tx_syncp]
set_property IOSTANDARD LVDS [get_ports tx_syncn]

# LA01_P_CC
#set_property PACKAGE_PIN P11 [get_ports DAC_SDENB]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_SDENB]
# LA01_N_CC
#set_property PACKAGE_PIN N11 [get_ports DAC_RESETB]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_RESETB]
# LA05_P
#set_property PACKAGE_PIN N13 [get_ports DAC_SDIO]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_SDIO]
# LA05_N
#set_property PACKAGE_PIN M13 [get_ports DAC_SCLK]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_SCLK]
# LA09_P
#set_property PACKAGE_PIN V8 [get_ports DAC_TXENABLE]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_TXENABLE]
# LA09_N
#set_property PACKAGE_PIN V7 [get_ports DAC_SDO]
#set_property IOSTANDARD LVCMOS18 [get_ports DAC_SDO]

#LA14_P
set_property PACKAGE_PIN P12 [get_ports trig_out]
set_property IOSTANDARD LVCMOS18 [get_ports trig_out]
#LA10_P
set_property PACKAGE_PIN T12 [get_ports trig_in]
set_property IOSTANDARD LVCMOS18 [get_ports trig_in]

set_property PACKAGE_PIN D10 [get_ports uart_txd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_txd]
set_property PACKAGE_PIN D11 [get_ports uart_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rxd]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
