--上电，复位时钟芯片，延迟等待芯片复位完毕，开始配置时钟；
--时钟配置完，JESD204释放复位开始工作，开始复位DAC，配置；
--DAC配完发送sync给FPGA同步（FPGA必须提前准备好，才能接收到sync'）
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fmc121_top is
port(
	rstinP				    : in STD_LOGIC;
	clk_100m                : in STD_LOGIC;
	TRIG_RST                : in STD_LOGIC;
    clk_10m                 : in STD_LOGIC;
    	
    
    --------------------------
     h7044_slen_in			: out STD_LOGIC;  --d14
     h7044_sclkin			: out STD_LOGIC; --d15
     h7044_sdata_in			: out STD_LOGIC;  --d17
     h7044_sync_in			: out STD_LOGIC;  --20
     reset_h7044_h_in		: out STD_LOGIC; --d18
     OSCON_CTRL     	    : out STD_LOGIC;
--     fpga_clk_sel         : in STD_LOGIC;
--     clk_sel              : in STD_LOGIC;
--     vco_sel              : in STD_LOGIC;
    clk_sel                 : IN	STD_LOGIC_VECTOR(1 downto 0);
---------------------adc--------------------------
	ADgtx_refclk_p			: in STD_LOGIC;
	ADgtx_refclk_n			: in STD_LOGIC;
	rxp				        : IN STD_LOGIC_VECTOR(7 downto 0);
	rxn				        : IN STD_LOGIC_VECTOR(7 downto 0);
	fmc_375mhz_p            : in STD_LOGIC;
    fmc_375mhz_n            : in STD_LOGIC;
    rx_sync_p			    : out STD_LOGIC;
    rx_sync_n			    : out STD_LOGIC;
     adc_sclk               : out STD_LOGIC;--c14
     adc_sen                : out STD_LOGIC;--c15
     adc_sdio               : inout STD_LOGIC;--c18
	ADsysref_p              : in STD_LOGIC;
	ADsysref_n              : in STD_LOGIC;     
	--------------------------------------adc2
	
	core_clk_in             : in STD_LOGIC;
	rx_core_clkout          : out STD_LOGIC;
	--tx_core_clkout        : out STD_LOGIC;
	core_clk_sel            : in STD_LOGIC;
	
	AD1_Data_out0           : out STD_LOGIC_VECTOR(15 downto 0);
	AD1_Data_out1           : out STD_LOGIC_VECTOR(15 downto 0);
	AD1_Data_out2           : out STD_LOGIC_VECTOR(15 downto 0);
	AD1_Data_out3           : out STD_LOGIC_VECTOR(15 downto 0);
                              
	AD2_Data_out0           : out STD_LOGIC_VECTOR(15 downto 0);
	AD2_Data_out1           : out STD_LOGIC_VECTOR(15 downto 0);
	AD2_Data_out2           : out STD_LOGIC_VECTOR(15 downto 0);
	AD2_Data_out3           : out STD_LOGIC_VECTOR(15 downto 0);
	
	TRIG_IN                 : in STD_LOGIC;
----------------------led---------------------------
LED_0                       : OUT STD_LOGIC;
LED_1                       : OUT STD_LOGIC;
LED_2                       : OUT STD_LOGIC;
LED_3                       : OUT STD_LOGIC
);	                          
end ;
architecture behaviour of fmc121_top is 

--component ila_1 is
--port (
  --clk : in STD_LOGIC;
  --probe0 : in STD_LOGIC_VECTOR ( 255 downto 0 )
--);
--end component ;

--component ila_2 is
--port (
  --clk : in STD_LOGIC;
  --probe0 : in STD_LOGIC_VECTOR ( 255 downto 0 )
--);
--end component ;

--component diff_clock is
--port (
  --clk_in1_p : in STD_LOGIC;
  --clk_in1_n : in STD_LOGIC;
  --reset : in STD_LOGIC;
  --clk_out1 : out STD_LOGIC;
  --clk_out2 : out STD_LOGIC;
  --clk_out3 : out STD_LOGIC;
  --locked : out STD_LOGIC
--);
--end component ;
--component diff_clock2 is
--port (
  --clk_in1_p : in STD_LOGIC;
  --clk_in1_n : in STD_LOGIC;
  --reset : in STD_LOGIC;
  --clk_out1 : out STD_LOGIC;
  --clk_out2 : out STD_LOGIC;
  --clk_out3 : out STD_LOGIC;
  --locked : out STD_LOGIC
--);
--end component ;


component neg_data is
port (
  data_in                   : in STD_LOGIC_VECTOR ( 63 downto 0 );
  data_out                  : out  STD_LOGIC_VECTOR ( 63 downto 0 )
);
end component ;


