-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Fri Feb 17 10:37:08 2023
-- Host        : DESKTOP-WORK-MY running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top jesd204_phy_0 -prefix
--               jesd204_phy_0_ jesd204_phy_0_stub.vhdl
-- Design      : jesd204_phy_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu15eg-ffvb1156-2-i
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jesd204_phy_0 is
  Port ( 
    tx_sys_reset : in STD_LOGIC;
    rx_sys_reset : in STD_LOGIC;
    tx_reset_gt : in STD_LOGIC;
    rx_reset_gt : in STD_LOGIC;
    tx_reset_done : out STD_LOGIC;
    rx_reset_done : out STD_LOGIC;
    gt_powergood : out STD_LOGIC;
    cpll_refclk : in STD_LOGIC;
    qpll0_refclk : in STD_LOGIC;
    common0_qpll0_lock_out : out STD_LOGIC;
    common0_qpll0_refclk_out : out STD_LOGIC;
    common0_qpll0_clk_out : out STD_LOGIC;
    common1_qpll0_lock_out : out STD_LOGIC;
    common1_qpll0_refclk_out : out STD_LOGIC;
    common1_qpll0_clk_out : out STD_LOGIC;
    rxencommaalign : in STD_LOGIC;
    tx_core_clk : in STD_LOGIC;
    txoutclk : out STD_LOGIC;
    rx_core_clk : in STD_LOGIC;
    rxoutclk : out STD_LOGIC;
    drpclk : in STD_LOGIC;
    gt_prbssel : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt4_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt5_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt6_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt6_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt7_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt7_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt4_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt5_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt6_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt6_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt6_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt6_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt7_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt7_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt7_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt7_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rxn_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rxp_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    txn_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    txp_out : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end jesd204_phy_0;

architecture stub of jesd204_phy_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "tx_sys_reset,rx_sys_reset,tx_reset_gt,rx_reset_gt,tx_reset_done,rx_reset_done,gt_powergood,cpll_refclk,qpll0_refclk,common0_qpll0_lock_out,common0_qpll0_refclk_out,common0_qpll0_clk_out,common1_qpll0_lock_out,common1_qpll0_refclk_out,common1_qpll0_clk_out,rxencommaalign,tx_core_clk,txoutclk,rx_core_clk,rxoutclk,drpclk,gt_prbssel[3:0],gt0_txcharisk[3:0],gt0_txdata[31:0],gt1_txcharisk[3:0],gt1_txdata[31:0],gt2_txcharisk[3:0],gt2_txdata[31:0],gt3_txcharisk[3:0],gt3_txdata[31:0],gt4_txcharisk[3:0],gt4_txdata[31:0],gt5_txcharisk[3:0],gt5_txdata[31:0],gt6_txcharisk[3:0],gt6_txdata[31:0],gt7_txcharisk[3:0],gt7_txdata[31:0],gt0_rxcharisk[3:0],gt0_rxdisperr[3:0],gt0_rxnotintable[3:0],gt0_rxdata[31:0],gt1_rxcharisk[3:0],gt1_rxdisperr[3:0],gt1_rxnotintable[3:0],gt1_rxdata[31:0],gt2_rxcharisk[3:0],gt2_rxdisperr[3:0],gt2_rxnotintable[3:0],gt2_rxdata[31:0],gt3_rxcharisk[3:0],gt3_rxdisperr[3:0],gt3_rxnotintable[3:0],gt3_rxdata[31:0],gt4_rxcharisk[3:0],gt4_rxdisperr[3:0],gt4_rxnotintable[3:0],gt4_rxdata[31:0],gt5_rxcharisk[3:0],gt5_rxdisperr[3:0],gt5_rxnotintable[3:0],gt5_rxdata[31:0],gt6_rxcharisk[3:0],gt6_rxdisperr[3:0],gt6_rxnotintable[3:0],gt6_rxdata[31:0],gt7_rxcharisk[3:0],gt7_rxdisperr[3:0],gt7_rxnotintable[3:0],gt7_rxdata[31:0],rxn_in[7:0],rxp_in[7:0],txn_out[7:0],txp_out[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "jesd204_phy_v4_0_4,Vivado 2018.3";
begin
end;
