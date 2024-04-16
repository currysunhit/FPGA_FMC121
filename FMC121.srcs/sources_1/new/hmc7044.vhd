LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

------------------------------------------------------------------------------------------------------------
--sysref=3.125mhz  pll=125mhz adc rate=1000mhz
--  ****************************************************************************/
entity hmc7044 is

port(
clk   :	IN	STD_LOGIC;
rst   :	IN	STD_LOGIC;
OSCON_CTRL     	    :	out STD_LOGIC;
--fpga_clk_sel  :	in STD_LOGIC;
--clk_sel  :	in STD_LOGIC;
--vco_sel  :	in STD_LOGIC;
clk_sel :	IN	STD_LOGIC_VECTOR(1 downto 0);
H7044_SLEN  :	OUT	STD_LOGIC;
H7044_SCLK  :	OUT	STD_LOGIC;
H7044_SDATA :	OUT	STD_LOGIC;
SET_FINISH :	OUT	STD_LOGIC
);	
end ;
architecture MAPPED of hmc7044 is


type 	 statetype is (config_wait,config_start,idle0,idle1,idle2,idle3,wr_clkl0,wr_clkl1,wr_clkh0,wr_clkh1,config_wait1,config_end);
signal spi_cntr_status : statetype;
---------------------------parameter------------------
	signal HMC7044_SCLK		:	std_logic;
	signal HMC7044_CS_N		:	std_logic;
	signal HMC7044_SDIO		:	std_logic;
	signal H7044_GPIO1_REG :	std_logic;	
signal H7044_GPIO2_REG :	std_logic;	
signal H7044_GPIO3_REG :	std_logic;
signal H7044_GPIO4_REG :	std_logic;

signal HMC7043_SLEN1  :		STD_LOGIC;
signal HMC7043_SCLK1  :		STD_LOGIC;
signal HMC7043_SDATA1 :		STD_LOGIC;
signal HMC7043_SLEN2  :		STD_LOGIC;
signal HMC7043_SCLK2  :		STD_LOGIC;
signal HMC7043_SDATA2 :		STD_LOGIC;
signal HMC7043_SLEN3  :		STD_LOGIC;
signal HMC7043_SCLK3  :		STD_LOGIC;
signal HMC7043_SDATA3 :		STD_LOGIC;
signal HMC7043_SLEN4  :		STD_LOGIC;
signal HMC7043_SCLK4  :		STD_LOGIC;
signal HMC7043_SDATA4 :		STD_LOGIC;

	
	signal config_reg			:	std_logic_vector(23 downto 0);
	signal spi_reg				:	std_logic_vector(23 downto 0);
	signal config_reg_cnt	:	std_logic_vector(11 downto 0);
	signal wr_reg_cnt			:	std_logic_vector(7 downto 0);
	
	signal delay_cnt			:	std_logic_vector(7 downto 0);
	
	signal rst_cnt				:	std_logic_vector(27 downto 0);
	signal reset 				:	std_logic;

    signal reg_003			:	std_logic_vector(7 downto 0);
    signal reg_005			:	std_logic_vector(7 downto 0);
    signal reg_014			:	std_logic_vector(7 downto 0);
begin  

process(clk_sel)begin
if(clk_sel= "00")then
    reg_005 <= x"41";     --CLKIN0作为PLL1参考
    reg_003 <= x"2F";      --0003VCO高电平，SYSREF、PLL2、PLL1使能
     OSCON_CTRL<= '1';
elsif(clk_sel="01")then
    reg_005 <= x"42";    --CLKIN1作为PLL1参考
    reg_003 <= x"2F";
     OSCON_CTRL<= '1';
    elsif (clk_sel="10")then
         reg_005 <= x"20";     --CLKIN1作为外部VCO
         reg_003 <= x"00";       --使用外部VCO
         OSCON_CTRL<= '0'; 
end if;
end process;



H7044_SLEN  <=HMC7044_CS_N;
H7044_SCLK  <=HMC7044_SCLK;
H7044_SDATA <=HMC7044_SDIO;



	process(clk,rst)
	begin
	   if rst = '0' then
	   config_reg <= x"0000" & x"00";	--	soft reset[0] = 0, 	
		elsif rising_edge(clk) then
			case config_reg_cnt is
				when x"000" =>

					config_reg <= x"0000" & x"00";	--	soft reset[0] = 0, 													
				when x"001" =>
				
					config_reg <= x"0001" & x"20"; 	--sleep_mode[0]=0,restart_dividers/fsm[1]=0,pulse_generator_request[2]=0,mute[3]=0,force_holdover[4]=0,high performance plls/vco[5]=0,high performance distribution path[6]=0, reseed_req[7]=0
				when x"002" =>
					config_reg <= x"0002" & x"00";	--slip_request[1]=0,pll2_autotune_trig[2]=0
				when x"003" =>
					--config_reg <= x"0003" & x"37";   --	bit0=pll1 enable bit1=pll2 enable bit2=sysref timer enable     bit[4:3]                            bit5=rf reseeder enable
					                                                                                                --  00 internal disabled/external
																																					--  01 high
																																					--  10 low
														
					config_reg <= x"0003" & reg_003; 	
