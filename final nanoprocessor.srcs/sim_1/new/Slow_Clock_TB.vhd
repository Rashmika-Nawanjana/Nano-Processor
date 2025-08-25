library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Slow_Clock_TB is
--  Port ( );
end Slow_Clock_TB;

architecture Behavioral of Slow_Clock_TB is

    component Slow_Clk
        Port (
            Clk_in  : in  STD_LOGIC;
            Clk_out : out STD_LOGIC
        );
    end component;

    signal Clk_in_tb  : STD_LOGIC := '0';
    signal Clk_out_tb : STD_LOGIC;

    constant clk_period : time := 10 ns;  -- 100 MHz clock

begin

    uut: Slow_Clk port map (
        Clk_in  => Clk_in_tb,
        Clk_out => Clk_out_tb
    );

    clk_process: process
    begin
        while true loop
            Clk_in_tb <= '0';
            wait for clk_period / 2;
            Clk_in_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        wait for 2 ms; 
        wait;
    end process;

end Behavioral;