component sysclk is
port (
clk_in1                     : in STD_LOGIC;
reset                       : in STD_LOGIC;
clk_out1                    : out STD_LOGIC;
clk_out2                    : out STD_LOGIC;
clk_out3                    : out STD_LOGIC;
clk_out4                    : out STD_LOGIC;
locked                      : out STD_LOGIC
);
end component ;
component ad9680 is
port(
clk                         : IN	STD_LOGIC;
rstn                        : IN	STD_LOGIC;
ad_slen                     : OUT	STD_LOGIC;
ad_sclk                     : OUT	STD_LOGIC;
ad_set_finish               : OUT	STD_LOGIC;
ad_sdata                    : INOUT	STD_LOGIC;
dir_test                    : OUT	STD_LOGIC;
ad_sdout                    : OUT	STD_LOGIC;
adc_sdio_test               : OUT	STD_LOGIC
);	
end component;
component jesd204b_ad is
port (
  rx_reset                  : in STD_LOGIC;
  rx_core_clk               : in STD_LOGIC;
  rx_aresetn                : out STD_LOGIC;
  rx_start_of_frame         : out STD_LOGIC_VECTOR ( 3 downto 0 );
  rx_end_of_frame           : out STD_LOGIC_VECTOR ( 3 downto 0 );
  rx_start_of_multiframe    : out STD_LOGIC_VECTOR ( 3 downto 0 );
  rx_end_of_multiframe      : out STD_LOGIC_VECTOR ( 3 downto 0 );
  rx_frame_error            : out STD_LOGIC_VECTOR ( 15 downto 0 );
  rx_sync                   : out STD_LOGIC;
  s_axi_aclk                : in STD_LOGIC;
  s_axi_aresetn             : in STD_LOGIC;

  rx_sysref                 : in STD_LOGIC;
  rx_tdata                  : out STD_LOGIC_VECTOR ( 127 downto 0 );
  rx_tvalid                 : out STD_LOGIC;
  s_axi_araddr              : in STD_LOGIC_VECTOR ( 11 downto 0 );
  s_axi_arready             : out STD_LOGIC;
  s_axi_arvalid             : in STD_LOGIC;
  s_axi_awaddr              : in STD_LOGIC_VECTOR ( 11 downto 0 );
  s_axi_awready             : out STD_LOGIC;
  s_axi_awvalid             : in STD_LOGIC;
  s_axi_bready              : in STD_LOGIC;
  s_axi_bresp               : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_bvalid              : out STD_LOGIC;
  s_axi_rdata               : out STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_rready              : in STD_LOGIC;
  s_axi_rresp               : out STD_LOGIC_VECTOR ( 1 downto 0 );
  s_axi_rvalid              : out STD_LOGIC;
  s_axi_wdata               : in STD_LOGIC_VECTOR ( 31 downto 0 );
  s_axi_wready              : out STD_LOGIC;
  s_axi_wstrb               : in STD_LOGIC_VECTOR ( 3 downto 0 );
  s_axi_wvalid              : in STD_LOGIC;
  -------------------------------------------------------------GT
  rx_reset_gt               : out STD_LOGIC;
  rxencommaalign_out        : out STD_LOGIC;
  rx_reset_done             : in STD_LOGIC;
  gt0_rxdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt0_rxcharisk             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt0_rxdisperr             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt0_rxnotintable          : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt1_rxcharisk             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxdisperr             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxnotintable          : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt2_rxcharisk             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxdisperr             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxnotintable          : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt3_rxdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt3_rxcharisk             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt3_rxdisperr             : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt3_rxnotintable          : in STD_LOGIC_VECTOR ( 3 downto 0 )
--  gt4_rxdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
--  gt4_rxcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt4_rxdisperr : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt4_rxnotintable : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt5_rxdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
--  gt5_rxcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt5_rxdisperr : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt5_rxnotintable : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt6_rxdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
--  gt6_rxcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt6_rxdisperr : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt6_rxnotintable : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt7_rxdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
--  gt7_rxcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt7_rxdisperr : in STD_LOGIC_VECTOR ( 3 downto 0 );
--  gt7_rxnotintable : in STD_LOGIC_VECTOR ( 3 downto 0 )
);
end component jesd204b_ad;

component hmc7044 is
port(
clk                         : IN STD_LOGIC;
rst                         : IN STD_LOGIC;
--clk_sel : 	IN	STD_LOGIC;
--vco_sel : 	IN	STD_LOGIC;
--fpga_clk_sel : 	IN	STD_LOGIC;
clk_sel                     : IN STD_LOGIC_VECTOR(1 downto 0);
OSCON_CTRL                  : OUT STD_LOGIC;
H7044_SLEN                  : OUT STD_LOGIC;
H7044_SCLK                  : OUT STD_LOGIC;
H7044_SDATA                 : OUT STD_LOGIC;
SET_FINISH                  : OUT STD_LOGIC
);
end component ;

component jesd204_phy_0 is
port (
  tx_sys_reset              : in STD_LOGIC;
  rx_sys_reset              : in STD_LOGIC;
  tx_reset_gt               : in STD_LOGIC;  
  rx_reset_gt               : in STD_LOGIC;
  tx_reset_done             : out STD_LOGIC;  
  rx_reset_done             : out STD_LOGIC;
  cpll_refclk               : in STD_LOGIC;  
  qpll0_refclk              : in STD_LOGIC;
  rxencommaalign            : in STD_LOGIC;
  tx_core_clk               : in STD_LOGIC;
  txoutclk                  : out STD_LOGIC; 
  rx_core_clk               : in STD_LOGIC; 
  rxoutclk                  : out STD_LOGIC; 
  drpclk                    : in STD_LOGIC;   
  gt_prbssel                : in STD_LOGIC_VECTOR ( 3 downto 0 );
  gt_powergood              : out STD_LOGIC;
  gt0_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt0_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt1_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt1_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt2_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt2_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );    
  gt3_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt3_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt4_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt4_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt5_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt5_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt6_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt6_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  gt7_txdata                : in STD_LOGIC_VECTOR ( 31 downto 0 );
  gt7_txcharisk             : in STD_LOGIC_VECTOR (3 downto 0 );  
  
  gt0_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt0_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt0_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt0_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt1_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt1_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt2_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt2_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );  
  gt3_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt3_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt3_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt3_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );    
  gt4_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt4_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt4_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt4_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );    
  gt5_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt5_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt5_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt5_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );     
  gt6_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt6_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt6_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt6_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );      
  gt7_rxdata                : out STD_LOGIC_VECTOR ( 31 downto 0 );
  gt7_rxcharisk             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt7_rxdisperr             : out STD_LOGIC_VECTOR ( 3 downto 0 );
  gt7_rxnotintable          : out STD_LOGIC_VECTOR ( 3 downto 0 );      
     
  rxn_in                    : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
  rxp_in                    : in STD_LOGIC_VECTOR ( 7 downto 0 );              
  txn_out                   : out STD_LOGIC_VECTOR ( 7 downto 0 );         
  txp_out                   : out STD_LOGIC_VECTOR ( 7 downto 0 )         
);
end component ;



component vio_0 is
port (
clk                         : in STD_LOGIC;
probe_out0                  : out STD_LOGIC_VECTOR ( 51 downto 0 )
);
end component ;

component jesd204_dac_clocking IS
port(
     refclk_pad_n           : in STD_LOGIC;
     refclk_pad_p           : in STD_LOGIC;
     glblclk_pad_n          : in STD_LOGIC;
     glblclk_pad_p          : in STD_LOGIC;
     refclk                 : out STD_LOGIC;
     gt_pg                  : in STD_LOGIC;  
     coreclk2               : out STD_LOGIC;
     coreclk                : out STD_LOGIC
);
end component ;


