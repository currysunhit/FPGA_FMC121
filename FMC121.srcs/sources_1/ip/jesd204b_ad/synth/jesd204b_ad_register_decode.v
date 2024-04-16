//----------------------------------------------------------------------------
// Title : Address Decode
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204b_ad"_register_decode.v
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

module jesd204b_ad_register_decode (
  input     [11:0]  bus2ip_addr,
  input             bus2ip_rdce,
  input             bus2ip_wrce,
  output reg [2:0]  chip_select,
  output    [15:0]  bank0_read,
  output    [15:0]  bank1_read,
  output   [191:0]  bank2_read,
  output    [15:0]  bank0_write,
  output    [15:0]  bank1_write,
  output    [15:0]  bank2_write // All addresses above 15 are read only
);

  reg  [191:0] reg_select;

// Decode 4 banks:
// Bank 1 start at 0x000 64  Bytes (16  word registers)
// Bank 2 start at 0x400 64  Bytes (16  word registers)
// Bank 3 start at 0x800 512 Bytes (128 word registers)

always @(bus2ip_addr)
begin

  //Generate 4 top level chip selects
  if (bus2ip_addr[11:10] == 2'b00)
    chip_select = 4'h1;
  else if (bus2ip_addr[11:10] == 2'b01)
    chip_select = 4'h2;
  else if (bus2ip_addr[11:10] == 2'b10)
    chip_select = 4'h4;
  else
    chip_select = 4'h8;

  //Generate 128 low level register selects (32bit registers)
  reg_select[191:0] = 192'h0;
  case (bus2ip_addr[9:2])
    8'd0     : reg_select[0]   = 1'b1;
    8'd1     : reg_select[1]   = 1'b1;
    8'd2     : reg_select[2]   = 1'b1;
    8'd3     : reg_select[3]   = 1'b1;
    8'd4     : reg_select[4]   = 1'b1;
    8'd5     : reg_select[5]   = 1'b1;
    8'd6     : reg_select[6]   = 1'b1;
    8'd7     : reg_select[7]   = 1'b1;
    8'd8     : reg_select[8]   = 1'b1;
    8'd9     : reg_select[9]   = 1'b1;
    8'd10    : reg_select[10]  = 1'b1;
    8'd11    : reg_select[11]  = 1'b1;
    8'd12    : reg_select[12]  = 1'b1;
    8'd13    : reg_select[13]  = 1'b1;
    8'd14    : reg_select[14]  = 1'b1;
    8'd15    : reg_select[15]  = 1'b1;
    8'd16    : reg_select[16]  = 1'b1;
    8'd17    : reg_select[17]  = 1'b1;
    8'd18    : reg_select[18]  = 1'b1;
    8'd19    : reg_select[19]  = 1'b1;
    8'd20    : reg_select[20]  = 1'b1;
    8'd21    : reg_select[21]  = 1'b1;
    8'd22    : reg_select[22]  = 1'b1;
    8'd23    : reg_select[23]  = 1'b1;
    8'd24    : reg_select[24]  = 1'b1;
    8'd25    : reg_select[25]  = 1'b1;
    8'd26    : reg_select[26]  = 1'b1;
    8'd27    : reg_select[27]  = 1'b1;
    8'd28    : reg_select[28]  = 1'b1;
    8'd29    : reg_select[29]  = 1'b1;
    8'd30    : reg_select[30]  = 1'b1;
    8'd31    : reg_select[31]  = 1'b1;
    8'd32    : reg_select[32]  = 1'b1;
    8'd33    : reg_select[33]  = 1'b1;
    8'd34    : reg_select[34]  = 1'b1;
    8'd35    : reg_select[35]  = 1'b1;
    8'd36    : reg_select[36]  = 1'b1;
    8'd37    : reg_select[37]  = 1'b1;
    8'd38    : reg_select[38]  = 1'b1;
    8'd39    : reg_select[39]  = 1'b1;
    8'd40    : reg_select[40]  = 1'b1;
    8'd41    : reg_select[41]  = 1'b1;
    8'd42    : reg_select[42]  = 1'b1;
    8'd43    : reg_select[43]  = 1'b1;
    8'd44    : reg_select[44]  = 1'b1;
    8'd45    : reg_select[45]  = 1'b1;
    8'd46    : reg_select[46]  = 1'b1;
    8'd47    : reg_select[47]  = 1'b1;
    8'd48    : reg_select[48]  = 1'b1;
    8'd49    : reg_select[49]  = 1'b1;
    8'd50    : reg_select[50]  = 1'b1;
    8'd51    : reg_select[51]  = 1'b1;
    8'd52    : reg_select[52]  = 1'b1;
    8'd53    : reg_select[53]  = 1'b1;
    8'd54    : reg_select[54]  = 1'b1;
    8'd55    : reg_select[55]  = 1'b1;
    8'd56    : reg_select[56]  = 1'b1;
    8'd57    : reg_select[57]  = 1'b1;
    8'd58    : reg_select[58]  = 1'b1;
    8'd59    : reg_select[59]  = 1'b1;
    8'd60    : reg_select[60]  = 1'b1;
    8'd61    : reg_select[61]  = 1'b1;
    8'd62    : reg_select[62]  = 1'b1;
    8'd63    : reg_select[63]  = 1'b1;
    8'd64    : reg_select[64]  = 1'b1;
    8'd65    : reg_select[65]  = 1'b1;
    8'd66    : reg_select[66]  = 1'b1;
    8'd67    : reg_select[67]  = 1'b1;
    8'd68    : reg_select[68]  = 1'b1;
    8'd69    : reg_select[69]  = 1'b1;
    8'd70    : reg_select[70]  = 1'b1;
    8'd71    : reg_select[71]  = 1'b1;
    8'd72    : reg_select[72]  = 1'b1;
    8'd73    : reg_select[73]  = 1'b1;
    8'd74    : reg_select[74]  = 1'b1;
    8'd75    : reg_select[75]  = 1'b1;
    8'd76    : reg_select[76]  = 1'b1;
    8'd77    : reg_select[77]  = 1'b1;
    8'd78    : reg_select[78]  = 1'b1;
    8'd79    : reg_select[79]  = 1'b1;
    8'd80    : reg_select[80]  = 1'b1;
    8'd81    : reg_select[81]  = 1'b1;
    8'd82    : reg_select[82]  = 1'b1;
    8'd83    : reg_select[83]  = 1'b1;
    8'd84    : reg_select[84]  = 1'b1;
    8'd85    : reg_select[85]  = 1'b1;
    8'd86    : reg_select[86]  = 1'b1;
    8'd87    : reg_select[87]  = 1'b1;
    8'd88    : reg_select[88]  = 1'b1;
    8'd89    : reg_select[89]  = 1'b1;
    8'd90    : reg_select[90]  = 1'b1;
    8'd91    : reg_select[91]  = 1'b1;
    8'd92    : reg_select[92]  = 1'b1;
    8'd93    : reg_select[93]  = 1'b1;
    8'd94    : reg_select[94]  = 1'b1;
    8'd95    : reg_select[95]  = 1'b1;
    8'd96    : reg_select[96]  = 1'b1;
    8'd97    : reg_select[97]  = 1'b1;
    8'd98    : reg_select[98]  = 1'b1;
    8'd99    : reg_select[99]  = 1'b1;
    8'd100   : reg_select[100] = 1'b1;
    8'd101   : reg_select[101] = 1'b1;
    8'd102   : reg_select[102] = 1'b1;
    8'd103   : reg_select[103] = 1'b1;
    8'd104   : reg_select[104] = 1'b1;
    8'd105   : reg_select[105] = 1'b1;
    8'd106   : reg_select[106] = 1'b1;
    8'd107   : reg_select[107] = 1'b1;
    8'd108   : reg_select[108] = 1'b1;
    8'd109   : reg_select[109] = 1'b1;
    8'd110   : reg_select[110] = 1'b1;
    8'd111   : reg_select[111] = 1'b1;
    8'd112   : reg_select[112] = 1'b1;
    8'd113   : reg_select[113] = 1'b1;
    8'd114   : reg_select[114] = 1'b1;
    8'd115   : reg_select[115] = 1'b1;
    8'd116   : reg_select[116] = 1'b1;
    8'd117   : reg_select[117] = 1'b1;
    8'd118   : reg_select[118] = 1'b1;
    8'd119   : reg_select[119] = 1'b1;
    8'd120   : reg_select[120] = 1'b1;
    8'd121   : reg_select[121] = 1'b1;
    8'd122   : reg_select[122] = 1'b1;
    8'd123   : reg_select[123] = 1'b1;
    8'd124   : reg_select[124] = 1'b1;
    8'd125   : reg_select[125] = 1'b1;
    8'd126   : reg_select[126] = 1'b1;
    8'd127   : reg_select[127] = 1'b1;
    8'd128   : reg_select[128] = 1'b1;
    8'd129   : reg_select[129] = 1'b1;
    8'd130   : reg_select[130] = 1'b1;
    8'd131   : reg_select[131] = 1'b1;
    8'd132   : reg_select[132] = 1'b1;
    8'd133   : reg_select[133] = 1'b1;
    8'd134   : reg_select[134] = 1'b1;
    8'd135   : reg_select[135] = 1'b1;
    8'd136   : reg_select[136] = 1'b1;
    8'd137   : reg_select[137] = 1'b1;
    8'd138   : reg_select[138] = 1'b1;
    8'd139   : reg_select[139] = 1'b1;
    8'd140   : reg_select[140] = 1'b1;
    8'd141   : reg_select[141] = 1'b1;
    8'd142   : reg_select[142] = 1'b1;
    8'd143   : reg_select[143] = 1'b1;
    8'd144   : reg_select[144] = 1'b1;
    8'd145   : reg_select[145] = 1'b1;
    8'd146   : reg_select[146] = 1'b1;
    8'd147   : reg_select[147] = 1'b1;
    8'd148   : reg_select[148] = 1'b1;
    8'd149   : reg_select[149] = 1'b1;
    8'd150   : reg_select[150] = 1'b1;
    8'd151   : reg_select[151] = 1'b1;
    8'd152   : reg_select[152] = 1'b1;
    8'd153   : reg_select[153] = 1'b1;
    8'd154   : reg_select[154] = 1'b1;
    8'd155   : reg_select[155] = 1'b1;
    8'd156   : reg_select[156] = 1'b1;
    8'd157   : reg_select[157] = 1'b1;
    8'd158   : reg_select[158] = 1'b1;
    8'd159   : reg_select[159] = 1'b1;
    8'd160   : reg_select[160] = 1'b1;
    8'd161   : reg_select[161] = 1'b1;
    8'd162   : reg_select[162] = 1'b1;
    8'd163   : reg_select[163] = 1'b1;
    8'd164   : reg_select[164] = 1'b1;
    8'd165   : reg_select[165] = 1'b1;
    8'd166   : reg_select[166] = 1'b1;
    8'd167   : reg_select[167] = 1'b1;
    8'd168   : reg_select[168] = 1'b1;
    8'd169   : reg_select[169] = 1'b1;
    8'd170   : reg_select[170] = 1'b1;
    8'd171   : reg_select[171] = 1'b1;
    8'd172   : reg_select[172] = 1'b1;
    8'd173   : reg_select[173] = 1'b1;
    8'd174   : reg_select[174] = 1'b1;
    8'd175   : reg_select[175] = 1'b1;
    8'd176   : reg_select[176] = 1'b1;
    8'd177   : reg_select[177] = 1'b1;
    8'd178   : reg_select[178] = 1'b1;
    8'd179   : reg_select[179] = 1'b1;
    8'd180   : reg_select[180] = 1'b1;
    8'd181   : reg_select[181] = 1'b1;
    8'd182   : reg_select[182] = 1'b1;
    8'd183   : reg_select[183] = 1'b1;
    8'd184   : reg_select[184] = 1'b1;
    8'd185   : reg_select[185] = 1'b1;
    8'd186   : reg_select[186] = 1'b1;
    8'd187   : reg_select[187] = 1'b1;
    8'd188   : reg_select[188] = 1'b1;
    8'd189   : reg_select[189] = 1'b1;
    8'd190   : reg_select[190] = 1'b1;
    8'd191   : reg_select[191] = 1'b1;
  endcase
end

  assign bank0_write[0]  = (reg_select[0]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[1]  = (reg_select[1]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[2]  = (reg_select[2]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[3]  = (reg_select[3]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[4]  = (reg_select[4]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[5]  = (reg_select[5]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[6]  = (reg_select[6]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[7]  = (reg_select[7]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[8]  = (reg_select[8]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[9]  = (reg_select[9]  & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[10] = (reg_select[10] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[11] = (reg_select[11] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[12] = (reg_select[12] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[13] = (reg_select[13] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[14] = (reg_select[14] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank0_write[15] = (reg_select[15] & chip_select[0] & bus2ip_wrce) ? 1'b1 : 1'b0;

  assign bank1_write[0]  = (reg_select[0]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[1]  = (reg_select[1]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[2]  = (reg_select[2]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[3]  = (reg_select[3]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[4]  = (reg_select[4]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[5]  = (reg_select[5]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[6]  = (reg_select[6]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[7]  = (reg_select[7]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[8]  = (reg_select[8]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[9]  = (reg_select[9]  & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[10] = (reg_select[10] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[11] = (reg_select[11] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[12] = (reg_select[12] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[13] = (reg_select[13] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[14] = (reg_select[14] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank1_write[15] = (reg_select[15] & chip_select[1] & bus2ip_wrce) ? 1'b1 : 1'b0;

  assign bank2_write[0]   = (reg_select[0]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[1]   = (reg_select[1]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[2]   = (reg_select[2]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[3]   = (reg_select[3]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[4]   = (reg_select[4]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[5]   = (reg_select[5]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[6]   = (reg_select[6]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[7]   = (reg_select[7]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[8]   = (reg_select[8]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[9]   = (reg_select[9]   & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[10]  = (reg_select[10]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[11]  = (reg_select[11]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[12]  = (reg_select[12]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[13]  = (reg_select[13]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[14]  = (reg_select[14]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;
  assign bank2_write[15]  = (reg_select[15]  & chip_select[2] & bus2ip_wrce) ? 1'b1 : 1'b0;

  assign bank0_read[0]  = (reg_select[0]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[1]  = (reg_select[1]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[2]  = (reg_select[2]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[3]  = (reg_select[3]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[4]  = (reg_select[4]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[5]  = (reg_select[5]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[6]  = (reg_select[6]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[7]  = (reg_select[7]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[8]  = (reg_select[8]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[9]  = (reg_select[9]  & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[10] = (reg_select[10] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[11] = (reg_select[11] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[12] = (reg_select[12] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[13] = (reg_select[13] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[14] = (reg_select[14] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank0_read[15] = (reg_select[15] & chip_select[0] & bus2ip_rdce) ? 1'b1 : 1'b0;

  assign bank1_read[0]  = (reg_select[0]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[1]  = (reg_select[1]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[2]  = (reg_select[2]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[3]  = (reg_select[3]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[4]  = (reg_select[4]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[5]  = (reg_select[5]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[6]  = (reg_select[6]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[7]  = (reg_select[7]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[8]  = (reg_select[8]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[9]  = (reg_select[9]  & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[10] = (reg_select[10] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[11] = (reg_select[11] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[12] = (reg_select[12] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[13] = (reg_select[13] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[14] = (reg_select[14] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank1_read[15] = (reg_select[15] & chip_select[1] & bus2ip_rdce) ? 1'b1 : 1'b0;

  assign bank2_read[0]   = (reg_select[0]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[1]   = (reg_select[1]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[2]   = (reg_select[2]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[3]   = (reg_select[3]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[4]   = (reg_select[4]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[5]   = (reg_select[5]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[6]   = (reg_select[6]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[7]   = (reg_select[7]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[8]   = (reg_select[8]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[9]   = (reg_select[9]   & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[10]  = (reg_select[10]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[11]  = (reg_select[11]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[12]  = (reg_select[12]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[13]  = (reg_select[13]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[14]  = (reg_select[14]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[15]  = (reg_select[15]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[16]  = (reg_select[16]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[17]  = (reg_select[17]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[18]  = (reg_select[18]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[19]  = (reg_select[19]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[20]  = (reg_select[20]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[21]  = (reg_select[21]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[22]  = (reg_select[22]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[23]  = (reg_select[23]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[24]  = (reg_select[24]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[25]  = (reg_select[25]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[26]  = (reg_select[26]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[27]  = (reg_select[27]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[28]  = (reg_select[28]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[29]  = (reg_select[29]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[30]  = (reg_select[30]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[31]  = (reg_select[31]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[32]  = (reg_select[32]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[33]  = (reg_select[33]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[34]  = (reg_select[34]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[35]  = (reg_select[35]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[36]  = (reg_select[36]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[37]  = (reg_select[37]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[38]  = (reg_select[38]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[39]  = (reg_select[39]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[40]  = (reg_select[40]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[41]  = (reg_select[41]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[42]  = (reg_select[42]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[43]  = (reg_select[43]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[44]  = (reg_select[44]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[45]  = (reg_select[45]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[46]  = (reg_select[46]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[47]  = (reg_select[47]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[48]  = (reg_select[48]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[49]  = (reg_select[49]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[50]  = (reg_select[50]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[51]  = (reg_select[51]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[52]  = (reg_select[52]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[53]  = (reg_select[53]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[54]  = (reg_select[54]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[55]  = (reg_select[55]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[56]  = (reg_select[56]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[57]  = (reg_select[57]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[58]  = (reg_select[58]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[59]  = (reg_select[59]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[60]  = (reg_select[60]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[61]  = (reg_select[61]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[62]  = (reg_select[62]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[63]  = (reg_select[63]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[64]  = (reg_select[64]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[65]  = (reg_select[65]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[66]  = (reg_select[66]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[67]  = (reg_select[67]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[68]  = (reg_select[68]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[69]  = (reg_select[69]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[70]  = (reg_select[70]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[71]  = (reg_select[71]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[72]  = (reg_select[72]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[73]  = (reg_select[73]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[74]  = (reg_select[74]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[75]  = (reg_select[75]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[76]  = (reg_select[76]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[77]  = (reg_select[77]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[78]  = (reg_select[78]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[79]  = (reg_select[79]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[80]  = (reg_select[80]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[81]  = (reg_select[81]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[82]  = (reg_select[82]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[83]  = (reg_select[83]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[84]  = (reg_select[84]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[85]  = (reg_select[85]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[86]  = (reg_select[86]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[87]  = (reg_select[87]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[88]  = (reg_select[88]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[89]  = (reg_select[89]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[90]  = (reg_select[90]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[91]  = (reg_select[91]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[92]  = (reg_select[92]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[93]  = (reg_select[93]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[94]  = (reg_select[94]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[95]  = (reg_select[95]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[96]  = (reg_select[96]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[97]  = (reg_select[97]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[98]  = (reg_select[98]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[99]  = (reg_select[99]  & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[100] = (reg_select[100] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[101] = (reg_select[101] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[102] = (reg_select[102] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[103] = (reg_select[103] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[104] = (reg_select[104] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[105] = (reg_select[105] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[106] = (reg_select[106] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[107] = (reg_select[107] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[108] = (reg_select[108] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[109] = (reg_select[109] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[110] = (reg_select[110] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[111] = (reg_select[111] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[112] = (reg_select[112] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[113] = (reg_select[113] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[114] = (reg_select[114] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[115] = (reg_select[115] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[116] = (reg_select[116] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[117] = (reg_select[117] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[118] = (reg_select[118] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[119] = (reg_select[119] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[120] = (reg_select[120] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[121] = (reg_select[121] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[122] = (reg_select[122] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[123] = (reg_select[123] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[124] = (reg_select[124] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[125] = (reg_select[125] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[126] = (reg_select[126] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[127] = (reg_select[127] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[128] = (reg_select[128] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[129] = (reg_select[129] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[130] = (reg_select[130] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[131] = (reg_select[131] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[132] = (reg_select[132] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[133] = (reg_select[133] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[134] = (reg_select[134] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[135] = (reg_select[135] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[136] = (reg_select[136] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[137] = (reg_select[137] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[138] = (reg_select[138] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[139] = (reg_select[139] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[140] = (reg_select[140] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[141] = (reg_select[141] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[142] = (reg_select[142] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[143] = (reg_select[143] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[144] = (reg_select[144] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[145] = (reg_select[145] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[146] = (reg_select[146] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[147] = (reg_select[147] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[148] = (reg_select[148] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[149] = (reg_select[149] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[150] = (reg_select[150] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[151] = (reg_select[151] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[152] = (reg_select[152] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[153] = (reg_select[153] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[154] = (reg_select[154] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[155] = (reg_select[155] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[156] = (reg_select[156] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[157] = (reg_select[157] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[158] = (reg_select[158] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[159] = (reg_select[159] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[160] = (reg_select[160] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[161] = (reg_select[161] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[162] = (reg_select[162] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[163] = (reg_select[163] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[164] = (reg_select[164] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[165] = (reg_select[165] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[166] = (reg_select[166] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[167] = (reg_select[167] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[168] = (reg_select[168] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[169] = (reg_select[169] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[170] = (reg_select[170] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[171] = (reg_select[171] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[172] = (reg_select[172] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[173] = (reg_select[173] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[174] = (reg_select[174] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[175] = (reg_select[175] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[176] = (reg_select[176] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[177] = (reg_select[177] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[178] = (reg_select[178] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[179] = (reg_select[179] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[180] = (reg_select[180] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[181] = (reg_select[181] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[182] = (reg_select[182] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[183] = (reg_select[183] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[184] = (reg_select[184] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[185] = (reg_select[185] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[186] = (reg_select[186] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[187] = (reg_select[187] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[188] = (reg_select[188] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[189] = (reg_select[189] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[190] = (reg_select[190] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;
  assign bank2_read[191] = (reg_select[191] & chip_select[2] & bus2ip_rdce) ? 1'b1 : 1'b0;

endmodule
