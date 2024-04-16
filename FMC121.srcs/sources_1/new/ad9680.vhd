LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;
------------------------------------------------------------------------------------------------------------

--  ****************************************************************************/
entity ad9680 is

port(
clk   :	IN	STD_LOGIC;
rstn   :	IN	STD_LOGIC;
ad_slen  :	OUT	STD_LOGIC;
ad_sclk  :	OUT	STD_LOGIC;
ad_set_finish :	OUT	STD_LOGIC;
ad_sdata :	INOUT	STD_LOGIC;
ad_sdout : out STD_LOGIC;
dir_test : out STD_LOGIC;
adc_sdio_test : out STD_LOGIC
);	
end ;
architecture MAPPED of ad9680 is


type 	 statetype is(ad_config_wait,ad_config_start,ad_idle0,ad_idle1,ad_idle2,ad_idle3,ad_wr_clkl0,ad_wr_clkl1,ad_wr_clkh0,ad_wr_clkh1,ad_config_wait1,ad_config_end,ad_config_wait2);
signal ad_status : statetype := ad_config_wait;
---------------------------parameter------------------
	signal adc_sclk		:	std_logic := '0';
	signal ad_cs_n		:	std_logic := '1';
	signal adc_sdio		:	std_logic := '0';
    
    signal BIR		:	std_logic := '0';
    signal dir		:	std_logic := '0';



	
	signal ad_config_reg			:	std_logic_vector(23 downto 0);
	signal ad_spi_reg				:	std_logic_vector(23 downto 0);
	signal con_reg_cnt	:	std_logic_vector(7 downto 0);
	signal adwr_reg_cnt			:	std_logic_vector(7 downto 0);
	

	signal delay_cnt			:	std_logic_vector(31 downto 0);
    signal NEED_DELAY			:	std_logic_vector(31 downto 0);
    --32bit 10M最大计数延迟400s 足够使用
     signal cnt_cnt			:	std_logic_vector(7 downto 0);



begin 

ad_slen  <=ad_cs_n;
ad_sclk  <=adc_sclk;
--ad_sdata <=adc_sdio;

IOBUF_inst : IOBUF
generic map (
   DRIVE => 12,
   IOSTANDARD => "DEFAULT",
   SLEW => "SLOW")
port map (
   O => ad_sdout,     -- Buffer output
   IO => ad_sdata,   -- Buffer inout port (connect directly to top-level port)
   I => adc_sdio,     -- Buffer input
   T => dir      -- 3-state enable input, high=input, low=output 
);
dir_test <= dir;
adc_sdio_test <= adc_sdio;
-----<R/W><M><P><CH>
---R/W 0=SPI WRITE 1=SPI READ
---M  0=ANALOG SPI BANK(MASTER AND ADC PAGES)   1=JESD SPI BANK(MAIN DIGITAL,JESD ANALOG,JESD DIGITAL PAGES)
---P  0=PAGE ACCESS 1=REGISTER ACCESS
---CH 0=CHANNEL A 1=CHANNEL B 

	process(clk)
	begin
		if rising_edge(clk) then
			case con_reg_cnt is