--config_reg <= x"0003" & x"37";								
														
				when x"004" =>
					config_reg <= x"0004" & x"7F";	--seven pairs of 14 channel outputs enable[6:0]7F通道全使能
					                                  --bit0    enable channel 0 and channel 1
																 --bit1    enable channel 2 and channel 3
																 --bit2    enable channel 4 and channel 5
																 --bit3    enable channel 6 and channel 7
																 --bit4    enable channel 8 and channel 9
																 --bit5    enable channel 10 and channel 11
																 --bit6    enable channel 12 and channel 13
															
				when x"005" =>--使能REFCLK0/1/2/3
--					config_reg <= x"0005" & x"42";	--	pll1 reference path enable[3:0]     --bit[4] clkin0 input is used for external rf sync  
					                                  --bit0 enable clkin0 input path       --bit[5] clkin1 input is used for external vco
																 --bit1 enable clkin1 input path       --bit[7:6] sync pin mode selection 
																 --bit2 enable clkin2 input path           00 -- disable
																 --bit3 enable clkin3 input path           01 --sync.a rising edge is carried through pll2.useful for multichip synchronization
														                                               --10 --pulse generator.request a pulse generator stream from any channels configured for dynamic startup.this behaves in the same way as a gpi requested pulse generator
                                                                                         --11 causes sync if alarm exits,otherwise causes pulse generator																														  
	
					    config_reg <= x"0005" & reg_005;--1 CLK0 ;2 CLK1 
					 
				
				
				when x"006" =>
					config_reg <= x"0006" & x"00";	--
				when x"007" =>
					config_reg <= x"0007" & x"00";	--
				when x"008" =>
					config_reg <= x"0009" & x"01";	--
				when x"009" =>--CLKINx/CLKINx和OSCIN/OSCIN输入缓冲器控制
					config_reg <= x"000A" & x"07";	--    input buffer mode[4:1]------bit[3:0] bit0---enable internal 100ohm termination    bufer enable[0] 
				when x"00A" =>
					config_reg <= x"000B" & x"07";	--		07使能输入缓冲器、使能内部100欧端接、使能AC耦合模式bit1---enable ac coupling input mode
				when x"00B" =>
					config_reg <= x"000C" & x"07";	--		                                     bit2---enable lvpecl input mode
				when x"00C" =>
					config_reg <= x"000D" & x"07";	--	                                        bit3---enable high-z input mode						
				when x"00D" =>
					config_reg <= x"000E" & x"07";	--	       A-E FOR CLKINX AND OSCIN INPUT BUFFER CONTROL    oscin                               
				when x"00E" =>--PLL1参考信号优先级控制 固定CLK0 200MHZ
					config_reg <= x"0014" & x"00";	--      input clk priority PLL1参考信号优先级控制
					
				when x"00F" =>
					config_reg <= x"0015" & x"03";	        --los validation[2:0]  8个周期
					                                                 ---000 none
																					 ---001 2 cycles
																					 ---010 4 cycles
																					 ---011 8 cycles
																					 ---100 16 cycles
																					 ---101 32 cycles
																					 ---110 64 cycles
																					 ---111 128 cycles
				when x"010" =>
					config_reg <= x"0016" & x"0C";	--     holdover exit criteria[1:0] criteria the pll1 fsm uses to exit holdover time
					                                           -- 00 exit holdover when los is gone
																			 -- 01 exit holdover when phase error=0
																			 -- 11 exit holdover immediately
										                   -- holdover exit action[3:2]
																			 -- 00 reset dividers
																			 -- 01 do nothing
																			 -- 10 do nothing
																			 -- 11 dac assist
																			 
				when x"011" =>
					config_reg <= x"0017" & x"00";	--  holdover dac value[6:0]
				when x"012" => 
					config_reg <= x"0018" & x"04";	--  
						
				when x"013" =>
					config_reg <= x"0019" & x"00";		--bit[0] los uses vcxo prescaler for very low pfd rates,cascades vcxo lcm divider after n1
					                                   --bit[1] los bypass input prescaler ,bypass lcm r divide cascade,r1 input is the selected clkinx
				when x"014" =>
					config_reg <= x"001A" & x"08";	    ---pll1 cp current[3:0]
				when x"015" =>
					config_reg <= x"001B" & x"18";	   --PLL1 PFD上升和下降使能，PFD正极性
					                                      --bit[0] select pfd polarity               0---positive  1-----negative
					                                    --bit[1] pll1 pfd down force,force pll1 charge pump down,do not asert simultaneously with pll1 pfd up force
																	--bit[2] pll1 pfd up force,force pll1 charge pump up,do not asert simultaneously with pll1 pfd down force
																	--bit[3] pll1 pfd down enable
																	--bit[4] pll1 pfd up enable
				when x"016" =>--P
					config_reg <= x"001C" & x"02";		---clk0 input prescaler[7:0]
				when x"017" =>
					config_reg <= x"001D" & x"01";		---clk1 input prescaler[7:0]
				when x"018" =>
					config_reg <= x"001E" & x"01";		 ---clk2 input prescaler[7:0]
				when x"019" =>
					config_reg <= x"001F" & x"01";		---clk3 input prescaler[7:0]
				when x"01A" =>--oscin
					config_reg <= x"0020" & x"01";		---oscin input prescaler[7:0]	
				when x"01B" =>--R1
				--	config_reg <= x"0021" & x"04";	  --R1 DIVIDER[7:0]	

					    config_reg <= x"0021" & x"04";--16位R1分频器设定点
					
				when x"01C" =>--R1
					config_reg <= x"0022" & x"00";	  --R1 DIVIDER[15:8]		
				when x"01D" =>--N1
				--	config_reg <= x"0026" & x"04";		--N1 DIVIDER[7:0]	
				 
					    config_reg <= x"0026" & x"04";

				when x"01E" =>
					config_reg <= x"0027" & x"00";		--N1 DIVIDER[15:8]			
				when x"01F" =>
					config_reg <= x"0028" & x"0F";		--2的15次方个周期  [4:0] PLL1 LOCK DETECT TIME[4:0], BIT5 PLL1 LOCK DETECT USES SLIP
				when x"020" =>
					config_reg <= x"0029" & x"05";			-- BIT 0  AUTOMODE REFERENCE SWITCHING,CLOCK SWITCHING IS AUTOMATIC BASED ON LOS/PLL1 REFERENCE PRIORITY CONTROL REGISTER(0X14 REGISTER)
				                                          -- BIT 1  AUTOREVERTIVE REFERENCE SWITCHING,REVERT TO PLL1 BEST CLOCK OPTION IF IT BECOMES AVAILABLE AGAIN
				                                          -- BIT 2  HOLDOVER USES DAC,IN HOLDOVER,SELECT WHETHER PLL1 USES THE DAC OR TRISTATE THE CHARGE PUMP
				                                          -- BIT [4:3} MANUAL MODE REFERENCE SWITCHING[1:0] IF AUTOMODE REF SWITCHING=0,MANUAL SELECTION OF CLKINX INPUT
				when x"021" =>														--BIT5 BYPASS DEBOUNCER,BYPASS THE DEBOUNCER IN MANUAL MODE AND GPI CLOCK/HOLDOVER SELECTION
					
					config_reg <= x"002A" & x"00";	   --holdoff time[7:0]
					
				when x"022" =>
					config_reg <= x"0031" & x"01";	--
				when x"023" =>--旁路倍频器
					config_reg <= x"0032" & x"01";	--  旁路倍频器   bit[0] bypass frequency doubler, 0---enable frequency doubler before r2 divider ,1----bypass frequency doubler
					
				when x"024" =>--R2
					config_reg <= x"0033" & x"04";	--R2是4分频12bit r2 divider[7:0]
				when x"025" =>
					config_reg <= x"0034" & x"00";	--[3:0]======r2 divider[11:8]
				when x"026" =>--N2=120=3G   N2=120
				--	config_reg <= x"0035" & x"18";	--12bit n2 divider[7:0]

					  config_reg <= x"0035" & x"78";--3G
					     
				when x"027" =>
					config_reg <= x"0036" & x"00";	--[3:0]======n2 divider[11:8]
				when x"028" =>
					config_reg <= x"0037" & x"0F";	--[3:0]=======pll2 cp current[3:0]	2560微安
				when x"029" =>
					config_reg <= x"0038" & x"18";	--bit0 pll2 pfd polarity sel    bit1=pll2 pfd down force            bit2=pll2 pfd up force              bit3=pll2 pfd down enable    bit4=pll2 pfd up enable
					                                  --- 0  positive                --force pll2 charge pump down,   --force pll2 charge pump up,
																 --- 1  negative                --do not assert simultaneously   --do not assert simultaneously
					                                                                 --with pll2 pfd up force          --with pll2 pfd down force
					
					
				when x"02A" =>
					config_reg <= x"0039" & x"03";	  --03震荡器2分频oscoutx path enable[0]=0x1, oscoutx divider ratio [2:1]
					                                                                --00 divide by 1
                                                                               --01 divide by 2
                                                                               --10 divide by 4
                                                                               --11 divide by 8																										 
				when x"02B" =>
					config_reg <= x"003A" & x"11";	--oscout0 driver enable[0]=0x1,    oscout0 driver impedance selection for cml[2:1]        oscout0 driver mode[5:4]
					                                  --LVPECL模式--使能振荡器驱动器                       --00 internal resistor disable                            --00 cml mode
																										  --01 internal 100ohm resistor enable per output pin       --01 lvpecl mode
																										  --10 reserved                                             --10 lvds mode
																										  -- 11 internal 50 ohm resistor enable per output          --11 cmos mode
				when x"02C" =>
					config_reg <= x"003B" & x"11";	----oscout1 driver enable[0]=0x1, oscout1 driver impedance[2:1],                 oscout1 driver mode[5-4]
				when x"02D" =>
					config_reg <= x"0046" & x"00";     ---gpix control , bit[0] gpix enable,gpix selection[4:1] 
				when x"02E" =>
					config_reg <= x"0047" & x"00";	 --gpix
				when x"02F" =>
					config_reg <= x"0048" & x"00";    --gpix
				when x"030" =>
					config_reg <= x"0049" & x"00";	 --gpix
				when x"031" =>
				
					config_reg <= x"0050" & x"7F";	--GPOx使能，CMOS模式，强制1至GPO；gpox control gpox selection[7:2],bit[1] 0 for open drain mode 1 for cmos mode, bit[0] gpox driver enable
				when x"032" =>
					config_reg <= x"0051" & x"2B";	--gpox control来自PLL2的PLL2锁定检测信号
				when x"033" =>
					config_reg <= x"0052" & x"7F";	--gpox control
				when x"034" =>
					config_reg <= x"0053" & x"7F";	--gpox control
				when x"035" =>
					config_reg <= x"0054" & x"03";	--SDATA驱动器CMOS模式；bit[0] sdata enable  bit[1] sdata mode, 0 for open drain mode 1 for cmos mode
				when x"036" =>
					config_reg <= x"005A" & x"00";	--bit[2:0] pulse generator mode selection
				when x"037" =>
					config_reg <= x"005B" & x"06";	--bit[0] sync polarity 0 for positive 1 for negative ,if not using clkin0 as input,must be 0
					                                 --bit[1]	 sync through pll2
																--bit[2]	 sync retime  0 for bypass the retime(if using sync path with onchip vco),1 for retime the external sync from reference 0
																
				when x"038" =>
					config_reg <= x"005C" & x"00";	 --sysref timer[7:0]
				when x"039" =>
					config_reg <= x"005D" & x"01";	 --bit[3:0] for sysref timer[11:8]
				when x"03A" =>
					config_reg <= x"0064" & x"00";	 --bit[0] low frequency external vco path bit[1] divide by 2 on external vco enable
				when x"03B" =>
					config_reg <= x"0065" & x"00";	 ---bit[0] analog delay low power mode
				when x"03C" =>
					config_reg <= x"0070" & x"00";	--pll1 alarm  mask control
				when x"03D" =>
					config_reg <= x"0071" & x"10";	--alarm  mask control允许同步请求信号生成警报信号
				when x"03E" =>
					config_reg <= x"0078" & x"08";	---only read
				when x"03F" =>
					config_reg <= x"0079" & x"09";	---only read
				when x"040" =>
					config_reg <= x"007A" & x"0A";	---only read
				when x"041" =>
					config_reg <= x"007B" & x"01";	---only read
				when x"042" =>
					config_reg <= x"007C" & x"0C";	----only read
				when x"043" =>
					config_reg <= x"007D" & x"0D";	---only read
				when x"044" =>
					config_reg <= x"007E" & x"0E";	---only read
				when x"045" =>
					config_reg <= x"0082" & x"0F";	---only read
				when x"046" =>
					config_reg <= x"0083" & x"10";	---only read	

           	when x"047" =>
					config_reg <= x"0084" & x"11";	---only read
				when x"048" =>
					config_reg <= x"0085" & x"00";	---only read
				when x"049" =>
					config_reg <= x"0086" & x"00";	---only read
				when x"04A" =>
					config_reg <= x"008C" & x"02";	---only read
				when x"04B" =>
					config_reg <= x"008D" & x"03";	---only read
				when x"04C" =>
					config_reg <= x"008E" & x"04";	---only read
				when x"04D" =>
					config_reg <= x"008F" & x"05";	---only read
				when x"04E" =>
					config_reg <= x"0091" & x"06";	---only read
				when x"04F" =>
					config_reg <= x"0096" & x"00";	--reserved
				when x"050" =>
					config_reg <= x"0097" & x"00";	--reserved
				when x"051" =>
					config_reg <= x"0098" & x"00";	--reserved
				when x"052" =>
					config_reg <= x"0099" & x"00";	--reserved
				when x"053" =>
					config_reg <= x"009A" & x"00";	--reserved
				when x"054" =>
					config_reg <= x"009B" & x"AA";	--reserved	

                   	when x"055" =>
					config_reg <= x"009C" & x"AA";	 --reserved
				when x"056" =>
					config_reg <= x"009D" & x"AA";	--reserved
				when x"057" =>
					config_reg <= x"009E" & x"AA";	--reserved
				when x"058" =>
					config_reg <= x"009F" & x"4D";	---clock output driver low power setting(set to 0x4d instead of default value)
				when x"059" =>
					config_reg <= x"00A0" & x"DF";	---clock output driver high power setting(set to 0xdf instead of default value)
				when x"05A" =>
					config_reg <= x"00A1" & x"97";	--reserved
				when x"05B" =>
					config_reg <= x"00A2" & x"03";	--reserved
				when x"05C" =>
					config_reg <= x"00A3" & x"00";	--reserved
				when x"05D" =>
					config_reg <= x"00A4" & x"00";	--reserved
				when x"05E" =>
					config_reg <= x"00A5" & x"06";	--pll1 more delay(pfd1,lock detect)(set to 0x06 instead of default value)
				when x"05F" =>
					config_reg <= x"00A6" & x"1C";	--reserved
				when x"060" =>
					config_reg <= x"00A7" & x"00";	--reserved
				when x"061" =>
					config_reg <= x"00A8" & x"06";	--pll1 holdover dac gm setting(set to 0x06 instead of default value)
				when x"062" =>
					config_reg <= x"00A9" & x"00";	--reserved


                   	when x"063" =>
					config_reg <= x"00AB" & x"00";	--reserved
				when x"064" =>
					config_reg <= x"00AC" & x"20";	--reserved
				when x"065" =>
					config_reg <= x"00AD" & x"00";	--reserved
				when x"066" =>
					config_reg <= x"00AE" & x"08";	--reserved
				when x"067" =>
					config_reg <= x"00AF" & x"50";	--reserved
				when x"068" =>
					config_reg <= x"00B0" & x"04";	--vtune preset setting(set to 0x04 instead of default value)
				when x"069" =>
					config_reg <= x"00B1" & x"0D";	--reserved
				when x"06A" =>
					config_reg <= x"00B2" & x"00";	--reserved
				when x"06B" =>
					config_reg <= x"00B3" & x"00";	--reserved
				when x"06C" =>
					config_reg <= x"00B5" & x"00";	---reserved-
				when x"06D" =>
					config_reg <= x"00B6" & x"00";	--reserved
				when x"06E" =>
					config_reg <= x"00B7" & x"00";	--reserved
				when x"06F" =>
					config_reg <= x"00B8" & x"00";	--reserved
				when x"70" =>--ADC_CLK+ 2.6G
					config_reg <= x"00C8" & x"F3";	 --channel 0    BIT0使能
