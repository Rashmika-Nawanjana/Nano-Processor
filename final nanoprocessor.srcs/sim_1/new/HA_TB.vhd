----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2025 01:57:59 PM
-- Design Name: 
-- Module Name: HA_TB - Behavioral
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

entity HA_TB is
--  Port ( );
end HA_TB;

architecture Behavioral of HA_TB is

    component HA
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               S : out STD_LOGIC;
               C : out STD_LOGIC);
    end component;

    signal A_tb : STD_LOGIC := '0';
    signal B_tb : STD_LOGIC := '0';
    signal S_tb : STD_LOGIC;
    signal C_tb : STD_LOGIC;

begin

    uut: HA Port map (
        A => A_tb,
        B => B_tb,
        S => S_tb,
        C => C_tb
    );

    stim_proc: process
    begin
        --230373 => 111000001111100101
        -- Test case 0 + 0
        A_tb <= '0';
        B_tb <= '0';
        wait for 10 ns;

        -- Test case 0 + 1
        A_tb <= '0';
        B_tb <= '1';
        wait for 10 ns;

        -- Test case 1 + 0
        A_tb <= '1';
        B_tb <= '0';
        wait for 10 ns;

        -- Test case 1 + 1
        A_tb <= '1';
        B_tb <= '1';
        wait for 10 ns;

        wait;
    end process;


end Behavioral;
