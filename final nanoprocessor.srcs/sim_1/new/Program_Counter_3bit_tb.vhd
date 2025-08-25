library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter_3bit_tb is
end Program_Counter_3bit_tb;

architecture Behavioral of Program_Counter_3bit_tb is

    -- Component Declaration
    component Program_Counter_3bit
        Port (
            Mux_out : in STD_LOGIC_VECTOR(2 downto 0);
            Clk     : in STD_LOGIC;
            Res     : in STD_LOGIC;
            EN      : in STD_LOGIC;
            Q       : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals for connection
    signal Mux_out : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Clk     : STD_LOGIC := '0';
    signal Res     : STD_LOGIC := '0';
    signal EN      : STD_LOGIC := '1';
    signal Q       : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Program_Counter_3bit
        port map (
            Mux_out => Mux_out,
            Clk     => Clk,
            Res     => Res,
            EN      => EN,
            Q       => Q
        );

    -- Clock generation (10 ns period)
    clk_process : process
    begin
        while true loop
            Clk <= '0';
            wait for 5 ns;
            Clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Step 1: Apply reset
        Res <= '1';
        wait for 10 ns;
        Res <= '0';

        -- Step 2: Load 001 into PC
        Mux_out <= "001";
        wait for 10 ns;

        -- Step 3: Load 010
        Mux_out <= "010";
        wait for 10 ns;

        -- Step 4: Load 011
        Mux_out <= "011";
        wait for 10 ns;

        -- Step 5: Disable EN (PC should not update)
        EN <= '0';
        Mux_out <= "100";
        wait for 10 ns;

        -- Step 6: Re-enable EN (PC should now update)
        EN <= '1';
        wait for 10 ns;

        -- Step 7: Reset again
        Res <= '1';
        wait for 10 ns;
        Res <= '0';

        wait for 20 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
