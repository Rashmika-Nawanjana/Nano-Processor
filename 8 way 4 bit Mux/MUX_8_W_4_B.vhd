----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 12:05:38 PM
-- Design Name: 
-- Module Name: MUX_8_W_4_B - Behavioral
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

entity Mux_8_W_4_B is
    Port ( 
        A0     : in  STD_LOGIC_VECTOR (3 downto 0);
        A1     : in  STD_LOGIC_VECTOR (3 downto 0);
        A2     : in  STD_LOGIC_VECTOR (3 downto 0);
        A3     : in  STD_LOGIC_VECTOR (3 downto 0);
        A4     : in  STD_LOGIC_VECTOR (3 downto 0);
        A5     : in  STD_LOGIC_VECTOR (3 downto 0);
        A6     : in  STD_LOGIC_VECTOR (3 downto 0);
        A7     : in  STD_LOGIC_VECTOR (3 downto 0);
        C_OUT  : out STD_LOGIC_VECTOR (3 downto 0);
        S      : in  STD_LOGIC_VECTOR (2 downto 0)
    );
end Mux_8_W_4_B;

architecture Behavioral of Mux_8_W_4_B is

    component Mux_2_W_4_B
        Port ( 
            A_in  : in  STD_LOGIC_VECTOR (3 downto 0);
            B_in  : in  STD_LOGIC_VECTOR (3 downto 0);
            S_in  : in  STD_LOGIC;
            C_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal Mux_2_way_out_1 : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_2_way_out_2 : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_2_way_out_3 : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_2_way_out_4 : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_2_way_out_5 : STD_LOGIC_VECTOR (3 downto 0);
    signal Mux_2_way_out_6 : STD_LOGIC_VECTOR (3 downto 0);

begin

    Mux2_1 : Mux_2_W_4_B
        port map (
            A_in  => A0,
            B_in  => A1,
            S_in  => S(0),
            C_out => Mux_2_way_out_1
        );

    Mux2_2 : Mux_2_W_4_B
        port map (
            A_in  => A2,
            B_in  => A3,
            S_in  => S(0),
            C_out => Mux_2_way_out_2
        );

    Mux2_3 : Mux_2_W_4_B
        port map (
            A_in  => A4,
            B_in  => A5,
            S_in  => S(0),
            C_out => Mux_2_way_out_3
        );

    Mux2_4 : Mux_2_W_4_B
        port map (
            A_in  => A6,
            B_in  => A7,
            S_in  => S(0),
            C_out => Mux_2_way_out_4
        );

    Mux2_5 : Mux_2_W_4_B
        port map (
            A_in  => Mux_2_way_out_1,
            B_in  => Mux_2_way_out_2,
            S_in  => S(1),
            C_out => Mux_2_way_out_5
        );

    Mux2_6 : Mux_2_W_4_B
        port map (
            A_in  => Mux_2_way_out_3,
            B_in  => Mux_2_way_out_4,
            S_in  => S(1),
            C_out => Mux_2_way_out_6
        );

    Mux2_7 : Mux_2_W_4_B
        port map (
            A_in  => Mux_2_way_out_5,
            B_in  => Mux_2_way_out_6,
            S_in  => S(2),
            C_out => C_OUT
        );

end Behavioral;