--					                                  ---bit 0
--																 ---bit 1
--																 ---bit[3:2]
--																 -- bit 5
--																 ---bit 6 
--																 -- bit 7
		      when x"71" =>--分频器支持2到4094，奇数分频比为1、 3、 5
				   config_reg <= x"00C9" & x"03";	-- 3分频 12bit channel divider[7:0]  ADC1 1G
--         --    config_reg <= x"00C9" & x"4B";	-- 12bit channel divider[7:0]
--			        if freq_sel(1 downto 0)="00" then
--					      config_reg <= x"00C9" & x"1E";
--					  elsif freq_sel(1 downto 0)="01" then
--					      config_reg <= x"00C9" & x"1E";
--					  elsif freq_sel(1 downto 0)="10" then
--					      config_reg <= x"00C9" & x"28";
--					  elsif freq_sel(1 downto 0)="11" then
--					      config_reg <= x"00C9" & x"28"; ---60mhz
--					  end if;
--               
				when x"72" =>
					config_reg <= x"00CA" & x"00";	--bit[3:0] for 12bit channel divider[11:8]
				when x"73" =>
					config_reg <= x"00CB" & x"00";	---bit[4:0] fine analog delay,  24 step,step size =25ps
				when x"74" =>
					config_reg <= x"00CC" & x"00";	---bit[4:0] coarse digital delay,  17 step,step size =1/2 vco cycle
				when x"75" =>
					config_reg <= x"00CD" & x"00";	---multislip digital delay[7:0]
				when x"76" =>
					config_reg <= x"00CE" & x"00";	---bit[3:0] for multislip digital delay[11:8]
				when x"77" =>
					config_reg <= x"00CF" & x"00";	--bit[1:0] for out mux selection   --00  channel divider output