signal   rx_sync_W_p          :STD_LOGIC;
signal   rx_sync_W_n          :STD_LOGIC;
                              
signal cpll_refclk2           : STD_LOGIC;
signal rst                    : STD_LOGIC;
signal s_axi_aresetn          : STD_LOGIC;
signal s_axi_awaddr           : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal s_axi_awvalid          : STD_LOGIC;
signal s_axi_awready          : STD_LOGIC;
signal s_axi_wdata            : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_axi_wstrb            : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal s_axi_wvalid           : STD_LOGIC;
signal s_axi_wready           : STD_LOGIC;
signal s_axi_bresp            : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal s_axi_bvalid           : STD_LOGIC;
signal s_axi_bready           : STD_LOGIC;
signal s_axi_araddr           : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal s_axi_arvalid          : STD_LOGIC;
signal s_axi_arready          : STD_LOGIC;
signal s_axi_rdata            : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_axi_rresp            : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal s_axi_rvalid           : STD_LOGIC;
signal s_axi_rready           : STD_LOGIC;
signal tx_reset               : STD_LOGIC;
signal tx_aresetn             : STD_LOGIC;
signal tx_tdata               : STD_LOGIC_VECTOR(255 DOWNTO 0);
signal tx_tready              : STD_LOGIC;
signal tx_start_of_frame      : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tx_end_of_frame        : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tx_start_of_multiframe : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tx_end_of_multiframe   : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tx_frame_error         : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tx_sysref              : STD_LOGIC;
signal dajesd204_tx_reset     : STD_LOGIC;
signal tx_core_clk_out        : std_logic;
signal tx_sync                : std_logic;
signal rst_count              : std_logic_vector(31 downto 0); 


signal rx_reset               : STD_LOGIC;
signal rx_aresetn             : STD_LOGIC;
signal rx_tdata               : STD_LOGIC_VECTOR(127 DOWNTO 0);
signal rx_tdata_s             : STD_LOGIC_VECTOR(127 DOWNTO 0);
signal rx_tvalid              : STD_LOGIC;
signal rx_start_of_frame      : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_end_of_frame        : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_start_of_multiframe : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_end_of_multiframe   : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_frame_error         : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal rx_sysref              : STD_LOGIC;
signal rx_core_clk_out        : std_logic;

signal AD1_Data_1             : std_logic_vector(15 downto 0); 
signal AD1_Data_2             : std_logic_vector(15 downto 0); 
signal AD1_Data_3             : std_logic_vector(15 downto 0); 
signal AD1_Data_4             : std_logic_vector(15 downto 0); 
signal AD1_Data_5             : std_logic_vector(15 downto 0); 
signal AD1_Data_6             : std_logic_vector(15 downto 0); 
signal AD1_Data_7             : std_logic_vector(15 downto 0); 
signal AD1_Data_8             : std_logic_vector(15 downto 0); 
                              
signal AD2_Data_1             : std_logic_vector(15 downto 0); 
signal AD2_Data_2             : std_logic_vector(15 downto 0); 
signal AD2_Data_3             : std_logic_vector(15 downto 0); 
signal AD2_Data_4             : std_logic_vector(15 downto 0); 
signal AD2_Data_5             : std_logic_vector(15 downto 0); 
signal AD2_Data_6             : std_logic_vector(15 downto 0); 
signal AD2_Data_7             : std_logic_vector(15 downto 0); 
signal AD2_Data_8             : std_logic_vector(15 downto 0); 
signal rst_count2             : std_logic_vector(31 downto 0); 
signal countdelay             : std_logic_vector(31 downto 0); 
signal rx_reset_delay         : std_logic;  
signal delay_count            : std_logic_vector(31 downto 0); 

signal rst_ad                 : std_logic;  
signal rst_out                : std_logic;  
signal ad_config_finish       : std_logic; 
signal data_res               : std_logic_vector(15 downto 0); 
signal rx_sync_W              : std_logic; 
signal adc_sclk_W             : std_logic;
signal adc_sen_W              : std_logic; 
signal ad_sdout               : std_logic;
signal dir_test               : std_logic;
signal adc_sdio_test          : std_logic;
signal ADsysref               : std_logic;


signal sys_clk_50m_bg         : std_logic;
signal clk_50m                : std_logic;
signal clk_CFG                : std_logic;
--signal clk_100m :std_logic;   
signal clk_200m               : std_logic;
signal clk_125m               : std_logic;
signal fmc_clk50m             : std_logic;
signal fmc_clk100m            : std_logic;
signal fmc_clk125m            : std_logic;
signal clk_locked             : std_logic;
signal led_buf                : std_logic;
signal ledcount               : std_logic_vector(31 downto 0); 
signal sysrst_delay           : std_logic;  
signal sysrst_countdelay      : std_logic_vector(31 downto 0); 
--复位流程
signal rst_dac_chip           : std_logic;  
signal rst_dac_config         : std_logic;  
signal rst_cnt                : std_logic_vector(31 downto 0); 
                              


signal DAC_SDENB_signal       : std_logic;  
signal DAC_SCLK_signal        : std_logic;  
signal DAconfig_finish        : std_logic;  
signal DAC_SDIO_signal        : std_logic;  
signal DAC_SDO_signal         : std_logic;  
signal DAconfig_finishn       : std_logic;  
--signal    tx_tdata_data : std_logic_vector(255 downto 0); 
signal DAOUT_ADCIN            :std_logic;  


signal probe0                 : std_logic_vector(255 downto 0); 

signal clk_set_finish         : std_logic; 
  
signal common0_qpll0_lock_out   : std_logic; 
signal common0_qpll0_refclk_out : std_logic; 
signal common0_qpll0_clk_out    : std_logic; 
signal common1_qpll0_lock_out   : std_logic; 
signal common1_qpll0_refclk_out : std_logic; 
signal common1_qpll0_clk_out    : std_logic; 

--signal TRIG_RST:std_logic; 

