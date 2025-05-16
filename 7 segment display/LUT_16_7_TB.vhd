----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 09:51:04 AM
-- Design Name: 
-- Module Name: LUT_16_7_TB - Behavioral
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

entity LUT_16_7_TB is
--  Port ( );
end LUT_16_7_TB;

architecture Behavioral of LUT_16_7_TB is 
    component LUT_16_7  
        Port( 
        address : in STD_LOGIC_VECTOR(3 downto 0); 
        data : out STD_LOGIC_VECTOR(6 downto 0) 
        ); 
    end component; 
    signal address : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
    signal data : STD_LOGIC_VECTOR(6 downto 0); 
begin 
    uut:LUT_16_7 Port Map( 
    address => address, 
    data => data 
    ); 
    process begin 
    --230373 = 11 1000 0011 1110 0101 
    address <= "0101"; 
    wait for 100 ns; 
     
    address <= "1110"; 
    wait for 100 ns; 
     
    address <= "0011"; 
    wait for 100 ns; 
     
address <= "1000"; 
wait for 100 ns; 
wait; 
end process; 
end Behavioral;