--					                                                                    --01  analog delay output
--																											  --10  other channel of the clock group pair
--																											  --11  input vco clock(fundamental).fundamental can also be generated with 12bit channel divider[11:0]=1
				when x"78" =>--输出驱动器模式选择。00 CML 10 LVDS 08 ECL
					config_reg <= x"00D0" & x"01";	-- LVds   force mute  [1:0]      --00  normal mode(sel for dclk)
--					                                                               --01  reserved
--																										--10   froce to logic 0
--																										--11  force output to float,goes naturally to vcm
				when x"079" =>--只关心1使能，2分频比，9 LVDS；
					config_reg <= x"00D2" & x"F3";	--channel1 on
				when x"07A" =>
				   config_reg <= x"00D3" & x"E0";	--         40分频    AD SYSREF 6M
				when x"07B" =>
				   config_reg <= x"00D4" & x"01";	 --             
				when x"07C" =>
					config_reg <= x"00D5" & x"00";	
				when x"07D" =>
					config_reg <= x"00D6" & x"00";	
				when x"07E" =>
					config_reg <= x"00D7" & x"00";								
		      when x"07F" =>
					config_reg <= x"00D8" & x"00";	
				when x"080" =>
					config_reg <= x"00D9" & x"00";	
				when x"081" =>
					config_reg <= x"00DA" & x"01";	
				when x"082" =>
					config_reg <= x"00DC" & x"F3";	--channel2  On
				when x"083" =>
					config_reg <= x"00DD" & x"03";	   --DAC 
				when x"084" =>
					config_reg <= x"00DE" & x"00";	
				when x"085" =>
					config_reg <= x"00DF" & x"00";	
				when x"086" =>
					config_reg <= x"00E0" & x"00";	
				when x"087" =>
					config_reg <= x"00E1" & x"00";	
				when x"088" =>
					config_reg <= x"00E2" & x"00";	--
				when x"089" =>
					config_reg <= x"00E3" & x"00";	
				when x"08A" =>
					config_reg <= x"00E4" & x"10";	
				when x"08B" =>
					config_reg <= x"00E6" & x"F3";  --channel3	 CLK3 DA_SYSREF
				when x"08C" =>	
					config_reg <= x"00E7" & x"00";--原100M 
				when x"08D" =>
					config_reg <= x"00E8" & x"0C";	
				when x"08E" =>
					config_reg <= x"00E9" & x"00";	
				when x"08F" =>
					config_reg <= x"00EA" & x"00";	
				when x"090" =>
					config_reg <= x"00EB" & x"00";	
				when x"091" =>
					config_reg <= x"00EC" & x"00";	
				when x"092" =>
					config_reg <= x"00ED" & x"00";	
				when x"093" =>
					config_reg <= x"00EE" & x"10";	--LVDS
