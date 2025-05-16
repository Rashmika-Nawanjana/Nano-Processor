----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 08:22:04 PM
-- Design Name: 
-- Module Name: TB_Decode_3_To_8 - Behavioral
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

entity TB_Decode_3_To_8 is
    -- No ports for testbench
end TB_Decode_3_To_8;

architecture Behavioral of TB_Decode_3_To_8 is

    -- Component declaration
    component DECODER_3_TO_8
        Port ( 
            I  : in  STD_LOGIC_VECTOR(2 downto 0);
            EN : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal i  : STD_LOGIC_VECTOR(2 downto 0);
    signal en : STD_LOGIC;
    signal y  : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Unit Under Test (UUT) instantiation
    UTT: DECODER_3_TO_8 
        port map (
            I  => i,
            EN => en,
            Y  => y
        );

    -- Stimulus process to simulate the decoder
    process
    begin
        -- EN = 1, test various inputs
        i  <= "111";
        en <= '1';
        wait for 100 ns;

        i <= "110";
        wait for 100 ns;

        i <= "101";
        wait for 100 ns;

        i <= "100";
        wait for 100 ns;

        i <= "011";
        en <= '0';  -- Disable decoder
        wait for 100 ns;

        i <= "010";
        wait for 100 ns;

        i <= "001";
        wait for 100 ns;

        i <= "000";
        wait;  -- Wait forever
    end process;

end Behavioral;

