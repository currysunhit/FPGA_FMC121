//----------------------------------------------------------------------------
// Title : Block Level
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204_block.v
//----------------------------------------------------------------------------
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//----------------------------------------------------------------------------

`timescale 1ns / 1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204b_ad_block #(
  // AXI port dependant parameters
  parameter  C_COMPONENT_NAME            = "jesd204b_ad",
  parameter  C_FAMILY                    = "zynquplus",
  parameter  C_NODE_IS_TRANSMIT          = 0,
  parameter  C_LMFC_BUFFER_SIZE          = 6,
  parameter  C_LANES                     = 4
)(

  // Rx
  input          rx_reset,
  input          rx_core_clk,

  input          rx_sysref,
  output         rx_sync,

  output [15:0]   rx_frame_error,

  // Rx AXI-S interface for each lane
  output         rx_aresetn,

  output [3:0]   rx_start_of_frame,
  output [3:0]   rx_end_of_frame,
  output [3:0]   rx_start_of_multiframe,
  output [3:0]   rx_end_of_multiframe,  

  output         rx_tvalid,
  output [127:0]  rx_tdata,


  // Ports Required for GT
  output         rx_reset_gt,
  output         rxencommaalign_out,
  input          rx_reset_done,

  // Lane 0
  input [31:0]   gt0_rxdata,
  input [3:0]    gt0_rxcharisk,
  input [3:0]    gt0_rxdisperr,
  input [3:0]    gt0_rxnotintable,

  // Lane 1
  input [31:0]   gt1_rxdata,
  input [3:0]    gt1_rxcharisk,
  input [3:0]    gt1_rxdisperr,
  input [3:0]    gt1_rxnotintable,

  // Lane 2
  input [31:0]   gt2_rxdata,
  input [3:0]    gt2_rxcharisk,
  input [3:0]    gt2_rxdisperr,
  input [3:0]    gt2_rxnotintable,

  // Lane 3
  input [31:0]   gt3_rxdata,
  input [3:0]    gt3_rxcharisk,
  input [3:0]    gt3_rxdisperr,
  input [3:0]    gt3_rxnotintable,


  // AXI-Lite Control/Status
  input          s_axi_aclk,
  input          s_axi_aresetn,
  input [11:0]   s_axi_awaddr,
  input          s_axi_awvalid,
  output         s_axi_awready,
  input [31:0]   s_axi_wdata,
  input [3:0]    s_axi_wstrb,
  input          s_axi_wvalid,
  output         s_axi_wready,
  output[1:0]    s_axi_bresp,
  output         s_axi_bvalid,
  input          s_axi_bready,
  input [11:0]   s_axi_araddr,
  input          s_axi_arvalid,
  output         s_axi_arready,
  output[31:0]   s_axi_rdata,
  output[1:0]    s_axi_rresp,
  output         s_axi_rvalid,
  input          s_axi_rready
);

  // Configuration Registers for AXI
  reg [11:0]   rx_cfg_lanes_in_use;
  reg [7:0]    rx_cfg_octets_per_frame;
  reg [4:0]    rx_cfg_frames_per_multi;
  reg          rx_cfg_reset_i;
  reg          rx_cfg_sticky_reset;
  reg          rx_cfg_scr_enable;
  reg          rx_cfg_support_lane_sync;
  reg          rx_cfg_sysref_always;
  reg [4:0]    rx_cfg_test_modes;
  reg [1:0]    rx_cfg_subclass;
  wire         rx_cfg_sync;
  reg          rx_cfg_sysref_resync;

  wire         rx_sysref_captured;
  wire         rx_sysref_captured_sync;
  wire         rx_sysref_captured_i;
  wire         in_sync;  


  wire [127:0]  gt_rxdata_i;
  wire  [15:0]  gt_rxcharisk_i;
  wire  [15:0]  gt_rxnotintable_i;
  wire  [15:0]  gt_rxdisperr_i;

  wire         rx_core_rst_i;
  wire         rx_core_rst;

  reg          rxstatus_req_r;
  reg          rxstatus_req_tog = 0;
  wire         rxstatus_req_tog_sync;
  reg          rxstatus_ack_tog;
  wire         rxstatus_read;
  wire         rxstatus_ack_tog_sync;
  reg          rxstatus_ack_tog_r;
  wire         rxstatus_ack;

  reg          rxstatus2_req_r;
  reg          rxstatus2_req_tog = 0;
  wire         rxstatus2_req_tog_sync;
  reg          rxstatus2_ack_tog;
  wire         rxstatus2_read;
  wire         rxstatus2_ack_tog_sync;
  reg          rxstatus2_ack_tog_r;
  wire         rxstatus2_ack;

  // AXI Signals
  wire         Bus2IP_Clk;
  wire         Bus2IP_Resetn;
  wire  [3:0]  Bus2IP_BE;
  wire         Bus2IP_RdCE;
  wire         Bus2IP_WrCE;
  wire [31:0]  Bus2IP_Data;
  wire [31:0]  IP2Bus_Data_configs;
  wire [31:0]  IP2Bus_Data_laneID;
  wire [31:0]  IP2Bus_Data_settings;
  wire [11:0]  Bus2IP_Addr;
  reg  [31:0]  IP2Bus_Data;
  reg          IP2Bus_RdAck;
  reg          IP2Bus_RdAck_r;
  reg          IP2Bus_RdAck_rr;
  wire [2:0]   chip_select;
  wire [15:0]  bank0_read;
  wire [15:0]  bank1_read;
  wire [191:0] bank2_read;
  wire [15:0]  bank0_write;
  wire [15:0]  bank1_write;
  wire [15:0]  bank2_write;

  // Rx Configuration Data
  reg          rx_cfg_disable_error_reporting;
  reg   [9:0]  rx_cfg_buffer_delay;
  reg          rx_cfg_early_release;
  wire [31:0]  rxstatus;
  wire [31:0]  rxstatus2;
  reg  [31:0]  rxstatus_r;
  reg  [31:0]  rxstatus2_r;

  //init0 = {F[7:0], SCR[0], L[4:0], LID[4:0], BID[4:0], DID[7:0]};
  //init1 = {1'B0, HD[0], S[4:0], NP[4:0], CS[1:0], N[4:0], M[7:0], K[4:0]};
  //init2 = {3'B0, CF[4:0], FCHK[7:0], RES2[7:0], RES1[7:0]};
  wire [127:0]    rx_init0;
  wire [127:0]    rx_init1;
  wire [127:0]    rx_init2;
  wire [127:0]    rx_init3;
  reg  [127:0]    rx_stat_init_r0;
  reg  [127:0]    rx_stat_init_r1;
  reg  [127:0]    rx_stat_init_r2;
  reg  [127:0]    rx_stat_init_r3;
  wire [39:0]    rx_buffer_adjust;

  //Depending on nunmber of lanes init = {lane4, lane3, lane2, lane1, lane0};
  wire [127:0]  rx_test_err_count;
  wire [127:0]  rx_test_ila_count;
  wire [127:0]  rx_test_mf_count;

  
  wire [31:0]  rx_test_link0_count;
  
  wire [31:0]  rx_test_link1_count;
  
  wire [31:0]  rx_test_link2_count;
  
  wire [31:0]  rx_test_link3_count;

  reg          rx_cfg_link_test_enable;

  reg          rx_sysref_r;
  reg  [3:0]   rx_sysref_delay;

  jesd204_v7_2_4_top #(
    .C_COMPONENT_NAME            (C_COMPONENT_NAME),
    .C_FAMILY                    (C_FAMILY),
    .C_NODE_IS_TRANSMIT          (0),
    .C_LANES                     (C_LANES),
    .C_LMFC_BUFFER_SIZE          (C_LMFC_BUFFER_SIZE)
    )
  i_jesd204b_ad (
    // Clk and Reset
    .clk                     (rx_core_clk),
    .rst                     (rx_core_rst),

    // Common
    .support_lane_sync       (rx_cfg_support_lane_sync),
    .active_lanes            (rx_cfg_lanes_in_use),
    .test_modes              (rx_cfg_test_modes[1:0]),
    .subclass                (rx_cfg_subclass),
    .lmfc_pulse_delay        (rx_sysref_delay),
    .sysref_captured         (rx_sysref_captured_i),

    .start_of_frame          (rx_start_of_frame),
    .start_of_multiframe     (rx_start_of_multiframe),
    .end_of_frame            (rx_end_of_frame),
    .end_of_multiframe       (rx_end_of_multiframe),

    // Not required for subclass 0
    .sysref_always           (rx_cfg_sysref_always),
    .sysref_resync           (rx_cfg_sysref_resync),  //Require sysref to gain sync again if lost
    .sysref_in               (rx_sysref_r),

    .sysref_out              (),

    // Rx
    .octets_per_frame        (rx_cfg_octets_per_frame),
    .scram_enable            (rx_cfg_scr_enable),
    .frames_per_multiframe   (rx_cfg_frames_per_multi),
    .rx_buffer_delay         (rx_cfg_buffer_delay),
    .rx_buffer_adjust        (rx_buffer_adjust),
    .disable_error_reporting (rx_cfg_disable_error_reporting),
    .early_release           (rx_cfg_early_release),
    .init0                   (rx_init0),
    .init1                   (rx_init1),
    .init2                   (rx_init2),
    .init3                   (rx_init3),
    .test_err_count          (rx_test_err_count),
    .test_ila_count          (rx_test_ila_count),
    .test_mf_count           (rx_test_mf_count),

    .rxdata                  (gt_rxdata_i),
    .rxcharisk               (gt_rxcharisk_i),
    .rxdisperr               (gt_rxdisperr_i),
    .rxnotintable            (gt_rxnotintable_i),

    .rx_sync                 (rx_sync),
    .in_sync                 (in_sync),
    .encommaalign            (rxencommaalign_out),

    .rxdataout               (rx_tdata),
    .rxdatavalid             (rx_tvalid),
    .frame_error             (rx_frame_error),
    .rxstatus                (rxstatus),
    .rxstatus2               (rxstatus2),
    .rxstatus_read           (rxstatus_read),
    .rxstatus2_read          (rxstatus2_read),

    // Tx ports (unused)
    .multi_frames            (8'b0),
    .tx_cfg_f                (8'b0),
    .tx_cfg_k                (5'b0),
    .tx_cfg_scr              (1'b0),
    .tx_cfg_did              (8'b0),
    .tx_cfg_bid              (4'b0),
    .tx_cfg_m                (8'b0),
    .tx_cfg_cs               (2'b0),
    .tx_cfg_n                (5'b0),
    .tx_cfg_np               (5'b0),
    .tx_cfg_s                (5'b0),
    .tx_cfg_hd               (1'b0),
    .tx_cfg_res1             (8'b0),
    .tx_cfg_res2             (8'b0),
    .tx_cfg_cf               (5'b0),
    .tx_cfg_adjcnt           (4'b0),
    .tx_cfg_adjdir           (1'b0),
    .tx_cfg_phadj            (1'b0),
    .tx_cfg_cs_all           (1'b0),
    .tx_cfg_lid0             (5'b0),    
    .tx_cfg_lid1             (5'b0),
    .tx_cfg_lid2             (5'b0),
    .tx_cfg_lid3             (5'b0),
    .tx_cfg_lid4             (5'b0),
    .tx_cfg_lid5             (5'b0),
    .tx_cfg_lid6             (5'b0),
    .tx_cfg_lid7             (5'b0),   

    .tx_sync                 (1'b0),

    .txdatain                (128'b0),
    .txready                 (),

    .txdata                  (),
    .txcharisk               ()
  );

  assign rx_aresetn        = ~rx_core_rst;

  assign gt_rxdata_i       =  {gt3_rxdata, gt2_rxdata, gt1_rxdata, gt0_rxdata};
  assign gt_rxcharisk_i    =  {gt3_rxcharisk, gt2_rxcharisk, gt1_rxcharisk, gt0_rxcharisk};
  assign gt_rxdisperr_i    =  {gt3_rxdisperr, gt2_rxdisperr, gt1_rxdisperr, gt0_rxdisperr};
  assign gt_rxnotintable_i =  {gt3_rxnotintable, gt2_rxnotintable, gt1_rxnotintable, gt0_rxnotintable};

  jesd204b_ad_axi_lite_ipif #(
    .C_S_AXI_DATA_WIDTH           (32),
    .C_S_AXI_MIN_SIZE             (32'h0000_0FFF),
    .C_DPHASE_TIMEOUT             (64),
    .C_NUM_ADDRESS_RANGES         (1),
    .C_TOTAL_NUM_CE               (1),
    .C_USE_WSTRB                  (1),
    .C_ARD_ADDR_RANGE_ARRAY       ({32'h0000_0000,32'h0000_0FFF}),
    .C_ARD_NUM_CE_ARRAY           ({8'd1}),
    .C_FAMILY                     ("virtex7")
  ) i_axi_lite_ipif (
    .S_AXI_ACLK    (s_axi_aclk),
    .S_AXI_ARESETN (s_axi_aresetn),
    .S_AXI_AWADDR  (s_axi_awaddr),
    .S_AXI_AWVALID (s_axi_awvalid),
    .S_AXI_AWREADY (s_axi_awready),
    .S_AXI_WDATA   (s_axi_wdata),
    .S_AXI_WSTRB   (s_axi_wstrb),
    .S_AXI_WVALID  (s_axi_wvalid),
    .S_AXI_WREADY  (s_axi_wready),
    .S_AXI_BRESP   (s_axi_bresp),
    .S_AXI_BVALID  (s_axi_bvalid),
    .S_AXI_BREADY  (s_axi_bready),
    .S_AXI_ARADDR  (s_axi_araddr), // 12 bit
    .S_AXI_ARVALID (s_axi_arvalid),
    .S_AXI_ARREADY (s_axi_arready),
    .S_AXI_RDATA   (s_axi_rdata),
    .S_AXI_RRESP   (s_axi_rresp),
    .S_AXI_RVALID  (s_axi_rvalid),
    .S_AXI_RREADY  (s_axi_rready),

    // Controls to the IP/ipif
    .Bus2IP_Clk    (Bus2IP_Clk),
    .Bus2IP_Resetn (Bus2IP_Resetn),
    .Bus2IP_Addr   (Bus2IP_Addr),
    .Bus2IP_RNW    (),
    .Bus2IP_BE     (Bus2IP_BE),
    .Bus2IP_CS     (),
    .Bus2IP_RdCE   (Bus2IP_RdCE),
    .Bus2IP_WrCE   (Bus2IP_WrCE),
    .Bus2IP_Data   (Bus2IP_Data),
    .IP2Bus_Data   (IP2Bus_Data),
    .IP2Bus_WrAck  (Bus2IP_WrCE),
    .IP2Bus_RdAck  (IP2Bus_RdAck),
    .IP2Bus_Error  (1'b0)
  );

  jesd204b_ad_register_decode i_register_decode (
    .bus2ip_addr  (Bus2IP_Addr),
    .bus2ip_rdce  (Bus2IP_RdCE),
    .bus2ip_wrce  (Bus2IP_WrCE),
    .chip_select  (chip_select),
    .bank0_read   (bank0_read),
    .bank1_read   (bank1_read),
    .bank2_read   (bank2_read),
    .bank0_write  (bank0_write),
    .bank1_write  (bank1_write),
    .bank2_write  (bank2_write)
  );

  //Link Error Count Blocks
  
  jesd204b_ad_count_err count_link0_errors(
    .clk            (rx_core_clk),
    .rst            (rx_core_rst),
    .enable         (rx_cfg_link_test_enable),
    .disp_err       (gt0_rxdisperr),
    .notintable_err (gt0_rxnotintable),
    .data_out       (rx_test_link0_count)
  );
  
  
  jesd204b_ad_count_err count_link1_errors(
    .clk            (rx_core_clk),
    .rst            (rx_core_rst),
    .enable         (rx_cfg_link_test_enable),
    .disp_err       (gt1_rxdisperr),
    .notintable_err (gt1_rxnotintable),
    .data_out       (rx_test_link1_count)
  );
  
  
  jesd204b_ad_count_err count_link2_errors(
    .clk            (rx_core_clk),
    .rst            (rx_core_rst),
    .enable         (rx_cfg_link_test_enable),
    .disp_err       (gt2_rxdisperr),
    .notintable_err (gt2_rxnotintable),
    .data_out       (rx_test_link2_count)
  );
  
  
  jesd204b_ad_count_err count_link3_errors(
    .clk            (rx_core_clk),
    .rst            (rx_core_rst),
    .enable         (rx_cfg_link_test_enable),
    .disp_err       (gt3_rxdisperr),
    .notintable_err (gt3_rxnotintable),
    .data_out       (rx_test_link3_count)
  );
  
  
  always @(posedge rx_core_clk) begin
    rx_stat_init_r0 <= rx_init0;
    rx_stat_init_r1 <= rx_init1;
    rx_stat_init_r2 <= rx_init2;
    rx_stat_init_r3 <= rx_init3;
  end

  // AXI Lite interface - Configuration Registers

  // 0x04 Reset
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_reset_i      <= 1'b1;
      //sticky reset defaults to unset
      rx_cfg_sticky_reset <= 1'b0;
    end
    else if (bank0_write[1])
    begin
      if (Bus2IP_BE[0])
      begin
        //Self clearing reset bit OR sticky reset bit
        rx_cfg_reset_i      <= Bus2IP_Data[0] | Bus2IP_Data[1];
        //Store sticky bit
        rx_cfg_sticky_reset <= Bus2IP_Data[1];
      end
    end
    else
      //Clear the reset unless the sticky bit is set
      rx_cfg_reset_i <= rx_cfg_sticky_reset;

  // 0x08 ILA Support
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_support_lane_sync <= 1'h1;
    end
    else if (bank0_write[2])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_support_lane_sync <= Bus2IP_Data[0];
    end

  // 0x0C Scrambling
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_scr_enable <= 1'b0;
    end
    else if (bank0_write[3])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_scr_enable <= Bus2IP_Data[0];
    end

  // 0x10 SYSREF Handling (Subclass 1 mode only)
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_sysref_always <= 1'b1;
      rx_sysref_delay <= 4'b0000;
      rx_cfg_sysref_resync <= 1'b1;
    end
    else if (bank0_write[4])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_sysref_always <= Bus2IP_Data[0];
      if (Bus2IP_BE[1])
        rx_sysref_delay <= Bus2IP_Data[11:8];
      if (Bus2IP_BE[2])
        rx_cfg_sysref_resync <= Bus2IP_Data[16];
    end

  // 0x18 Test Modes
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_test_modes <= 5'b00000;
    end
    else if (bank0_write[6])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_test_modes <= Bus2IP_Data[4:0];     
    end

  // 0x20 Octets per Frame
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_octets_per_frame <= 8'd0;
    end
    else if (bank0_write[8])
    begin
      if (Bus2IP_BE[0])
       rx_cfg_octets_per_frame <= Bus2IP_Data[7:0];
    end

  // 0x24 Frames per Multiframe
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_frames_per_multi <= 5'd19;
    end
    else if (bank0_write[9])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_frames_per_multi <= Bus2IP_Data[4:0];
    end

  // 0x28 Active Lanes
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_lanes_in_use <= 12'd15;
    end
    else if (bank0_write[10])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_lanes_in_use[7:0] <= Bus2IP_Data[7:0];
      if (Bus2IP_BE[1])
        rx_cfg_lanes_in_use[11:8] <= Bus2IP_Data[11:8];  
    end

  // 0x2C Subclass
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_subclass <= 2'b01;
      rx_cfg_early_release <= 1'b0;
    end
    else if (bank0_write[11])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_subclass <= Bus2IP_Data[1:0];
      if (Bus2IP_BE[1])
        rx_cfg_early_release <= Bus2IP_Data[8]; 
        
    end

  // 0x30 Rx Buffer Delay
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_buffer_delay <= 10'h0;
    end
    else if (bank0_write[12])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_buffer_delay[7:0] <= Bus2IP_Data[7:0];
      if (Bus2IP_BE[1])
        rx_cfg_buffer_delay[9:8] <= Bus2IP_Data[9:8];
    end

  // 0x34 Rx Link Test, Disable error reporting via ~SYNC interface
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      rx_cfg_link_test_enable <= 1'b0;
      rx_cfg_disable_error_reporting <= 1'b0;
    end
    else if (bank0_write[13])
    begin
      if (Bus2IP_BE[0])
        rx_cfg_link_test_enable <= Bus2IP_Data[0];
      if (Bus2IP_BE[1])
        rx_cfg_disable_error_reporting <= Bus2IP_Data[8];
    end

  // Register Bank 0 : 0x000 - 0x03F : Configuration
  assign IP2Bus_Data_configs = bank0_read[0] ? {8'd7, 8'd2, 8'd4, 8'h00} :
                               bank0_read[1] ? {31'h0, rx_core_rst_i} :
                               bank0_read[2] ? {30'h0, rx_cfg_support_lane_sync} :
                               bank0_read[3] ? {31'h0, rx_cfg_scr_enable} :
                               bank0_read[4] ? {15'h0, rx_cfg_sysref_resync, 4'h0, rx_sysref_delay, 7'h0, rx_cfg_sysref_always} :
                               bank0_read[6] ? {27'h0, rx_cfg_test_modes} :
                               bank0_read[7] ? rxstatus_r :
                               bank0_read[8] ? {24'h0, rx_cfg_octets_per_frame} :
                               bank0_read[9] ? {27'h0, rx_cfg_frames_per_multi} :
                               bank0_read[10] ? {20'h0, rx_cfg_lanes_in_use} :
                               bank0_read[11] ? {23'h0, rx_cfg_early_release, 6'b0, rx_cfg_subclass} :
                               bank0_read[12] ? {16'h0, 6'h0, rx_cfg_buffer_delay} :
                               bank0_read[13] ? {23'h0, rx_cfg_disable_error_reporting, 7'h0, rx_cfg_link_test_enable} :
                               bank0_read[14] ? {15'h0, rx_sysref_captured, 15'h0, rx_cfg_sync} :
                               bank0_read[15] ? rxstatus2_r :
                               32'h00000000;
  // Register Bank 1 : 0x400 - 0x43F: Not used by Rx core
  assign IP2Bus_Data_laneID  = 32'h00000000;
                               
  // Register Bank 2 : 0x800 - 0xAFF : Read Only : Captured ILA Configuration Data, per lane
  assign IP2Bus_Data_settings = bank2_read[0] ? {21'h0, rx_stat_init_r3[8:6], 5'h0, rx_stat_init_r3[11:9]} :  // Version and Subclass
                                bank2_read[1] ? {24'h0, rx_stat_init_r0[31:24]} :                             // Octets per frame
                                bank2_read[2] ? {27'h0, rx_stat_init_r1[4:0]} :                               // Frames per multi
                                bank2_read[3] ? {3'h0, rx_stat_init_r0[22:18], 3'h0, rx_stat_init_r0[17:13], 4'h0, rx_stat_init_r0[11:8], rx_stat_init_r0[7:0]} :    // Lanes per link, Lane ID, BID, DID
                                bank2_read[4] ? {6'h0, rx_stat_init_r1[19:18], 3'h0, rx_stat_init_r1[24:20], 3'h0, rx_stat_init_r1[17:13], rx_stat_init_r1[12:5]} :  // CS, N', N, M
                                bank2_read[5] ? {3'h0, rx_stat_init_r2[28:24], 7'h0, rx_stat_init_r1[30], 3'h0, rx_stat_init_r1[29:25], 7'h0, rx_stat_init_r0[23]} : // CF, HD, S, SCR
                                bank2_read[6] ? {8'h0, rx_stat_init_r2[23:16], rx_stat_init_r2[15:8], rx_stat_init_r2[7:0]} :                                        // FCHK, RES2, RES1
                                bank2_read[7] ? {15'h0, rx_stat_init_r3[5], 7'h0, rx_stat_init_r3[4], 4'h0, rx_stat_init_r3[3:0]} :                                  // Adj count dir, Phase Adj req, Adj Count
                                bank2_read[8] ? rx_test_err_count[31:0] :
                                bank2_read[9] ? rx_test_link0_count :
                                bank2_read[10] ? rx_test_ila_count[31:0] :
                                bank2_read[11] ? rx_test_mf_count[31:0] :
                                bank2_read[12] ? {22'h0, rx_buffer_adjust[9:0]} :
                                // Lane 1
                                bank2_read[16] ? {21'h0, rx_stat_init_r3[40:38] ,5'h0, rx_stat_init_r3[43:41]} : // Version and Subclass
                                bank2_read[17] ? {24'h0, rx_stat_init_r0[63:56]} :                               // Octets per frame
                                bank2_read[18] ? {27'h0, rx_stat_init_r1[36:32]} :                               // Frames per multi
                                bank2_read[19] ? {3'h0, rx_stat_init_r0[54:50], 3'h0, rx_stat_init_r0[49:45], 4'h0, rx_stat_init_r0[43:40], rx_stat_init_r0[39:32]} : // Lanes per link, Lane ID, BID, DID
                                bank2_read[20] ? {6'h0, rx_stat_init_r1[51:50], 3'h0, rx_stat_init_r1[56:52], 3'h0, rx_stat_init_r1[49:45], rx_stat_init_r1[44:37]} : // CS, N', N, M
                                bank2_read[21] ? {3'h0, rx_stat_init_r2[60:56], 7'h0, rx_stat_init_r1[62], 3'h0, rx_stat_init_r1[61:57], 7'h0, rx_stat_init_r0[55]} : // CF, HD, S, SCR
                                bank2_read[22] ? {8'h0, rx_stat_init_r2[55:48], rx_stat_init_r2[47:40], rx_stat_init_r2[39:32]} :                                     // FCHK, RES2, RES1
                                bank2_read[23] ? {15'h0, rx_stat_init_r3[37], 7'h0, rx_stat_init_r3[36], 4'h0, rx_stat_init_r3[35:32]} :                              // Adj count dir, Phase Adj req, Adj Count
                                bank2_read[24] ? rx_test_err_count[63:32] :
                                bank2_read[25] ? rx_test_link1_count :
                                bank2_read[26] ? rx_test_ila_count[63:32] :
                                bank2_read[27] ? rx_test_mf_count[63:32] :
                                bank2_read[28] ? {22'h0, rx_buffer_adjust[19:10]} :
                                // Lane 2
                                bank2_read[32] ? {21'h0, rx_stat_init_r3[72:70] ,5'h0, rx_stat_init_r3[75:73]} : // Version and Subclass
                                bank2_read[33] ? {24'h0, rx_stat_init_r0[95:88]} :                               // Octets per frame
                                bank2_read[34] ? {27'h0, rx_stat_init_r1[68:64]} :                               // Frames per multi
                                bank2_read[35] ? {3'h0, rx_stat_init_r0[86:82], 3'h0, rx_stat_init_r0[81:77], 4'h0, rx_stat_init_r0[75:72], rx_stat_init_r0[71:64]} : // Lanes per link, Lane ID, BID, DID
                                bank2_read[36] ? {6'h0, rx_stat_init_r1[83:82], 3'h0, rx_stat_init_r1[88:84], 3'h0, rx_stat_init_r1[81:77], rx_stat_init_r1[76:69]} : // CS, N', N, M
                                bank2_read[37] ? {3'h0, rx_stat_init_r2[92:88], 7'h0, rx_stat_init_r1[94], 3'h0, rx_stat_init_r1[93:89], 7'h0, rx_stat_init_r0[87]} : // CF, HD, S, SCR
                                bank2_read[38] ? {8'h0, rx_stat_init_r2[87:80], rx_stat_init_r2[79:72], rx_stat_init_r2[71:64]} :                                     // FCHK, RES2, RES1
                                bank2_read[39] ? {15'h0, rx_stat_init_r3[69], 7'h0, rx_stat_init_r3[68], 4'h0, rx_stat_init_r3[67:64]} :                              // Adj count dir, Phase Adj req, Adj Count
                                bank2_read[40] ? rx_test_err_count[95:64] :
                                bank2_read[41] ? rx_test_link2_count :
                                bank2_read[42] ? rx_test_ila_count[95:64] :
                                bank2_read[43] ? rx_test_mf_count[95:64] :
                                bank2_read[44] ? {22'h0, rx_buffer_adjust[29:20]} :
                                // Lane 3
                                bank2_read[48] ? {21'h0, rx_stat_init_r3[104:102], 5'h0, rx_stat_init_r3[107:105]} : // Version and Subclass
                                bank2_read[49] ? {24'h0, rx_stat_init_r0[127:120]} :                                 // Octets per frame
                                bank2_read[50] ? {27'h0, rx_stat_init_r1[100:96]} :                                  // Frames per multi
                                bank2_read[51] ? {3'h0, rx_stat_init_r0[118:114], 3'h0, rx_stat_init_r0[113:109], 4'h0, rx_stat_init_r0[107:104], rx_stat_init_r0[103:96]} :  // Lanes per link, Lane ID, BID, DID
                                bank2_read[52] ? {6'h0, rx_stat_init_r1[115:114], 3'h0, rx_stat_init_r1[120:116], 3'h0, rx_stat_init_r1[113:109], rx_stat_init_r1[108:101]} : // CS, N', N, M
                                bank2_read[53] ? {3'h0, rx_stat_init_r2[124:120], 7'h0, rx_stat_init_r1[126], 3'h0, rx_stat_init_r1[125:121], 7'h0, rx_stat_init_r0[119]} :   // CF, HD, S, SCR
                                bank2_read[54] ? {8'h0, rx_stat_init_r2[119:112], rx_stat_init_r2[111:104], rx_stat_init_r2[103:96]} :                                        // FCHK, RES2, RES1
                                bank2_read[55] ? {15'h0, rx_stat_init_r3[101], 7'h0, rx_stat_init_r3[100], 4'h0, rx_stat_init_r3[99:96]} :                                    // Adj count dir, Phase Adj req, Adj Count
                                bank2_read[56] ? rx_test_err_count[127:96] :
                                bank2_read[57] ? rx_test_link3_count :
                                bank2_read[58] ? rx_test_ila_count[127:96] :
                                bank2_read[59] ? rx_test_mf_count[127:96] :
                                bank2_read[60] ? {22'h0, rx_buffer_adjust[39:30]} :
                                32'h00000000;

  // Assign AXI Bus output depending on CS
  always @(posedge Bus2IP_Clk)
    if (chip_select[0])
      IP2Bus_Data <= IP2Bus_Data_configs;
    else if (chip_select[1])
      IP2Bus_Data <= IP2Bus_Data_laneID;
    else // if (chip_select[2])
      IP2Bus_Data <= IP2Bus_Data_settings;

      
  always @(posedge Bus2IP_Clk)
    if (Bus2IP_RdCE == 1'b1) begin
      IP2Bus_RdAck_r    <= ~(bank0_read[15] | bank0_read[7]);
      IP2Bus_RdAck_rr   <= IP2Bus_RdAck_r;
      IP2Bus_RdAck      <= IP2Bus_RdAck_rr | rxstatus_ack | rxstatus2_ack;      
    end
    else
    begin
      IP2Bus_RdAck    <= 1'b0;
      IP2Bus_RdAck_r    <= 1'b0;
      IP2Bus_RdAck_rr    <= 1'b0;
    end  
    
             
  // -------------------- Detect rxstatus read and create req/ack -------------------------

  // Register read request
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus_req_r <= 1'b0;
    else  
      rxstatus_req_r <= bank0_read[7];

  // Flip toggle on rising edge of read request
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus_req_tog <= 1'b0;
    else if (bank0_read[7] & ~rxstatus_req_r) 
      rxstatus_req_tog <= ~rxstatus_req_tog;

  // Synchronise req toggle into core clock domain
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rxstatus_read  (
  .dest_clk (rx_core_clk),	
  .src_clk  (1'd0),	
  .src_in   (rxstatus_req_tog),
  .dest_out (rxstatus_req_tog_sync)
  );

  // Indicate read request (clear) to status registers in core clock domain on rising or falling edge of toggle
  assign rxstatus_read = (rxstatus_req_tog_sync != rxstatus_ack_tog) ? 1'b1 : 1'b0;

  // Clear register at same time as capturing a copy.
  always @(posedge rx_core_clk)
    if (rxstatus_read)
      rxstatus_r <= rxstatus;

  // Ack immediately
  always @(posedge rx_core_clk)
    if (rx_core_rst)
      rxstatus_ack_tog <= 1'b0;
    else  
      rxstatus_ack_tog <= rxstatus_req_tog_sync;

  // Synchronise ack toggle into AXI clock domain
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rxstatus_ack  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (rxstatus_ack_tog),
  .dest_out (rxstatus_ack_tog_sync)
  );

  // Register ack
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus_ack_tog_r <= 1'b0;
    else  
      rxstatus_ack_tog_r <= rxstatus_ack_tog_sync;

  // Detect rising and falling edge
  assign rxstatus_ack = (rxstatus_ack_tog_r != rxstatus_ack_tog_sync);  
  
  // -------------------- Detect rxstatus2 read and create req/ack -------------------------

  // Register read request
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus2_req_r <= 1'b0;
    else  
      rxstatus2_req_r <= bank0_read[15];

  // Flip toggle on rising edge of read request
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus2_req_tog <= 1'b0;
    else if (bank0_read[15] & ~rxstatus2_req_r) 
      rxstatus2_req_tog <= ~rxstatus2_req_tog;

  // Synchronise req toggle into core clock domain
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rxstatus2_read  (
  .dest_clk (rx_core_clk),	
  .src_clk  (1'd0),	
  .src_in   (rxstatus2_req_tog),
  .dest_out (rxstatus2_req_tog_sync)
  );

  // Indicate read request (clear) to status registers in core clock domain on rising or faling edge of toggle
  assign rxstatus2_read = (rxstatus2_req_tog_sync != rxstatus2_ack_tog) ? 1'b1 : 1'b0;

  // Clear register at same time as capturing a copy.
  always @(posedge rx_core_clk)
    if (rxstatus2_read)
      rxstatus2_r <= rxstatus2;

  // Ack immediately
  always @(posedge rx_core_clk)
    if (rx_core_rst)
      rxstatus2_ack_tog <= 1'b0;
    else  
      rxstatus2_ack_tog <= rxstatus2_req_tog_sync;

  // Synchronise ack toggle into AXI clock domain
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rxstatus2_ack  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (rxstatus2_ack_tog),
  .dest_out (rxstatus2_ack_tog_sync)
  );

  // Register ack
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
      rxstatus2_ack_tog_r <= 1'b0;
    else  
      rxstatus2_ack_tog_r <= rxstatus2_ack_tog_sync;

  // Detect rising and falling edge
  assign rxstatus2_ack = (rxstatus2_ack_tog_r != rxstatus2_ack_tog_sync);

  // Instantiate reset block
  jesd204b_ad_reset_block  i_jesd204b_ad_reset_block (
    .axi_clk           (Bus2IP_Clk),
    .core_clk          (rx_core_clk),
    .reset             (rx_reset), 
    .cfg_reset         (rx_cfg_reset_i), 
    .gt_reset_done     (rx_reset_done),
    .core_reset_reg    (rx_core_rst_i),
    .core_reset_sync   (rx_core_rst),
    .gt_reset          (rx_reset_gt)
  );
   
  // Clock Domain Synchronizers 
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rx_sysref_captured  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (rx_sysref_captured_i),
  .dest_out (rx_sysref_captured_sync)
  );
      
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_rx_sync  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (in_sync),
  .dest_out (rx_cfg_sync)
  );
    
  assign rx_sysref_captured = (rx_cfg_subclass == 2'h1) ? rx_sysref_captured_sync : 1'b0;

  // Capture SYSREF
  always @(negedge rx_core_clk)
    rx_sysref_r <= rx_sysref;

endmodule
