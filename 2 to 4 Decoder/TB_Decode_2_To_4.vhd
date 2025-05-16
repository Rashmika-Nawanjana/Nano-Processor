----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 07:44:39 PM
-- Design Name: 
-- Module Name: TB_Decode_2_To_4 - Behavioral
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

entity TB_Decode_2_To_4 is
    -- No ports needed in a testbench
end TB_Decode_2_To_4;

architecture Behavioral of TB_Decode_2_To_4 is

    -- Component declaration
    component DECODE_2_TO_4
        Port ( 
            I  : in  STD_LOGIC_VECTOR(1 downto 0);
            EN : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal i  : STD_LOGIC_VECTOR(1 downto 0);
    signal en : STD_LOGIC;
    signal y  : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Unit Under Test (UUT) instantiation
    UTT: DECODE_2_TO_4 
        port map (
            I  => i,
            EN => en,
            Y  => y
        );

    -- Stimulus process to test decoder behavior
    process
    begin
        -- Enable decoder and test all inputs
        i  <= "00";
        en <= '1';
        wait for 125 ns;

        i <= "01";
        wait for 125 ns;

        i <= "10";
        wait for 125 ns;

        i <= "11";
        wait for 125 ns;

        -- Disable decoder and repeat inputs (expect all outputs = 0000)
        en <= '0';

        i <= "00";
        wait for 125 ns;

        i <= "01";
        wait for 125 ns;

        i <= "10";
        wait for 125 ns;

        i <= "11";
        wait;  -- wait forever
    end process;

end Behavioral;


