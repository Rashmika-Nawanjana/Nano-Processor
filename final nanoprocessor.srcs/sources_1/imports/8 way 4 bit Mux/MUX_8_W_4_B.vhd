----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 12:05:38 PM
-- Design Name: 
-- Module Name: MUX_8_W_4_B - Behavioral
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

entity Mux_8_W_4_B is
    Port ( 
        A0     : in  STD_LOGIC_VECTOR (3 downto 0);
        A1     : in  STD_LOGIC_VECTOR (3 downto 0);
        A2     : in  STD_LOGIC_VECTOR (3 downto 0);
        A3     : in  STD_LOGIC_VECTOR (3 downto 0);
        A4     : in  STD_LOGIC_VECTOR (3 downto 0);
        A5     : in  STD_LOGIC_VECTOR (3 downto 0);
        A6     : in  STD_LOGIC_VECTOR (3 downto 0);
        A7     : in  STD_LOGIC_VECTOR (3 downto 0);
        C_OUT  : out STD_LOGIC_VECTOR (3 downto 0);
        S      : in  STD_LOGIC_VECTOR (2 downto 0)
    );
end Mux_8_W_4_B;

architecture Behavioral of Mux_8_W_4_B is

begin

process (S, A0, A1, A2, A3, A4, A5, A6, A7)
begin
 case S is
   when "000" => C_OUT <= A0;
   when "001" => C_OUT <= A1;
   when "010" => C_OUT <= A2;
   when "011" => C_OUT <= A3;
   when "100" => C_OUT <= A4;
   when "101" => C_OUT <= A5;
   when "110" => C_OUT <= A6;
   when "111" => C_OUT <= A7;
  when others => C_OUT <= (others => '0');
 end case;
end process;  
   


end Behavioral;