------------------
signal JESD204_rst              : STD_LOGIC;
signal rx_reset_gt              : STD_LOGIC;
signal rxencommaalign_out       : STD_LOGIC;
signal rx_reset_done            : STD_LOGIC;  
signal gt0_rxdata               : std_logic_vector(31 downto 0); 
signal gt0_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt0_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt0_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt1_rxdata               : std_logic_vector(31 downto 0); 
signal gt1_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt1_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt1_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt2_rxdata               : std_logic_vector(31 downto 0); 
signal gt2_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt2_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt2_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt3_rxdata               : std_logic_vector(31 downto 0); 
signal gt3_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt3_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt3_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt4_rxdata               : std_logic_vector(31 downto 0); 
signal gt4_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt4_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt4_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt5_rxdata               : std_logic_vector(31 downto 0); 
signal gt5_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt5_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt5_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt6_rxdata               : std_logic_vector(31 downto 0); 
signal gt6_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt6_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt6_rxnotintable         : std_logic_vector(3 downto 0); 
signal gt7_rxdata               : std_logic_vector(31 downto 0); 
signal gt7_rxcharisk            : std_logic_vector(3 downto 0); 
signal gt7_rxdisperr            : std_logic_vector(3 downto 0); 
signal gt7_rxnotintable         : std_logic_vector(3 downto 0); 

signal tx_reset_gt              : STD_LOGIC;
signal tx_reset_done            : STD_LOGIC;
signal gt0_txdata               : std_logic_vector(31 downto 0); 
signal gt0_txcharisk            : std_logic_vector(3 downto 0); 
signal gt1_txdata               : std_logic_vector(31 downto 0); 
signal gt1_txcharisk            : std_logic_vector(3 downto 0); 
signal gt2_txdata               : std_logic_vector(31 downto 0); 
signal gt2_txcharisk            : std_logic_vector(3 downto 0); 
signal gt3_txdata               : std_logic_vector(31 downto 0); 
signal gt3_txcharisk            : std_logic_vector(3 downto 0); 
signal gt4_txdata               : std_logic_vector(31 downto 0); 
signal gt4_txcharisk            : std_logic_vector(3 downto 0); 
signal gt5_txdata               : std_logic_vector(31 downto 0); 
signal gt5_txcharisk            : std_logic_vector(3 downto 0); 
signal gt6_txdata               : std_logic_vector(31 downto 0); 
signal gt6_txcharisk            : std_logic_vector(3 downto 0); 
signal gt7_txdata               : std_logic_vector(31 downto 0); 
signal gt7_txcharisk            : std_logic_vector(3 downto 0); 
signal gt_prbssel_out           : std_logic_vector(3 downto 0);
signal gt_powergood             : STD_LOGIC; 

signal rxoutclk                 : STD_LOGIC;
signal txoutclk                 : STD_LOGIC;
signal cpll_refclk              : STD_LOGIC;
signal cpll_refclk1             : STD_LOGIC;
signal rstin                    : STD_LOGIC;
--///////////////////////////////////////////////////////////AD2
-- tx_reset_done2 rx_reset_done2 rxencommaalign_out2 txoutclk2 rxoutclk2 gt_prbssel_out2
--rx_tdata2 rx_tvalid2 rx_start_of_frame2 rx_end_of_frame2 rx_start_of_multiframe2 rx_end_of_multiframe2 rx_frame_error2 rx_sync_W2  rx_reset_gt2 rxencommaalign_out2 rx_reset_done2
signal rx_reset_gt2             : STD_LOGIC;
signal tx_reset_done2           : STD_LOGIC;
signal rxencommaalign_out2      : STD_LOGIC;
signal rx_reset_done2           : STD_LOGIC;  
signal txoutclk2                : STD_LOGIC;
signal rxoutclk2                : STD_LOGIC;  
signal gt_prbssel_out2          : std_logic_vector(3 downto 0); 
signal rx_tdata2                : STD_LOGIC_VECTOR(127 DOWNTO 0);
signal rx_tdata_s2              : STD_LOGIC_VECTOR(127 DOWNTO 0);
signal rx_tvalid2               : STD_LOGIC;
signal rx_start_of_frame2       : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_end_of_frame2         : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_start_of_multiframe2  : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_end_of_multiframe2    : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal rx_frame_error2          : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal AD3_Data_1               : std_logic_vector(15 downto 0); 
signal AD3_Data_2               : std_logic_vector(15 downto 0); 
signal AD3_Data_3               : std_logic_vector(15 downto 0); 
signal AD3_Data_4               : std_logic_vector(15 downto 0); 
signal AD3_Data_5               : std_logic_vector(15 downto 0); 
signal AD3_Data_6               : std_logic_vector(15 downto 0); 
signal AD3_Data_7               : std_logic_vector(15 downto 0); 
signal AD3_Data_8               : std_logic_vector(15 downto 0); 
signal AD4_Data_1               : std_logic_vector(15 downto 0); 
signal AD4_Data_2               : std_logic_vector(15 downto 0); 
signal AD4_Data_3               : std_logic_vector(15 downto 0); 
signal AD4_Data_4               : std_logic_vector(15 downto 0); 
signal AD4_Data_5               : std_logic_vector(15 downto 0); 
signal AD4_Data_6               : std_logic_vector(15 downto 0); 
signal AD4_Data_7               : std_logic_vector(15 downto 0); 
signal AD4_Data_8               : std_logic_vector(15 downto 0); 
signal rx_sync_W2               : std_logic; 
signal adc_sclk_W2              : std_logic;
signal adc_sen_W2               : std_logic; 
signal ad_sdout2                : std_logic;
signal dir_test2                : std_logic;
signal adc_sdio_test2           : std_logic;
signal rx_sync_W_p2             : STD_LOGIC;
signal rx_sync_W_n2             : STD_LOGIC;
signal rx_aresetn2              : STD_LOGIC;
signal rx_core_clk_out_buf      : STD_LOGIC;

signal AD1_Data_out0w           : std_logic_vector(15 downto 0); 
signal AD1_Data_out1w           : std_logic_vector(15 downto 0); 
signal AD1_Data_out2w           : std_logic_vector(15 downto 0); 
signal AD1_Data_out3w           : std_logic_vector(15 downto 0); 
                                
