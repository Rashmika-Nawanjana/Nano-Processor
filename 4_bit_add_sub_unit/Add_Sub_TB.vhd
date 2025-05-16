----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 12:13:23 AM
-- Design Name: 
-- Module Name: Add_Sub_TB - Behavioral
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

entity Add_Sub_TB is
--  Port ( );
end Add_Sub_TB;

architecture Behavioral of Add_Sub_TB is

component ADD_SUB is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           AddSub_Select : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal AddSub_Select : STD_LOGIC := '0';

signal Overflow : STD_LOGIC;
signal Zero : STD_LOGIC;
signal S : STD_LOGIC_VECTOR (3 downto 0);

begin

 UUT: ADD_SUB port map(
    A => A,
    B => B,
    AddSub_Select => AddSub_Select,
    Overflow => Overflow,
    Zero => Zero,
    S => S
);

process begin
    A <= "0000";
    B <= "0000";
    AddSub_Select <= '0';
    wait for 100 ns;
    
    A <= "1111";
    B <= "1111";
    AddSub_Select <= '0';
    wait for 100 ns;
    
    A <= "1011";
    B <= "0011";
    AddSub_Select <= '0';
    wait for 100 ns;
    
    A <= "1111";
    B <= "1111";
    AddSub_Select <= '1';
    wait for 100 ns;
    
    A <= "1101";
    B <= "0011";
    AddSub_Select <= '1';
    wait for 100 ns;
    
    A <= "1110";
    B <= "1000";
    AddSub_Select <= '1';
    wait for 100 ns;
    
    wait;
    
end process;

end Behavioral;