---------------------------------------------------------------------------------------
				when x"094" =>
					config_reg <= x"00F0" & x"F3";	--channel4   ADC sysref FPGA 
				when x"095" =>
					config_reg <= x"00F1" & x"E0";   --  "1E0" d480  3000/480=6.25M
				when x"096" =>
					config_reg <= x"00F2" & x"01";	--
				when x"097" =>
					config_reg <= x"00F3" & x"00";	
				when x"098" =>
					config_reg <= x"00F4" & x"00";	
				when x"099" =>
					config_reg <= x"00F5" & x"00";	
				when x"09A" =>
					config_reg <= x"00F6" & x"00";						
				when x"09B" =>
					config_reg <= x"00F7" & x"00";	
				when x"09C" =>
					config_reg <= x"00F8" & x"10";	--LVDS
				when x"09D" =>
					config_reg <= x"00FA" & x"F3";	--channel5   DAC SRSREF FPGA
				when x"09E" =>				  
					config_reg <= x"00FB" & x"00";
				when x"09F" =>				 
					config_reg <= x"00FC" & x"0C";	
				when x"0A0" =>
					config_reg <= x"00FD" & x"00";	
				when x"0A1" =>
					config_reg <= x"00FE" & x"00";	
				when x"0A2" =>
					config_reg <= x"00FF" & x"00";	
				when x"0A3" =>
					config_reg <= x"0100" & x"00";	
				when x"0A4" =>
					config_reg <= x"0101" & x"00";	--
				when x"0A5" =>
					config_reg <= x"0102" & x"10";	--LVDS
				when x"0A6" =>
					config_reg <= x"0104" & x"F3";	--channel6    GLB 250M
				when x"0A7" =>					  
					config_reg <= x"0105" & x"0C";  --12分频
				when x"0A8" =>
					config_reg <= x"0106" & x"00";						
				when x"0A9" =>
					config_reg <= x"0107" & x"00";	
				when x"0AA" =>
					config_reg <= x"0108" & x"00";	
				when x"0AB" =>
					config_reg <= x"0109" & x"00";	
				when x"0AC" =>
					config_reg <= x"010A" & x"00";	
				when x"0AD" =>
					config_reg <= x"010B" & x"00";	
				when x"0AE" =>
					config_reg <= x"010C" & x"10";	
				when x"0AF" =>
					config_reg <= x"010E" & x"F3";	--channel7    GLB 250M??
				when x"0B0" =>
					
					      config_reg <= x"010F" & x"0C";

				when x"0B1" =>
						
					      config_reg <= x"0110" & x"00";

				when x"0B2" =>
					config_reg <= x"0111" & x"00";	--
				when x"0B3" =>
					config_reg <= x"0112" & x"00";	
				when x"0B4" =>
					config_reg <= x"0113" & x"00";	
				when x"0B5" =>
					config_reg <= x"0114" & x"00";	
				when x"0B6" =>
					config_reg <= x"0115" & x"00";	
					
				when x"0B7" =>
					config_reg <= x"0116" & x"10";	
				when x"0B8" =>
					config_reg <= x"0118" & x"F2";	--channel8 
				when x"0B9" =>
					config_reg <= x"0119" & x"0C";
				when x"0BA" =>
					config_reg <= x"011A" & x"00";	
				when x"0BB" =>
					config_reg <= x"011B" & x"00";	
				when x"0BC" =>
					config_reg <= x"011C" & x"00";	
				when x"0BD" =>
					config_reg <= x"011D" & x"00";	
				when x"0BE" =>
					config_reg <= x"011E" & x"00";	
				when x"0BF" =>
					config_reg <= x"011F" & x"00";	
				when x"0C0" =>
					config_reg <= x"0120" & x"01";	--LVDS
				when x"0C1" =>
					config_reg <= x"0122" & x"F2";	--channel9 OFF
				when x"0C2" =>
						
					      config_reg <= x"0123" & x"1E";--100M

				when x"0C3" =>
					
					      config_reg <= x"0124" & x"00";

				when x"0C4" =>
					config_reg <= x"0125" & x"00";	
				when x"0C5" =>
					config_reg <= x"0126" & x"00";	
					
				when x"0C6" =>
					config_reg <= x"0127" & x"00";	
				when x"0C7" =>
					config_reg <= x"0128" & x"00";	
				when x"0C8" =>
					config_reg <= x"0129" & x"00";	
				when x"0C9" =>
					config_reg <= x"012A" & x"10";	--LVDS
				when x"0CA" =>
					config_reg <= x"012C" & x"F2";	--channel10 
				when x"0CB" =>

					      config_reg <= x"012D" & x"0C";

				when x"0CC" =>
					config_reg <= x"012E" & x"00";	
				when x"0CD" =>
					config_reg <= x"012F" & x"00";	
				when x"0CE" =>
					config_reg <= x"0130" & x"00";	
				when x"0CF" =>
					config_reg <= x"0131" & x"00";	--
				when x"0D0" =>
					config_reg <= x"0132" & x"00";	
				when x"0D1" =>
					config_reg <= x"0133" & x"00";	
				when x"0D2" =>
					config_reg <= x"0134" & x"01";	--LVDS
				when x"0D3" =>
					config_reg <= x"0136" & x"F2";	--channel11 OFF
					
					
				when x"0D4" =>

					      config_reg <= x"0137" & x"C0";

				when x"0D5" =>

					      config_reg <= x"0138" & x"03";
	
				when x"0D6" =>
					config_reg <= x"0139" & x"00";	
				when x"0D7" =>
					config_reg <= x"013A" & x"00";	
				when x"0D8" =>
					config_reg <= x"013B" & x"00";	
				when x"0D9" =>
					config_reg <= x"013C" & x"00";	
				when x"0DA" =>
					config_reg <= x"013D" & x"00";	
				when x"0DB" =>
					config_reg <= x"013E" & x"10";	--LVDS
				when x"0DC" =>
					config_reg <= x"0140" & x"F3";	--channel12   gtx1
				when x"0DD" =>

					      config_reg <= x"0141" & x"0C"; --12分频 ---250MHZ
					
				when x"0DE" =>
					config_reg <= x"0142" & x"00";	
				when x"0DF" =>
					config_reg <= x"0143" & x"00";	
				when x"0E0" =>
					config_reg <= x"0144" & x"00";	
				when x"0E1" =>
					config_reg <= x"0145" & x"00";	
					
				when x"0E2" =>
					config_reg <= x"0146" & x"00";	
				when x"0E3" =>
					config_reg <= x"0147" & x"00";	
				when x"0E4" =>
					config_reg <= x"0148" & x"10";	
				when x"0E5" =>
					config_reg <= x"014A" & x"F3";	--channel13  gtx2 24分频125MHz
				when x"0E6" =>
						
					      config_reg <= x"014B" & x"0C";   --
	
				when x"0E7" =>
					 
					      config_reg <= x"014C" & x"00";
	
				when x"0E8" =>
					config_reg <= x"014D" & x"00";	
				when x"0E9" =>
					config_reg <= x"014E" & x"00";	
				when x"0EA" =>
					config_reg <= x"014F" & x"00";	
				when x"0EB" =>
					config_reg <= x"0150" & x"00";	--
				when x"0EC" =>
					config_reg <= x"0151" & x"00";	
				when x"0ED" =>
					config_reg <= x"0152" & x"01";	
			   when x"0EE" =>
				   config_reg <= x"0050" & x"37";
			  	when x"0EF" =>
				   config_reg <= x"0050" & x"37";
				when x"0F0" =>
				   config_reg <= x"0050" & x"37";
				when x"0F1" =>
				   config_reg <= x"0050" & x"37";
				when x"0F2" =>
				   config_reg <= x"0050" & x"37";
				when x"0F3" =>
					config_reg <= x"0001" & x"62";	
				when x"0F4" =>
					config_reg <= x"0001" & x"60";
				when x"0F5" =>
					config_reg <= x"0001" & x"E0";	
				when x"0F6" =>
					config_reg <= x"0001" & x"60";