signal AD3_Data_out0w           : std_logic_vector(15 downto 0); 
signal AD3_Data_out1w           : std_logic_vector(15 downto 0); 
signal AD3_Data_out2w           : std_logic_vector(15 downto 0); 
signal AD3_Data_out3w           : std_logic_vector(15 downto 0); 
begin 
rstin <= rstinP;

ad: ad9680
port map(
clk           => clk_CFG, --clk_100m
rstn          => clk_set_finish,--时钟OK后配置ADC
ad_slen       => adc_sen_W,
ad_sclk       => adc_sclk_W,
ad_set_finish => ad_config_finish,
ad_sdata      => adc_sdio,
ad_sdout      => ad_sdout ,
dir_test      => dir_test,
adc_sdio_test => adc_sdio_test
);	
adc_sen<=adc_sen_W;
adc_sclk<=adc_sclk_W;
--  BUFG_inst : BUFG
--   port map (
--      O => sys_clk_50m_bg, -- 1-bit output: Clock output
--      I => sys_clk_50m  -- 1-bit input: Clock input
--   );
--IBUFDS_inst : IBUFDS
--port map (
--  O => sys_clk_50m_bg,   -- 1-bit output: Buffer output
--  I => OSC_125mhz_p,   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
--  IB => OSC_125mhz_n  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
--);
--  sysclk_inst: sysclk
-- port map
--  (
--   clk_out1          =>clk_CFG,
--   clk_out2          =>clk_100m,
--   clk_out3          =>clk_125m,
--   clk_out4          =>clk_200m,
--   locked            =>clk_locked,
--   -- Status and control signals
--   reset             => '0',--not rstin_delay,    
--   clk_in1         =>sys_clk_50m_bg
--  );
clk_locked  <= '1';
clk_CFG     <= clk_10m;
fmc_clk125m <= ADsysref;
--TRIG_RST <= '0';
rst         <= (not TRIG_RST) and clk_locked and rstin;--系统复位  
process(rst,clk_100m)--系统复位延迟
begin
if rst = '0' then
		sysrst_countdelay   <= (others=>'0');   
		sysrst_delay        <= '0';
 elsif rising_edge(clk_100m) then 
   if sysrst_countdelay      = x"001f1111" then
	      sysrst_countdelay <= sysrst_countdelay; 	
          sysrst_delay      <= '1';
	else
	      sysrst_countdelay <= sysrst_countdelay+x"00000001";
		  sysrst_delay      <= '0'; 
	end if;
end if;
end process;
reset_h7044_h_in            <=not rst;--系统复位
h7044_sync_in               <= clk_set_finish;
h7044: hmc7044
port map(
clk   =>clk_CFG,--clk_100m
rst   =>sysrst_delay,--延迟复位
--fpga_clk_sel => fpga_clk_sel,
--clk_sel => clk_sel,
--vco_sel => vco_sel,
clk_sel      => clk_sel,
OSCON_CTRL => OSCON_CTRL,
H7044_SLEN  =>h7044_slen_in,
H7044_SCLK  =>h7044_sclkin,
H7044_SDATA =>h7044_sdata_in,
SET_FINISH =>clk_set_finish
);

process(rst,clk_100m)
begin
if rst='0' then
		rst_count2<=(others=>'0');   
		rst_ad<='1';
		rst_out <='0'; 
 elsif rising_edge(clk_100m) then 
   if rst_count2=x"000f1111" then
	      rst_count2<=rst_count2; 
			rst_ad<='0';--NOT RST 
			rst_out <='1';--NOT RST 
--	elsif rst_count=x"00Ff1111" then
--            rst_ad<='1';--RST
--            rst_out <='1'; --NOT RST CONFIG PLL
--            rst_count<=rst_count+x"00000001";		
	elsif rst_count2>=x"00011111" then
	        rst_ad<='1';--RST
			rst_out <='0'; --RST
	      rst_count2<=rst_count2+x"00000001";
	else
	      rst_count2<=rst_count2+x"00000001";
			rst_out <='0'; 
	end if;
end if; 
end process;
s_axi_aresetn <= rst;
jesd204: jesd204b_ad
   PORT MAP(
     rx_core_clk =>rx_core_clk_out,--
     s_axi_aclk =>clk_100m,
     s_axi_aresetn =>s_axi_aresetn,--延迟复位
     s_axi_awaddr =>x"000",
     s_axi_awvalid =>'0',
--     s_axi_awready =>s_axi_awready,
     s_axi_wdata=>x"00000000",
     s_axi_wstrb=>x"0",
     s_axi_wvalid =>'0',
     s_axi_bready =>'1',
     s_axi_araddr =>x"000",
     s_axi_arvalid =>'0',
     s_axi_rready =>'1',
     rx_reset => JESD204_rst,--rx_reset_delay,--ADC配置完毕，延迟一段时间后复位--
     rx_aresetn =>rx_aresetn,--OUTPUT --
     rx_tdata =>rx_tdata,--
     rx_tvalid =>rx_tvalid,--
     rx_start_of_frame =>rx_start_of_frame,--
     rx_end_of_frame =>rx_end_of_frame,--
     rx_start_of_multiframe=>rx_start_of_multiframe,--
     rx_end_of_multiframe =>rx_end_of_multiframe,--
     rx_frame_error =>rx_frame_error,--
     rx_sysref => ADsysref ,--
     rx_sync=>rx_sync_W,--
      rx_reset_gt => rx_reset_gt,--OUT
     rxencommaalign_out => rxencommaalign_out,--OUT
     rx_reset_done => rx_reset_done ,--IN
     gt0_rxdata => gt0_rxdata,
     gt0_rxcharisk => gt0_rxcharisk ,
     gt0_rxdisperr => gt0_rxdisperr,
     gt0_rxnotintable => gt0_rxnotintable,
     gt1_rxdata => gt1_rxdata,
     gt1_rxcharisk => gt1_rxcharisk ,
     gt1_rxdisperr => gt1_rxdisperr,
     gt1_rxnotintable => gt1_rxnotintable,
     gt2_rxdata => gt2_rxdata,
     gt2_rxcharisk => gt2_rxcharisk ,
     gt2_rxdisperr => gt2_rxdisperr,
     gt2_rxnotintable => gt2_rxnotintable,
     gt3_rxdata => gt3_rxdata,
     gt3_rxcharisk => gt3_rxcharisk ,
     gt3_rxdisperr => gt3_rxdisperr,
     gt3_rxnotintable => gt3_rxnotintable
--     gt4_rxdata => gt4_rxdata,
--          gt4_rxcharisk => gt4_rxcharisk ,
--          gt4_rxdisperr => gt4_rxdisperr,
--          gt4_rxnotintable => gt4_rxnotintable,
--          gt5_rxdata => gt5_rxdata,
--          gt5_rxcharisk => gt5_rxcharisk ,
--          gt5_rxdisperr => gt5_rxdisperr,
--          gt5_rxnotintable => gt5_rxnotintable,
--          gt6_rxdata => gt6_rxdata,
--          gt6_rxcharisk => gt6_rxcharisk ,
--          gt6_rxdisperr => gt6_rxdisperr,
--          gt6_rxnotintable => gt6_rxnotintable,
--          gt7_rxdata => gt7_rxdata,
--          gt7_rxcharisk => gt7_rxcharisk ,
--          gt7_rxdisperr => gt7_rxdisperr,
--          gt7_rxnotintable => gt7_rxnotintable                 
   );
