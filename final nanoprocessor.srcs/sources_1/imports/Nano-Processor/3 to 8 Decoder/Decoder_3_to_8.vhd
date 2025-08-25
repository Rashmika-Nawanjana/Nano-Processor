----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 01:57:34 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral
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

entity Decoder_3_TO_8 is
    Port (
        I  : in  STD_LOGIC_VECTOR(2 downto 0);
        Y  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Decoder_3_TO_8;

architecture Behavioral of Decoder_3_TO_8 is

begin
process(I)
begin
    case I is
       when "000" => Y <= "00000001";
       when "001" => Y <= "00000010";
       when "010" => Y <= "00000100";
       when "011" => Y <= "00001000";
       when "100" => Y <= "00010000";
       when "101" => Y <= "00100000";
       when "110" => Y <= "01000000";
       when "111" => Y <= "10000000";
       when others => Y <= "00000000";
    end case;
end process;
    

end Behavioral;

