library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Decode_3_To_8 is
end TB_Decode_3_To_8;

architecture Behavioral of TB_Decode_3_To_8 is

    -- Component declaration matches the decoder without EN
    component Decoder_3_TO_8
        Port (
            I  : in  STD_LOGIC_VECTOR(2 downto 0);
            Y  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for testing
    signal i : STD_LOGIC_VECTOR(2 downto 0);
    signal y : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Decoder_3_TO_8
        port map (
            I => i,
            Y => y
        );

    -- Stimulus process
    process
    begin
        i <= "000";
        wait for 100 ns;

        i <= "001";
        wait for 100 ns;

        i <= "010";
        wait for 100 ns;

        i <= "011";
        wait for 100 ns;

        i <= "100";
        wait for 100 ns;

        i <= "101";
        wait for 100 ns;

        i <= "110";
        wait for 100 ns;

        i <= "111";
        wait for 100 ns;

        wait;  -- Stop simulation
    end process;

end Behavioral;
