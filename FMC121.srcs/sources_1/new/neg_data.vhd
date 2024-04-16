----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/12/22 10:18:43
-- Design Name: 
-- Module Name: neg_data - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity neg_data is
  Port ( 
   data_in : in STD_LOGIC_VECTOR ( 63 downto 0 );
  data_out : out  STD_LOGIC_VECTOR ( 63 downto 0 )
 
  );
end neg_data;

architecture Behavioral of neg_data is

begin

data_out <=  -data_in;
end Behavioral;
