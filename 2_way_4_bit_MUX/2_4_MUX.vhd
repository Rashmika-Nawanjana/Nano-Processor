----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:03:55 AM
-- Design Name: 
-- Module Name: 2_4_MUX - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity w2_4_MUX is
    Port ( Load_Select : in STD_LOGIC;
           Immediate : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (3 downto 0);
           Value_In : out STD_LOGIC_VECTOR (3 downto 0));
end w2_4_MUX;

architecture Behavioral of w2_4_MUX is

begin
process(Load_Select, Immediate, S)
begin
    if (Load_Select = '0') then
        Value_In <= S;
    else
        Value_In <= Immediate;
    end if;
end process;


end Behavioral;
