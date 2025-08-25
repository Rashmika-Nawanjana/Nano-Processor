library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Seven_Segment_TB is
--  Port ( );
end Seven_Segment_TB;

architecture Behavioral of Seven_Segment_TB is

    component LUT_16_7
        Port (
            address : in STD_LOGIC_VECTOR(3 downto 0);
            data : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    signal address : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal data    : STD_LOGIC_VECTOR(6 downto 0);

begin

    uut: LUT_16_7
        Port map (
            address => address,
            data => data
        );

    stim_proc: process
    begin
        for i in 0 to 15 loop
            address <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;

        wait; 
    end process;

end Behavioral;
