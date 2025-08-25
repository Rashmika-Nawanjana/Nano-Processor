library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nano_Processor_tb is
end Nano_Processor_tb;

architecture Behavioral of Nano_Processor_tb is

    -- Component Declaration
    COMPONENT Nano_Processor
        PORT (
            Reset         : in  STD_LOGIC;
            Clk_in        : in  STD_LOGIC;
            Zero          : out STD_LOGIC;
            Overflow      : out STD_LOGIC;
            RLED          : out STD_LOGIC_VECTOR(3 downto 0);
            Seven_Seg_Out : out STD_LOGIC_VECTOR(6 downto 0);
            Anode         : out STD_LOGIC_VECTOR(3 downto 0);
            Clk_Step      : in STD_LOGIC;
            Clk_Mode      : in STD_LOGIC 
        );
    END COMPONENT;

    -- Signals for stimulus and output observation
    signal Reset         : STD_LOGIC;
    signal Clk_in        : STD_LOGIC ;
    signal Zero          : STD_LOGIC;
    signal Overflow      : STD_LOGIC;
    signal RLED          : STD_LOGIC_VECTOR(3 downto 0);
    signal Seven_Seg_Out : STD_LOGIC_VECTOR(6 downto 0);
    signal Anode         : STD_LOGIC_VECTOR(3 downto 0);
    signal Clk_Step, Clk_Mode  : STD_LOGIC;

begin

    -- Instantiate the Nano Processor
    uut: Nano_Processor
        PORT MAP (
            Reset         => Reset,
            Clk_in        => Clk_in,
            Zero          => Zero,
            Overflow      => Overflow,
            RLED          => RLED,
            Seven_Seg_Out => Seven_Seg_Out,
            Anode         => Anode,
            Clk_Step      => Clk_Step ,
            Clk_Mode      => Clk_Mode  
        );

    -- Clock generation: 5 ns period (200 MHz)
    clk_process : process
    begin
        while true loop
            Clk_in <= '0';
            wait for 4 ns;
            Clk_in <= '1';
            wait for 4 ns;
        end loop;
    end process;

    -- Reset and simulation logic
    stim_proc: process
    begin
        -- Apply reset pulse
--        Reset <= '1';
--        wait for 42 ns;
        Reset <= '0';
        Clk_Step <= '1';
        Clk_Mode  <= '0';
        
        
--        wait for 100 ns;
--        Reset <= '1';
--        wait for 42 ns;
--        Reset <= '0';

        -- Let it run for some cycles (adjust as needed)
        wait for 1000 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