--------------------------------reset the device---------------------------------------
	
				when x"00" =>
					ad_config_reg <= x"0000" & x"81";	--复位，自动置位；需要等待5ms
					NEED_DELAY <= x"00880000";	  
					BIR <= '0';						
				when x"01" =>
					ad_config_reg <= x"0001" & x"02";	--	Datapath soft reset自动置位
					NEED_DELAY <= x"00080000";			
					BIR <= '0';	
				when x"02" =>
			      ad_config_reg <= x"0016" & x"6E";	--FD_A/GPIO_A功能；A-LMFC B-DETECT
			      NEED_DELAY <= x"00000000"; 		
			      BIR <= '0';	

				when x"03" =>
			      ad_config_reg <= x"0018" & x"40";	--Input bufer current control
			      NEED_DELAY <= x"00000000"; 		  --3X 缓冲电流
			      BIR <= '0';	
			      			      
				when x"04" =>
			      ad_config_reg <= x"0040" & x"01";	--FD_A/GPIO_A功能；A-LMFC B-DETECT
			      NEED_DELAY <= x"00000000"; 		
			      BIR <= '0';											
		      when x"05" =>
              ad_config_reg <= x"0200" & x"00"; 	--Chip real (I) only selection是否需要Q  20..
              NEED_DELAY <= x"00000000";
              BIR <= '0';
		      when x"06" =>
              ad_config_reg <= x"0201" & x"00";     --Chip decimation ratio
              NEED_DELAY <= x"00000000";
              BIR <= '0';  
		      when x"07" =>
              ad_config_reg <= x"0300" & x"00";     --Chip decimation ratio
              NEED_DELAY <= x"00000000";
              BIR <= '0';                
			  when x"08" =>
                 ad_config_reg <= x"0571" & x"14";   --JESD204B Link     Control 1
                 NEED_DELAY <= x"00000000"; 
                 BIR <= '0';        
				when x"09" =>
                     ad_config_reg <= x"0585" & x"02";    --通道1 LID值
                     NEED_DELAY <= x"00000000";             
                     BIR <= '0';                     
				when x"0A" =>
                         ad_config_reg <= x"058D" & x"13";    --K每个多帧的帧数K=20
                         NEED_DELAY <= x"00000000";         
                         BIR <= '0';   
 				when x"0B" =>
                             ad_config_reg <= x"058B" & x"03";    -- CR加扰禁用/L通道数
                             NEED_DELAY <= x"00000000";
                             BIR <= '0';      
				when x"0C" =>
                             ad_config_reg <= x"056E" & x"00";    --   lane rate ;00 
                             NEED_DELAY <= x"00000000";  
                             BIR <= '0';                                                                                                                                    
		      when x"0D" =>
			      ad_config_reg <= x"0561" & x"00";	--转换器控制位2选择
			      NEED_DELAY <= x"00000000";
			      BIR <= '0';
       
		      when x"0E" =>
			       ad_config_reg <= x"0572" & x"00";   --    10   CMOS SYNCB
			       NEED_DELAY <= x"00000000";	       --    00   LVDS SYNCB
			       BIR <= '0';                        										                                               																														  
				when x"0F" =>
					ad_config_reg <= x"0573" & x"00";	--禁用JESD数据测试模式
					NEED_DELAY <= x"00000000";
					BIR <= '0'; 

				when x"10" =>
					ad_config_reg <= x"058D" & x"13";	--  number of frames per multiframe (K)K=20
					NEED_DELAY <= x"00000000";		
					BIR <= '0';
  						
				when x"11" =>---------------------------------------------------使用或不用控制bit位
					ad_config_reg <= x"058F" & x"0F";	--Number of control bits (CS) per sample  14bit精度；默认0F 16BIT精度；8D 14BIT;默认0F
					NEED_DELAY <= x"00000000";	    
					BIR <= '0'; 
			  when x"12" =>
                                  ad_config_reg <= x"0571" & x"14";   --JESD204B Link     Control 1
                                  NEED_DELAY <= x"00080000"; 
                                  BIR <= '0'; 					
				when x"13" =>
                                 ad_config_reg <= x"05BF" & x"09";    --  摆幅350mV   
                                 NEED_DELAY <= x"00000000";        
                                 BIR <= '0';					
				when x"14" =>
                                 ad_config_reg <= x"05C1" & x"00";    --    默认 
                                 NEED_DELAY <= x"00000000";        
                                 BIR <= '0';    
