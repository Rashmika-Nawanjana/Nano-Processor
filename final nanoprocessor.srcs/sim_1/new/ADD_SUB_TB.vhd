library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADD_SUB_TB is
--  Port ( );
end ADD_SUB_TB;

architecture Behavioral of ADD_SUB_TB is

    component ADD_SUB
        Port ( 
            A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            AddSub_Select : in STD_LOGIC;
            Overflow : out STD_LOGIC;
            Zero : out STD_LOGIC;
            S : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal A_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal B_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal AddSub_Select_tb : STD_LOGIC;
    signal Overflow_tb : STD_LOGIC;
    signal Zero_tb : STD_LOGIC;
    signal S_tb : STD_LOGIC_VECTOR (3 downto 0);

begin

    uut: ADD_SUB port map (
        A => A_tb,
        B => B_tb,
        AddSub_Select => AddSub_Select_tb,
        Overflow => Overflow_tb,
        Zero => Zero_tb,
        S => S_tb
    );

    stim_proc: process
    begin
        --230253 => 11 1000 0011 0110 1101 
        -- Test case 1: 1101 + 0110 (13 + 6 = 19)
        A_tb <= "1101";
        B_tb <= "0110";
        AddSub_Select_tb <= '0';  -- 0 = Addition
        wait for 10 ns;
        
        --Test case 2: subtract 15 from 8 
        AddSub_Select_tb <= '1'; 
        A_tb <= "1000"; 
        B_tb <= "1111";
        AddSub_Select_tb <= '1';  
        wait for 10 ns;
                       

        -- Test case 3: 0011 + 1000 (3 + 8 = 11)
        A_tb <= "0011";
        B_tb <= "1000";
        AddSub_Select_tb <= '0';  -- 0 = Addition
        wait for 10 ns;
        
       
        --Test case 4: subtract 7 from 15         
        AddSub_Select_tb <= '1'; 
        A_tb <= "1111"; 
        B_tb <= "0111";  

        wait;
    end process;

end Behavioral;
