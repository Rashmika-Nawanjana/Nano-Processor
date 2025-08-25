----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 01:23:15 PM
-- Design Name: 
-- Module Name: Tri_State_Buffer_4_B - Behavioral
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

entity Tri_State_Buffer_4_B is
    Port ( 
        data_in  : in  STD_LOGIC_VECTOR (3 downto 0);
        enable   : in  STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Tri_State_Buffer_4_B;

architecture Behavioral of Tri_State_Buffer_4_B is
begin
    data_out <= data_in when enable = '1' else (others => 'Z');
end Behavioral;