--				when x"12" =>
--                                 ad_config_reg <= x"1222" & x"00";    --     
--                                 NEED_DELAY <= x"00000000";        
--                                 BIR <= '0';                                   
--				when x"13" =>
--                                ad_config_reg <= x"1222" & x"04";    --     
--                                NEED_DELAY <= x"00000000";        
--                                BIR <= '0';   
--				when x"14" =>
--                               ad_config_reg <= x"1222" & x"00";    --     
--                               NEED_DELAY <= x"00000000";        
--                               BIR <= '0';                      
--				when x"15" =>
--                               ad_config_reg <= x"1262" & x"08";    --     
--                               NEED_DELAY <= x"00000000";        
--                               BIR <= '0';                    
--				when x"16" =>
--                               ad_config_reg <= x"1262" & x"00";    --     
--                               NEED_DELAY <= x"00000000";        
--                               BIR <= '0';                                                                                                         	                        
--				when x"17" =>
--					ad_config_reg <= x"856F" & x"00";	--	PLL状态，只读	
--					NEED_DELAY <= x"00000000";		
--					BIR <= '1';
--                when x"18" =>
--                    ad_config_reg <= x"98A6" & x"00";    --    VREF
--                    NEED_DELAY <= x"00000000";        
--                    BIR <= '1';		
--                when x"19" =>
--                    ad_config_reg <= x"8592" & x"00";    --    HD value R
--                    NEED_DELAY <= x"00000000";        
--                    BIR <= '1'; 
--                when x"1A" =>
--                   ad_config_reg <= x"8591" & x"00";    --    Samples per converter frame cycle R
--                   NEED_DELAY <= x"00000000";        
--                   BIR <= '1';   
--               when x"1B" =>
--                   ad_config_reg <= x"8004" & x"00";    --    Chip ID LSB 0xD9 0xE2
--                   NEED_DELAY <= x"00000000";        
--                   BIR <= '1'; 
--               when x"1C" =>
--                   ad_config_reg <= x"8003" & x"00";    --    Chip type 0x03 High speed ADC
--                   NEED_DELAY <= x"00000000";        
--                    BIR <= '1';                                                           			
				when others =>
					ad_config_reg <= x"000000";
					NEED_DELAY <= x"00000000";
					BIR <= '0';
			end case;
		end if;
	end process;
	





	
	process(clk,rstn)
    begin
        if rstn = '0' then
            dir   <= '0';
            ad_status <= ad_config_wait;
            adc_sclk        <= '0';
            ad_cs_n        <= '1';
            adc_sdio        <= '0';
           ad_set_finish<= '0';
            ad_spi_reg            <= (others => '0');
            con_reg_cnt    <= (others => '0');
            adwr_reg_cnt        <= (others => '0');
            delay_cnt <= (others => '0');------------------------------------add
            cnt_cnt <= (others => '0');------------------------------------add
        elsif rising_edge(clk) then
            case ad_status is
                when ad_config_wait => 
                ad_set_finish<= '0';
                con_reg_cnt    <= (others => '0');
                adwr_reg_cnt        <= (others => '0');
                ad_spi_reg            <= (others => '0');
                     cnt_cnt <= (others => '0');------------------------------------add
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    
                    ad_status <= ad_config_start;    
                when ad_config_start => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    delay_cnt <= (others => '0');------------------------------------add
                    ad_status <= ad_idle0;
                when ad_idle0 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    
                    ad_status <= ad_idle1;
                when ad_idle1 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    
                    ad_status <= ad_idle2;
                when ad_idle2 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    
                    ad_status <= ad_idle3;
                when ad_idle3 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '0';
                    adc_sdio        <= '0';
                    
                    ad_spi_reg <= ad_config_reg;
                    ad_status <= ad_wr_clkl0;
                when ad_wr_clkl0 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '0';
                    adc_sdio        <= ad_spi_reg(23);
                    
                    ad_status <= ad_wr_clkl1;
                when ad_wr_clkl1 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '0';
                    adc_sdio        <= ad_spi_reg(23);
                    
                    ad_status <= ad_wr_clkh0;
                when ad_wr_clkh0 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '1';
                    ad_cs_n        <= '0';
                    adc_sdio        <= ad_spi_reg(23);
                    
                    ad_status <= ad_wr_clkh1;
                when ad_wr_clkh1 => 
                ad_set_finish<= '0';
                    adc_sclk        <= '1';
                    ad_cs_n        <= '0';
                    adc_sdio        <= ad_spi_reg(23);
                    
                    ad_spi_reg         <= ad_spi_reg(22 downto 0)&ad_spi_reg(23);
                    adwr_reg_cnt         <= adwr_reg_cnt + 1;
                    ad_status <= ad_config_wait1;    
                
                                    
                when ad_config_wait1 =>
                ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    
                --    if delay_cnt = NEED_DELAY then
                       if adwr_reg_cnt = x"18" then--是否够24bit
                        dir <=  '0';
                       
                          adwr_reg_cnt <= adwr_reg_cnt;    
                          ad_cs_n        <= '1';    
                            if delay_cnt = NEED_DELAY then          
                                   if con_reg_cnt = x"14" then--是否够寄存器数目
                                           ad_status <= ad_config_end;
                                            con_reg_cnt <= (others => '0');
                                       else
                                            ad_status <= ad_config_wait2;
                                            con_reg_cnt <= con_reg_cnt + '1';
                                    end if;
                            else
                                delay_cnt <= delay_cnt + '1'; 
                                  ad_status <= ad_config_wait1;
                            end if;      
                       else
                          if adwr_reg_cnt >= 16 then
                            dir <=  BIR;
                          else
                            dir <=  '0';  
                          end if;
                          ad_cs_n        <= '0';
                          ad_status <=  ad_wr_clkl0;
                       end if;
                --    else
                --         delay_cnt <= delay_cnt + '1'; 
                --    end if;     
                when ad_config_wait2 =>
                    ad_set_finish<= '0';
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    delay_cnt <= (others => '0');
                    adwr_reg_cnt <= (others => '0');
                    if cnt_cnt = x"08" then
                        ad_status <= ad_config_start;    
                        cnt_cnt    <=  (others => '0');    
                    else
                            ad_status <= ad_config_wait2;
                        cnt_cnt    <= cnt_cnt  + '1';                        
                    end if;
                    
                when ad_config_end =>
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    ad_set_finish<= '1';
                    con_reg_cnt    <= (others => '0');
                    adwr_reg_cnt        <= (others => '0'); 
                    ad_spi_reg            <= (others => '0');
                    ad_status <= ad_config_end;
                    delay_cnt <= (others => '0');------------------------------------add
                when others =>
                ad_set_finish<= '0';
                con_reg_cnt    <= (others => '0');
                adwr_reg_cnt        <= (others => '0'); 
                ad_spi_reg            <= (others => '0');
                    adc_sclk        <= '0';
                    ad_cs_n        <= '1';
                    adc_sdio        <= '0';
                    ad_status <= ad_config_wait;
                    delay_cnt <= (others => '0');------------------------------------add
                end case;        
        end if;
    end process;

	

end MAPPED;