--rx_tdata_s <= rx_tdata(159 downto 128) & rx_tdata(191 downto 160) & rx_tdata(223 downto 192) & rx_tdata(255 downto 224) & rx_tdata(63 downto 32) & rx_tdata(95 downto 64) & rx_tdata(31 downto 0) & rx_tdata(127 downto 96);
rx_tdata_s(63 downto 0) <=  rx_tdata(63 downto 0);--(63 downto 32) & rx_tdata(95 downto 64) & rx_tdata(31 downto 0) & rx_tdata(127 downto 96);
--rx_tdata_s(127 downto 64) <=  rx_tdata(127 downto 64);
 
 neg_data_inst: neg_data 
port map (
  data_in => rx_tdata(127 downto 64),
  data_out=> rx_tdata_s(127 downto 64)
);
 
 OBUFDS_inst : OBUFDS
   port map (
      O => rx_sync_W_p,   -- 1-bit output: Diff_p output (connect directly to top-level port)
      OB => rx_sync_W_n, -- 1-bit output: Diff_n output (connect directly to top-level port)
      I => rx_sync_W    -- 1-bit input: Buffer input
   );

   -- End of OBUFDS_inst instantiation

rx_sync_p <=rx_sync_W_p;
rx_sync_n <=rx_sync_W_n;

rx_reset <=not ad_config_finish; 
IBUFDS_inst3 : IBUFDS
port map (
  O => ADsysref,   -- 1-bit output: Buffer output
  I => ADsysref_p,   -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
  IB => ADsysref_n  -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
);
process(rst,clk_100m)
begin
if rst='0' then
		countdelay<=(others=>'0');
		rx_reset_delay<= '1'; 
elsif rising_edge(clk_100m) then
    if rx_reset = '0'then
        if countdelay = x"00Ff1111" then
	           countdelay<=countdelay;
			     rx_reset_delay<= '0';
	       else
	            countdelay<=countdelay+1;
	             rx_reset_delay<= '1';
	       end if;
	else
	    rx_reset_delay<= '1';    
	    countdelay<=(others=>'0');
	end if;      
end if;
end process;
process(rst,rx_core_clk_out)--rx_core_clk_out
begin
if rst='0' then
      AD1_Data_1<=(others=>'0');
      AD1_Data_2<=(others=>'0');
      AD1_Data_3<=(others=>'0');
      AD1_Data_4<=(others=>'0');

      AD2_Data_1<=(others=>'0');
      AD2_Data_2<=(others=>'0');
      AD2_Data_3<=(others=>'0');
      AD2_Data_4<=(others=>'0');

elsif rising_edge(rx_core_clk_out) then
--lane0
AD1_Data_1(15 downto 8)  <=	rx_tdata_s(7 downto 0);
AD1_Data_2(15 downto 8)  <=	rx_tdata_s(15 downto 8);
AD1_Data_3(15 downto 8)  <=	rx_tdata_s(23 downto 16);
AD1_Data_4(15 downto 8)  <=	rx_tdata_s(31 downto 24);
--lane1
AD1_Data_1(7 downto 0)  <=	rx_tdata_s(39 downto 32); 
AD1_Data_2(7 downto 0)  <=	rx_tdata_s(47 downto 40); 
AD1_Data_3(7 downto 0)  <=	rx_tdata_s(55 downto 48); 
AD1_Data_4(7 downto 0)  <=	rx_tdata_s(63 downto 56); 
--lane2
AD2_Data_1(15 downto 8)  <=	rx_tdata_s(71 downto 64);--
AD2_Data_2(15 downto 8)  <=	rx_tdata_s(79 downto 72);
AD2_Data_3(15 downto 8)  <=	rx_tdata_s(87 downto 80);
AD2_Data_4(15 downto 8)  <=	rx_tdata_s(95 downto 88);
--lane3
AD2_Data_1(7 downto 0)  <=	rx_tdata_s(103 downto 96);
AD2_Data_2(7 downto 0)  <=	rx_tdata_s(111 downto 104);
AD2_Data_3(7 downto 0)  <=	rx_tdata_s(119 downto 112);
AD2_Data_4(7 downto 0)  <=	rx_tdata_s(127 downto 120);

