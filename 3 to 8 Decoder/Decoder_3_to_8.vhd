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
        EN : in  STD_LOGIC;
        Y  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Decoder_3_TO_8;

architecture Behavioral of Decoder_3_TO_8 is

    -- 2-to-4 decoder component
    component Decode_2_to_4
        Port (
            I  : in  STD_LOGIC_VECTOR;
            EN : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR
        );
    end component;

    -- Internal signals
    signal I0, I1       : STD_LOGIC_VECTOR(1 downto 0);
    signal Y0, Y1       : STD_LOGIC_VECTOR(3 downto 0);
    signal en0, en1     : STD_LOGIC;
    signal I2           : STD_LOGIC;

begin

    -- First 4 outputs (Y0): when MSB is 0
    Decode_2_to_4_0 : Decode_2_to_4
        port map (
            I  => I0,
            EN => en0,
            Y  => Y0
        );

    -- Second 4 outputs (Y1): when MSB is 1
    Decode_2_to_4_1 : Decode_2_to_4
        port map (
            I  => I1,
            EN => en1,
            Y  => Y1
        );

    -- Decoder logic
    en0 <= NOT(I(2)) AND EN;
    en1 <= I(2) AND EN;
    I0  <= I(1 downto 0);
    I1  <= I(1 downto 0);
    I2  <= I(2);

    -- Combine outputs
    Y(3 downto 0) <= Y0;
    Y(7 downto 4) <= Y1;

end Behavioral;