----------------------------adc12j4000-----------------------------------------------
--***********************************************************************************

					
				when others =>
					config_reg <= x"000000";
			end case;
		end if;
	end process;
	
	process(clk,rst)
	begin
		if rst = '0' then
			spi_cntr_status <= config_wait;
			HMC7044_SCLK		<= '0';
			HMC7044_CS_N		<= '1';
			HMC7044_SDIO		<= '0';
			SET_FINISH<='0';
        delay_cnt<= (others => '0');
			spi_reg			<= (others => '0');
			config_reg_cnt	<= (others => '0');
			wr_reg_cnt		<= (others => '0');
		elsif rising_edge(clk) then
			case spi_cntr_status is
				when config_wait => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					
					spi_cntr_status <= config_start;	
				when config_start => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					
					spi_cntr_status <= idle0;
				when idle0 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					
					spi_cntr_status <= idle1;
				when idle1 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					
					spi_cntr_status <= idle2;
				when idle2 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					
					spi_cntr_status <= idle3;
				when idle3 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '0';
					HMC7044_SDIO		<= '0';
					
					spi_reg <= config_reg;
					spi_cntr_status <= wr_clkl0;
				when wr_clkl0 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '0';
					HMC7044_SDIO		<= spi_reg(23);
					
					spi_cntr_status <= wr_clkl1;
				when wr_clkl1 => 
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '0';
					HMC7044_SDIO		<= spi_reg(23);
					
					spi_cntr_status <= wr_clkh0;
				when wr_clkh0 => 
					HMC7044_SCLK		<= '1';
					HMC7044_CS_N		<= '0';
					HMC7044_SDIO		<= spi_reg(23);
					
					spi_cntr_status <= wr_clkh1;
				when wr_clkh1 => 
					HMC7044_SCLK		<= '1';
					HMC7044_CS_N		<= '0';
					HMC7044_SDIO		<= spi_reg(23);
					
					spi_reg 		<= spi_reg(22 downto 0)&spi_reg(23);
					wr_reg_cnt 		<= wr_reg_cnt + 1;
					spi_cntr_status <= config_wait1;			
				when config_wait1 =>
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '0';
					if wr_reg_cnt = x"18" then
						wr_reg_cnt <= (others => '0');	
				 
						if config_reg_cnt = x"0F6" then
							spi_cntr_status <= config_end;
							config_reg_cnt <= (others => '0');
						else
--						   if delay_cnt=x"f0" then
--							delay_cnt<= (others => '0');
							spi_cntr_status <= config_start;
							config_reg_cnt <= config_reg_cnt + 1;
--							else
--							spi_cntr_status <= config_wait1;
--							delay_cnt<=delay_cnt+1;
--							end if;
						end if;
					else
						spi_cntr_status <= wr_clkl0;
					end if;
					
				when config_end =>
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					SET_FINISH<='1';
					
					spi_cntr_status <= config_end;
				when others =>
					HMC7044_SCLK		<= '0';
					HMC7044_CS_N		<= '1';
					HMC7044_SDIO		<= '0';
					spi_cntr_status <= config_wait;
				end case;		
		end if;
	end process;
	                 
				   

                 
 -------------------------------------------------------------------------

end MAPPED;