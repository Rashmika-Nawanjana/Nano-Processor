----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2025 06:19:07 PM
-- Design Name: 
-- Module Name: TB_Bitwise_operator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity tb_Bitwise_operator is
end tb_Bitwise_operator;

architecture Behavioral of tb_Bitwise_operator is

    -- Component Declaration
    component Bitwise_operator
        Port (
            A          : in  STD_LOGIC_VECTOR(3 downto 0);
            B          : in  STD_LOGIC_VECTOR(3 downto 0);
            Bit_Select : in  STD_LOGIC_VECTOR(1 downto 0);
            Bit_Out    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals
    signal A          : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B          : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Bit_Select : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal Bit_Out    : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Bitwise_operator
        port map (
            A => A,
            B => B,
            Bit_Select => Bit_Select,
            Bit_Out => Bit_Out
        );

    -- Test Process
    stim_proc: process
    begin
        -- Test NOT A
        A <= "1010";
        B <= "0000";  -- unused
        Bit_Select <= "00";
        wait for 10 ns;

        -- Test A AND B
        A <= "1100";
        B <= "1010";
        Bit_Select <= "01";
        wait for 10 ns;

        -- Test A OR B
        A <= "0101";
        B <= "0011";
        Bit_Select <= "10";
        wait for 10 ns;

        -- Test A XOR B
        A <= "1001";
        B <= "1100";
        Bit_Select <= "11";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
