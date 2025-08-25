library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA_TB is
--  Port ( );
end FA_TB;

architecture Behavioral of FA_TB is

    component FA
        Port (
            A     : in STD_LOGIC;
            B     : in STD_LOGIC;
            C_in  : in STD_LOGIC;
            S     : out STD_LOGIC;
            C_out : out STD_LOGIC
        );
    end component;

    signal A     : STD_LOGIC := '0';
    signal B     : STD_LOGIC := '0';
    signal C_in  : STD_LOGIC := '0';
    signal S     : STD_LOGIC;
    signal C_out : STD_LOGIC;

begin

    uut: FA
        Port map (
            A     => A,
            B     => B,
            C_in  => C_in,
            S     => S,
            C_out => C_out
        );

    stim_proc: process
    begin
        --230062 => 11 1000 0010 1010 1110
        -- First input: 1110 ? A=1, B=1, C_in=0
        A     <= '1';
        B     <= '1';
        C_in  <= '0';
        wait for 10 ns;

        -- Second input: 1010 ? A=1, B=0, C_in=1
        A     <= '1';
        B     <= '0';
        C_in  <= '1';
        wait for 10 ns;

        -- Third input: 0010 ? A=0, B=0, C_in=1
        A     <= '0';
        B     <= '0';
        C_in  <= '1';
        wait for 10 ns;

        -- Fourth input: 1000 ? A=1, B=0, C_in=0
        A     <= '1';
        B     <= '0';
        C_in  <= '0';
        wait for 10 ns;

        wait; 
    end process;

end Behavioral;