end if;
end process;
LED_0<=common0_qpll0_lock_out and common1_qpll0_lock_out;
LED_1<=led_buf;
LED_2<=tx_core_clk_out;
LED_3<=rx_core_clk_out;

 jesd204_phy_INST:jesd204_phy_0
  PORT MAP (
    tx_sys_reset => JESD204_rst ,
    rx_sys_reset  => JESD204_rst ,
    tx_reset_gt => tx_reset_gt,
    rx_reset_gt  => rx_reset_gt,
    tx_reset_done=> tx_reset_done, 
    rx_reset_done => rx_reset_done, 
    cpll_refclk  => cpll_refclk, 
    qpll0_refclk  => cpll_refclk, 
    rxencommaalign  =>  rxencommaalign_out ,
    tx_core_clk =>  tx_core_clk_out , 
    txoutclk => txoutclk ,  
    rx_core_clk =>  rx_core_clk_out ,
    rxoutclk => rxoutclk ,
    drpclk => clk_100m, 
    gt_prbssel =>  gt_prbssel_out ,
    gt_powergood => gt_powergood,
    gt0_txdata =>  gt0_txdata ,
    gt0_txcharisk =>  gt0_txcharisk ,
    gt1_txdata =>  gt1_txdata ,
    gt1_txcharisk =>  gt1_txcharisk ,
    gt2_txdata =>  gt2_txdata ,
    gt2_txcharisk =>  gt2_txcharisk ,
    gt3_txdata =>  gt3_txdata ,
    gt3_txcharisk =>  gt3_txcharisk ,
    gt4_txdata =>  gt4_txdata ,
    gt4_txcharisk =>  gt4_txcharisk ,
    gt5_txdata =>  gt5_txdata ,
    gt5_txcharisk =>  gt5_txcharisk ,
    gt6_txdata =>  gt6_txdata ,
    gt6_txcharisk =>  gt6_txcharisk ,
    gt7_txdata =>  gt7_txdata ,
    gt7_txcharisk =>  gt7_txcharisk ,
    
    gt0_rxdata => gt0_rxdata ,
    gt0_rxcharisk => gt0_rxcharisk ,
    gt0_rxdisperr => gt0_rxdisperr,
    gt0_rxnotintable => gt0_rxnotintable,
    gt1_rxdata => gt1_rxdata,
    gt1_rxcharisk => gt1_rxcharisk ,
    gt1_rxdisperr => gt1_rxdisperr,
    gt1_rxnotintable => gt1_rxnotintable,
    gt2_rxdata => gt2_rxdata,
    gt2_rxcharisk => gt2_rxcharisk ,
    gt2_rxdisperr => gt2_rxdisperr,
    gt2_rxnotintable => gt2_rxnotintable,
    gt3_rxdata => gt3_rxdata,
    gt3_rxcharisk => gt3_rxcharisk ,
    gt3_rxdisperr => gt3_rxdisperr,
    gt3_rxnotintable => gt3_rxnotintable,
    gt4_rxdata => gt4_rxdata,
         gt4_rxcharisk => gt4_rxcharisk ,
         gt4_rxdisperr => gt4_rxdisperr,
         gt4_rxnotintable => gt4_rxnotintable,
         gt5_rxdata => gt5_rxdata,
         gt5_rxcharisk => gt5_rxcharisk ,
         gt5_rxdisperr => gt5_rxdisperr,
         gt5_rxnotintable => gt5_rxnotintable,
         gt6_rxdata => gt6_rxdata,
         gt6_rxcharisk => gt6_rxcharisk ,
         gt6_rxdisperr => gt6_rxdisperr,
         gt6_rxnotintable => gt6_rxnotintable,
         gt7_rxdata => gt7_rxdata,
         gt7_rxcharisk => gt7_rxcharisk ,
         gt7_rxdisperr => gt7_rxdisperr,
         gt7_rxnotintable => gt7_rxnotintable ,
       
    rxn_in => rxn(7 downto 0) ,
    rxp_in => rxp(7 downto 0) 
  );
JESD204_rst <= rx_reset_delay or  rx_reset or DAconfig_finishn;

jesd204_ad_clk:jesd204_dac_clocking 
 PORT MAP (
     refclk_pad_n => ADgtx_refclk_n ,
     refclk_pad_p => ADgtx_refclk_p ,
     glblclk_pad_n => fmc_375mhz_n ,
     glblclk_pad_p => fmc_375mhz_p ,
     refclk => cpll_refclk ,
     gt_pg => gt_powergood,
     coreclk => rx_core_clk_out_buf ,
     coreclk2 => tx_core_clk_out
);
process(core_clk_sel,rx_core_clk_out_buf,core_clk_in)
begin
if core_clk_sel='0' then
    rx_core_clk_out <= rx_core_clk_out_buf;
elsif core_clk_sel='1' then
    rx_core_clk_out <= core_clk_in;
end if;
end process;

--tx_core_clk_out<= rx_core_clk_out;



process(rst,tx_core_clk_out)
begin
if rst='0' then
		ledcount<=(others=>'0');
		led_buf<='1';
 elsif rising_edge(tx_core_clk_out) then
   if ledcount="00000000010011110001010010000000" then
	      ledcount<=(others=>'0');
			led_buf<=not led_buf;
	else
	      ledcount<=ledcount+1;
	end if;
end if;
end process;



--LED_0<=clk_100m AND common0_qpll0_lock_out AND common1_qpll0_lock_out;
--LED_1<=fmc_clk100m;
--LED_2<=led_buf;
--LED_3<=tx_core_clk_out;
--/////////////////////////////////////////////////////////////////////////////////////////
-- tx_reset_done2 rx_reset_done2 rxencommaalign_out2 txoutclk2 rxoutclk2 gt_prbssel_out2
--rx_tdata2 rx_tvalid2 rx_start_of_frame2 rx_end_of_frame2 rx_start_of_multiframe2 rx_end_of_multiframe2 rx_frame_error2 rx_sync_W2  rx_reset_gt2 rxencommaalign_out2 rx_reset_done2
--/////////////////////////////////////////////////////////////////////////////////////////


