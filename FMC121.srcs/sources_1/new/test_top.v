`timescale 1ns / 1ps

module test_top(
input            rstin,
                 
input            PL_CLK0_P,
input            PL_CLK0_N,

output           h7044_slen_in,
output           h7044_sclkin,
output           h7044_sdata_in,
output           h7044_sync_in,
output           reset_h7044_h_in,
output           OSCON_CTRL,
input            ADgtx_refclk_p,
input            ADgtx_refclk_n,
input  [7:0]     rxp,
input  [7:0]     rxn,
input            fmc_375mhz_p,
input            fmc_375mhz_n,
output           rx_sync_p,
output           rx_sync_n,
output           adc_sclk,
output           adc_sen,
inout            adc_sdio,
input            ADsysref_p,
input            ADsysref_n,

input            uart_rxd,
output           uart_txd,
                 
output           trig_out,
input            trig_in,
                 
output           LED_0,
output           LED_1
    );
    
    
wire  [1:0]      clk_sel; 
wire             sys_clk_50m_bg;

IBUFDS IBUFDS_inst (
      .O         (sys_clk_50m_bg),   // 1-bit output: Buffer output
      .I         (PL_CLK0_P),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
      .IB        (PL_CLK0_N)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
   );
   
wire             clk_10m,clk_100m,clk_50m,clk_125m;
wire             locked;

sysclk sysclk_inst //¸ø³öÊ±ÖÓ
  (
      .clk_out1  (clk_10m),
      .clk_out2  (clk_100m),
      .clk_out3  (clk_50m),
      .clk_out4  (clk_125m),
      .locked    (locked),
      .reset     (0),
      .clk_in1   (sys_clk_50m_bg)
  );    
  
 wire             rstn;
 wire             TRIG_RST;
 assign           TRIG_RST = 0;
 assign           rstn     = rstin & locked &(~TRIG_RST);

 wire[15:0]       AD1_Data_out0,AD1_Data_out1,AD1_Data_out2,AD1_Data_out3;
 wire[15:0]       AD2_Data_out0,AD2_Data_out1,AD2_Data_out2,AD2_Data_out3;
 
 
 wire rx_core_clk_out;



fmc121_top fmc121_top_adc
(
	.rstinP			         (rstn),
	.clk_10m                 (clk_10m),
	.clk_100m                (clk_100m),
	.TRIG_RST                (TRIG_RST),
    
   // --------------------------
    .h7044_slen_in		     (h7044_slen_in),
    .h7044_sclkin			 (h7044_sclkin),
    .h7044_sdata_in		     (h7044_sdata_in),
    .h7044_sync_in			 (h7044_sync_in),
    .reset_h7044_h_in		 (reset_h7044_h_in),
    .OSCON_CTRL     	     (OSCON_CTRL),

    .clk_sel                 (clk_sel),
//---------------------adc--------------------------
	.ADgtx_refclk_p		     (ADgtx_refclk_p),
	.ADgtx_refclk_n		     (ADgtx_refclk_n),
	.rxp		             (rxp),
	.rxn		             (rxn),
	.fmc_375mhz_p            (fmc_375mhz_p),
    .fmc_375mhz_n            (fmc_375mhz_n),
    .rx_sync_p	             (rx_sync_p),
    .rx_sync_n               (rx_sync_n),
    .adc_sclk                (adc_sclk),
    .adc_sen                 (adc_sen),
    .adc_sdio                (adc_sdio),
	.ADsysref_p              (ADsysref_p),
	.ADsysref_n              (ADsysref_n),
	//--------------------------------------adc2
	
	.core_clk_in             (0),
	.core_clk_sel            (0),
	.rx_core_clkout          (rx_core_clk_out),
	.AD1_Data_out0           (AD1_Data_out0),
	.AD1_Data_out1           (AD1_Data_out1),
	.AD1_Data_out2           (AD1_Data_out2),
	.AD1_Data_out3           (AD1_Data_out3),
                             
	.AD2_Data_out0           (AD2_Data_out0),
	.AD2_Data_out1           (AD2_Data_out1),
	.AD2_Data_out2           (AD2_Data_out2),
	.AD2_Data_out3           (AD2_Data_out3),	

    .TRIG_IN                 (trig_in),
//----------------------led---------------------------
    .LED_0                   (LED_0),
    .LED_1                   (LED_1),
    .LED_2                   (),
    .LED_3                   ()
);	

reg [15:0] AD1_Data0,AD1_Data1,AD1_Data2,AD1_Data3,AD2_Data0,AD2_Data1,AD2_Data2,AD2_Data3;
always @(posedge rx_core_clk_out) begin
    
    AD1_Data0 <= AD1_Data_out0;
    AD1_Data1 <= AD1_Data_out1;
    AD1_Data2 <= AD1_Data_out2;
    AD1_Data3 <= AD1_Data_out3;
    AD2_Data0 <= AD2_Data_out0;
    AD2_Data1 <= AD2_Data_out1;
    AD2_Data2 <= AD2_Data_out2;
    AD2_Data3 <= AD2_Data_out3;

end

wire [15:0] ad1_d0,ad1_d1,ad1_d2,ad1_d3;
wire [15:0] ad2_d0,ad2_d1,ad2_d2,ad2_d3;
assign ad1_d0[15:0] = AD1_Data0[15:0];
assign ad1_d1[15:0] = AD1_Data1[15:0];
assign ad1_d2[15:0] = AD1_Data2[15:0];
assign ad1_d3[15:0] = AD1_Data3[15:0];
assign ad2_d0[15:0] = AD2_Data0[15:0];
assign ad2_d1[15:0] = AD2_Data1[15:0];
assign ad2_d2[15:0] = AD2_Data2[15:0];
assign ad2_d3[15:0] = AD2_Data3[15:0];

pulse_data pulse_data_u(
    .ad_n0       (ad1_d0),
    .ad_n1       (ad1_d1),
    .ad_n2       (ad1_d2),
    .ad_n3       (ad1_d3),
    .clk_250m    (rx_core_clk_out),
    .clk_50m     (clk_50m),
    .clk_125m    (clk_125m),
    .rst_n       (rstn),
    .uart_rxd    (uart_rxd),
    .uart_txd    (uart_txd)
);

   
vio_0 vio_0_inst(
   .clk          (clk_100m),
   .probe_out0   (clk_sel),
   .probe_out1   ()
   );
   
   
   reg [5:0]     cnt_trig;
   reg           TRIG_OUT_REG;
always@(posedge clk_100m) begin
    if(~rstn) begin
        cnt_trig     <= 0;
        TRIG_OUT_REG <= 0;
    end else if(cnt_trig == 5'd7)begin
        cnt_trig     <= 0;
        TRIG_OUT_REG <= ~TRIG_OUT_REG;
    end else begin
        cnt_trig     <= cnt_trig+1; 
        TRIG_OUT_REG <= TRIG_OUT_REG;
    end                                                
end  
   
   assign trig_out    = TRIG_OUT_REG;
   
endmodule
