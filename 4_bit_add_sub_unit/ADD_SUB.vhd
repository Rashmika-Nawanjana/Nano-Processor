----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:57:00 PM
-- Design Name: 
-- Module Name: ADD_SUB - Behavioral
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

entity ADD_SUB is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           AddSub_Select : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
end ADD_SUB;

architecture Behavioral of ADD_SUB is

component FA
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       C_in : in STD_LOGIC;
       S : out STD_LOGIC;
       C_out : out STD_LOGIC);
end component;

SIGNAL FA0_S, FA0_C, FA1_S, FA1_C, FA2_S, FA2_C, FA3_S, FA3_C , B0, B1, B2, B3 : std_logic; 
SIGNAL S_out : STD_LOGIC_VECTOR(3 downto 0);
begin

B0 <= B(0) XOR AddSub_Select;
B1 <= B(1) XOR AddSub_Select;
B2 <= B(2) XOR AddSub_Select;
B3 <= B(3) XOR AddSub_Select;

FA_0 : FA 
    port map (   
        A => A(0),   
        B => B0, 
        C_in => AddSub_Select , 
        S => S_out(0),   
        C_Out => FA0_C);  

FA_1 : FA 
    port map (   
        A => A(1),   
        B => B1, 
        C_in => FA0_C,    
        S => S_out(1),   
        C_Out => FA1_C); 
FA_2 : FA 
    port map (   
        A => A(2),   
        B => B2, 
        C_in => FA1_C,    
        S => S_out(2),   
        C_Out => FA2_C); 

FA_3 : FA 
    port map (   
        A => A(3),   
        B => B3, 
        C_in => FA2_C,    
        S => S_out(3),   
        C_Out => FA3_C); 
 Overflow <= FA2_C;
 S <= S_out;
 Zero <= not (S_out(0) or S_out(1) or S_out(2) or S_out(3) or FA3_C);

end Behavioral;
