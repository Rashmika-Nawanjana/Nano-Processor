----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:10:32 AM
-- Design Name: 
-- Module Name: w2_4_MUX_TB - Behavioral
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

entity w2_4_MUX_TB is
--  Port ( );
end w2_4_MUX_TB;

architecture Behavioral of w2_4_MUX_TB is

component w2_4_MUX is
Port ( Load_Select : in STD_LOGIC;
       Immediate : in STD_LOGIC_VECTOR (3 downto 0);
       S : in STD_LOGIC_VECTOR (3 downto 0);
       Value_In : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Load_Select : STD_LOGIC; 
signal Immediate :  STD_LOGIC_VECTOR (3 downto 0); 
signal S :  STD_LOGIC_VECTOR (3 downto 0); 
signal Value_In :  STD_LOGIC_VECTOR (3 downto 0);

begin

UUT: w2_4_MUX port map( 
             Load_Select => Load_Select,  
             Immediate => Immediate,    
             S  => S ,               
             Value_In => Value_In 
          ); 
          
     stimulus_proc: process 
                   begin 

              Load_Select <= '0'; 
              Immediate <= "0101"; 
              S <= "0111"; 
              wait for 100 ns; 
       
              Load_Select <= '1'; 
              Immediate <= "0011"; 
              S <= "1000"; 
              wait for 100 ns; 
               
              load_select <= '1'; 
              Immediate <= "1100"; 
              S <= "1011"; 
              wait for 100 ns; 
               
              wait; 
          end process stimulus_proc;           
end Behavioral;
