----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 01:17:20 PM
-- Design Name: 
-- Module Name: Mux_2_W_4_B - Behavioral
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

entity Mux_2_W_4_B is
    Port ( 
        S_in  : in  STD_LOGIC;
        A_in  : in  STD_LOGIC_VECTOR (3 downto 0);
        B_in  : in  STD_LOGIC_VECTOR (3 downto 0);
        C_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Mux_2_W_4_B;

architecture Behavioral of Mux_2_W_4_B is

    component Tri_State_Buffer_4_B is
        Port ( 
            data_in  : in  STD_LOGIC_VECTOR (3 downto 0);
            enable   : in  STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal s, s_not : STD_LOGIC;

begin

    s      <= S_in;
    s_not  <= NOT S_in;

    buff_0 : Tri_State_Buffer_4_B
        port map (
            data_in  => A_in,
            enable   => s_not,
            data_out => C_out
        );

    buff_1 : Tri_State_Buffer_4_B
        port map (
            data_in  => B_in,
            enable   => s,
            data_out => C_out
        );

end Behavioral;
