library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CLA_3bit_tb is
end CLA_3bit_tb;

architecture Behavioral of CLA_3bit_tb is

    -- Component Declaration of the Unit Under Test (UUT)
    component CLA_3bit
        Port (
            A     : in  STD_LOGIC_VECTOR(2 downto 0);
            B     : in  STD_LOGIC_VECTOR(2 downto 0);
            Cin   : in  STD_LOGIC;
            Sum   : out STD_LOGIC_VECTOR(2 downto 0);
            Cout  : out STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal A_tb    : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal B_tb    : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Cin_tb  : STD_LOGIC := '0';
    signal Sum_tb  : STD_LOGIC_VECTOR(2 downto 0);
    signal Cout_tb : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: CLA_3bit
        port map (
            A     => A_tb,
            B     => B_tb,
            Cin   => Cin_tb,
            Sum   => Sum_tb,
            Cout  => Cout_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test vector 1: 000 + 000 + 0 = 000
        A_tb <= "000"; B_tb <= "000"; Cin_tb <= '0';
        wait for 10 ns;

        -- Test vector 2: 001 + 001 + 0 = 010
        A_tb <= "001"; B_tb <= "001"; Cin_tb <= '0';
        wait for 10 ns;

        -- Test vector 3: 010 + 010 + 1 = 101
        A_tb <= "010"; B_tb <= "010"; Cin_tb <= '1';
        wait for 10 ns;

        -- Test vector 4: 011 + 011 + 0 = 110
        A_tb <= "011"; B_tb <= "011"; Cin_tb <= '0';
        wait for 10 ns;

        -- Test vector 5: 100 + 100 + 0 = 000 (overflow)
        A_tb <= "100"; B_tb <= "100"; Cin_tb <= '0';
        wait for 10 ns;

        -- Test vector 6: 111 + 111 + 1 = 111 (Sum), Cout = 1
        A_tb <= "111"; B_tb <= "111"; Cin_tb <= '1';
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
