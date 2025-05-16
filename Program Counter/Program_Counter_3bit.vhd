library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter_3bit is
    Port (
        Mux_out : in STD_LOGIC_VECTOR(2 downto 0);  -- Next PC value
        Clk     : in STD_LOGIC;
        Res     : in STD_LOGIC;
        EN      : in STD_LOGIC;
        Q       : out STD_LOGIC_VECTOR(2 downto 0)  -- Current PC value
    );
end Program_Counter_3bit;

architecture Behavioral of Program_Counter_3bit is

    component D_FF
        Port (
            D    : in STD_LOGIC;
            Res  : in STD_LOGIC;
            Clk  : in STD_LOGIC;
            EN   : in STD_LOGIC;
            Q    : out STD_LOGIC;
            Qbar : out STD_LOGIC
        );
    end component;

    signal dummy_Qbar : STD_LOGIC_VECTOR(2 downto 0);  -- Unused Qbar

begin

    D_FF0: D_FF
        port map (
            D     => Mux_out(0),
            Res   => Res,
            Clk   => Clk,
            EN    => EN,
            Q     => Q(0),
            Qbar  => dummy_Qbar(0)
        );

    D_FF1: D_FF
        port map (
            D     => Mux_out(1),
            Res   => Res,
            Clk   => Clk,
            EN    => EN,
            Q     => Q(1),
            Qbar  => dummy_Qbar(1)
        );

    D_FF2: D_FF
        port map (
            D     => Mux_out(2),
            Res   => Res,
            Clk   => Clk,
            EN    => EN,
            Q     => Q(2),
            Qbar  => dummy_Qbar(2)
        );

end Behavioral;