--AD1_Data_out0 <=  (NOT AD1_Data_1(14)) & (NOT AD1_Data_1(13)) & (NOT AD1_Data_1(12)) & (NOT AD1_Data_1(11)) & (NOT AD1_Data_1(10)) & (NOT AD1_Data_1(9)) & (NOT AD1_Data_1(8)) & (NOT AD1_Data_1(7)) & (NOT AD1_Data_1(6)) & (NOT AD1_Data_1(5)) & (NOT AD1_Data_1(4)) & (NOT AD1_Data_1(3)) & (NOT AD1_Data_1(2)) & (NOT AD1_Data_1(1)) & (NOT AD1_Data_1(0)) & '0';
--AD1_Data_out1 <=  (NOT AD1_Data_2(14)) & (NOT AD1_Data_2(13)) & (NOT AD1_Data_2(12)) & (NOT AD1_Data_2(11)) & (NOT AD1_Data_2(10)) & (NOT AD1_Data_2(9)) & (NOT AD1_Data_2(8)) & (NOT AD1_Data_2(7)) & (NOT AD1_Data_2(6)) & (NOT AD1_Data_2(5)) & (NOT AD1_Data_2(4)) & (NOT AD1_Data_2(3)) & (NOT AD1_Data_2(2)) & (NOT AD1_Data_2(1)) & (NOT AD1_Data_2(0)) & '0';
--AD1_Data_out2 <=  (NOT AD1_Data_3(14)) & (NOT AD1_Data_3(13)) & (NOT AD1_Data_3(12)) & (NOT AD1_Data_3(11)) & (NOT AD1_Data_3(10)) & (NOT AD1_Data_3(9)) & (NOT AD1_Data_3(8)) & (NOT AD1_Data_3(7)) & (NOT AD1_Data_3(6)) & (NOT AD1_Data_3(5)) & (NOT AD1_Data_3(4)) & (NOT AD1_Data_3(3)) & (NOT AD1_Data_3(2)) & (NOT AD1_Data_3(1)) & (NOT AD1_Data_3(0)) & '0';
--AD1_Data_out3 <=  (NOT AD1_Data_4(14)) & (NOT AD1_Data_4(13)) & (NOT AD1_Data_4(12)) & (NOT AD1_Data_4(11)) & (NOT AD1_Data_4(10)) & (NOT AD1_Data_4(9)) & (NOT AD1_Data_4(8)) & (NOT AD1_Data_4(7)) & (NOT AD1_Data_4(6)) & (NOT AD1_Data_4(5)) & (NOT AD1_Data_4(4)) & (NOT AD1_Data_4(3)) & (NOT AD1_Data_4(2)) & (NOT AD1_Data_4(1)) & (NOT AD1_Data_4(0)) & '0';

AD1_Data_out0 <= AD1_Data_1;
AD1_Data_out1 <= AD1_Data_2;
AD1_Data_out2 <= AD1_Data_3;
AD1_Data_out3 <= AD1_Data_4;

--AD1_Data_out0 <= AD1_Data_out0w ;--+ '1' + '1';
--AD1_Data_out1 <= AD1_Data_out1w ;--+ '1' + '1';
--AD1_Data_out2 <= AD1_Data_out2w ;--+ '1' + '1';
--AD1_Data_out3 <= AD1_Data_out3w ;--+ '1' + '1';

AD2_Data_out0 <= AD2_Data_1;
AD2_Data_out1 <= AD2_Data_2;
AD2_Data_out2 <= AD2_Data_3;
AD2_Data_out3 <= AD2_Data_4;

--chipscope_inst0: ila_2
--PORT MAP(
  --clk => rx_core_clk_out,
  --probe0(15 DOWNTO 0)  => AD1_Data_1,
  --probe0(31 DOWNTO 16)  => AD1_Data_2,
  --probe0(47 DOWNTO 32)  => AD1_Data_3,
  --probe0(63 DOWNTO 48)  => AD1_Data_4,
  --probe0(79 DOWNTO 64)  => AD2_Data_1,
  --probe0(95 DOWNTO 80)  => AD2_Data_2,
  --probe0(111 DOWNTO 96)  => AD2_Data_3,
  --probe0(127 DOWNTO 112)  => AD2_Data_4,
  
  --probe0(143 DOWNTO 128)  => AD3_Data_1,
  --probe0(159 DOWNTO 144)  => AD3_Data_2,
  --probe0(175 DOWNTO 160)  => AD3_Data_3,
  --probe0(191 DOWNTO 176)  => AD3_Data_4,
  --probe0(207 DOWNTO 192)  => AD4_Data_1,
  --probe0(223 DOWNTO 208)  => AD4_Data_2,
  --probe0(239 DOWNTO 224)  => AD4_Data_3,
  --probe0(255 DOWNTO 240)  => AD4_Data_4 
--);
--chipscope_inst1: ila_1
--PORT MAP(
  --clk => clk_100m,--tx_core_clk_out,
--probe0(0)  => tx_aresetn,
--probe0(1)  => rx_sync_W,
--probe0(2)  => ad_config_finish,
--probe0(3)  => JESD204_rst,
--probe0(4)  => rx_sync_W,
--probe0(5)  => rst_ad,
--probe0(6)     =>clk_set_finish,--时钟OK后配置ADC
--probe0(7)  =>adc_sen_W,
--probe0(8)  =>adc_sclk_W,
--probe0(9) =>DAconfig_finish,
--probe0(10) => dir_test,
--probe0(11) => adc_sdio_test,
--probe0(12) => rx_tvalid,
--probe0(13) => tx_sync,
--probe0(14) => tx_tready,
--probe0(15) => tx_aresetn,
--probe0(16) => tx_reset_gt,

--probe0(20 downto 17) => rx_start_of_frame,
--probe0(24 downto 21) => rx_end_of_frame,
--probe0(28 downto 25) => rx_start_of_multiframe,
--probe0(32 downto 29) => rx_end_of_multiframe,
--probe0(48 downto 33) => rx_frame_error,
--probe0(49) => TRIG_IN,
--probe0(255 DOWNTO 50)  => (others=>'0')  

--);
--     rx_start_of_frame =>rx_start_of_frame,--
--     rx_end_of_frame =>rx_end_of_frame,--
--    rx_start_of_multiframe=>rx_start_of_multiframe,--
--     rx_end_of_multiframe =>rx_end_of_multiframe,--
rx_core_clkout <= rx_core_clk_out_buf;
--tx_core_clkout <= rx_core_clk_out_buf;
--DAOUT_ADCIN <= '0';
end behaviour;
