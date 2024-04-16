-- (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:jesd204_phy:4.0
-- IP Revision: 4

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT jesd204_phy_0
  PORT (
    cpll_refclk : IN STD_LOGIC;
    qpll0_refclk : IN STD_LOGIC;
    drpclk : IN STD_LOGIC;
    tx_reset_gt : IN STD_LOGIC;
    rx_reset_gt : IN STD_LOGIC;
    tx_sys_reset : IN STD_LOGIC;
    rx_sys_reset : IN STD_LOGIC;
    txp_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    txn_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rxp_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    rxn_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    tx_core_clk : IN STD_LOGIC;
    rx_core_clk : IN STD_LOGIC;
    txoutclk : OUT STD_LOGIC;
    rxoutclk : OUT STD_LOGIC;
    gt_prbssel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt0_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt0_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt1_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt1_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt2_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt2_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt3_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt3_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt4_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt4_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt5_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt5_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt6_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt6_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt7_txdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt7_txcharisk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tx_reset_done : OUT STD_LOGIC;
    gt_powergood : OUT STD_LOGIC;
    gt0_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt0_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt0_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt0_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt1_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt1_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt1_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt1_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt2_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt2_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt2_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt2_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt3_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt3_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt3_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt3_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt4_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt4_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt4_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt4_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt5_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt5_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt5_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt5_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt6_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt6_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt6_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt6_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt7_rxdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    gt7_rxcharisk : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt7_rxdisperr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt7_rxnotintable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rx_reset_done : OUT STD_LOGIC;
    rxencommaalign : IN STD_LOGIC;
    common0_qpll0_clk_out : OUT STD_LOGIC;
    common0_qpll0_refclk_out : OUT STD_LOGIC;
    common0_qpll0_lock_out : OUT STD_LOGIC;
    common1_qpll0_clk_out : OUT STD_LOGIC;
    common1_qpll0_refclk_out : OUT STD_LOGIC;
    common1_qpll0_lock_out : OUT STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : jesd204_phy_0
  PORT MAP (
    cpll_refclk => cpll_refclk,
    qpll0_refclk => qpll0_refclk,
    drpclk => drpclk,
    tx_reset_gt => tx_reset_gt,
    rx_reset_gt => rx_reset_gt,
    tx_sys_reset => tx_sys_reset,
    rx_sys_reset => rx_sys_reset,
    txp_out => txp_out,
    txn_out => txn_out,
    rxp_in => rxp_in,
    rxn_in => rxn_in,
    tx_core_clk => tx_core_clk,
    rx_core_clk => rx_core_clk,
    txoutclk => txoutclk,
    rxoutclk => rxoutclk,
    gt_prbssel => gt_prbssel,
    gt0_txdata => gt0_txdata,
    gt0_txcharisk => gt0_txcharisk,
    gt1_txdata => gt1_txdata,
    gt1_txcharisk => gt1_txcharisk,
    gt2_txdata => gt2_txdata,
    gt2_txcharisk => gt2_txcharisk,
    gt3_txdata => gt3_txdata,
    gt3_txcharisk => gt3_txcharisk,
    gt4_txdata => gt4_txdata,
    gt4_txcharisk => gt4_txcharisk,
    gt5_txdata => gt5_txdata,
    gt5_txcharisk => gt5_txcharisk,
    gt6_txdata => gt6_txdata,
    gt6_txcharisk => gt6_txcharisk,
    gt7_txdata => gt7_txdata,
    gt7_txcharisk => gt7_txcharisk,
    tx_reset_done => tx_reset_done,
    gt_powergood => gt_powergood,
    gt0_rxdata => gt0_rxdata,
    gt0_rxcharisk => gt0_rxcharisk,
    gt0_rxdisperr => gt0_rxdisperr,
    gt0_rxnotintable => gt0_rxnotintable,
    gt1_rxdata => gt1_rxdata,
    gt1_rxcharisk => gt1_rxcharisk,
    gt1_rxdisperr => gt1_rxdisperr,
    gt1_rxnotintable => gt1_rxnotintable,
    gt2_rxdata => gt2_rxdata,
    gt2_rxcharisk => gt2_rxcharisk,
    gt2_rxdisperr => gt2_rxdisperr,
    gt2_rxnotintable => gt2_rxnotintable,
    gt3_rxdata => gt3_rxdata,
    gt3_rxcharisk => gt3_rxcharisk,
    gt3_rxdisperr => gt3_rxdisperr,
    gt3_rxnotintable => gt3_rxnotintable,
    gt4_rxdata => gt4_rxdata,
    gt4_rxcharisk => gt4_rxcharisk,
    gt4_rxdisperr => gt4_rxdisperr,
    gt4_rxnotintable => gt4_rxnotintable,
    gt5_rxdata => gt5_rxdata,
    gt5_rxcharisk => gt5_rxcharisk,
    gt5_rxdisperr => gt5_rxdisperr,
    gt5_rxnotintable => gt5_rxnotintable,
    gt6_rxdata => gt6_rxdata,
    gt6_rxcharisk => gt6_rxcharisk,
    gt6_rxdisperr => gt6_rxdisperr,
    gt6_rxnotintable => gt6_rxnotintable,
    gt7_rxdata => gt7_rxdata,
    gt7_rxcharisk => gt7_rxcharisk,
    gt7_rxdisperr => gt7_rxdisperr,
    gt7_rxnotintable => gt7_rxnotintable,
    rx_reset_done => rx_reset_done,
    rxencommaalign => rxencommaalign,
    common0_qpll0_clk_out => common0_qpll0_clk_out,
    common0_qpll0_refclk_out => common0_qpll0_refclk_out,
    common0_qpll0_lock_out => common0_qpll0_lock_out,
    common1_qpll0_clk_out => common1_qpll0_clk_out,
    common1_qpll0_refclk_out => common1_qpll0_refclk_out,
    common1_qpll0_lock_out => common1_qpll0_lock_out
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file jesd204_phy_0.vhd when simulating
-- the core, jesd204_phy_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

