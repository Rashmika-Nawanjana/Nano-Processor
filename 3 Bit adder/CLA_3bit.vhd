library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_3bit is
    Port (
        A     : in  STD_LOGIC_VECTOR(2 downto 0);
        B     : in  STD_LOGIC_VECTOR(2 downto 0);
        Cin   : in  STD_LOGIC;
        Sum   : out STD_LOGIC_VECTOR(2 downto 0);
        Cout  : out STD_LOGIC
    );
end CLA_3bit;

architecture Behavioral of CLA_3bit is

    component FA
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            C_in  : in  STD_LOGIC;
            S     : out STD_LOGIC;
            C_out : out STD_LOGIC
        );
    end component;

    signal P, G : STD_LOGIC_VECTOR(2 downto 0); -- propagate and generate
    signal C    : STD_LOGIC_VECTOR(3 downto 0); -- carries, C(0) = Cin

begin

    C(0) <= Cin;

    -- Propagate and generate signals
    P(0) <= A(0) xor B(0);
    P(1) <= A(1) xor B(1);
    P(2) <= A(2) xor B(2);

    G(0) <= A(0) and B(0);
    G(1) <= A(1) and B(1);
    G(2) <= A(2) and B(2);

    -- Carry Lookahead logic
    C(1) <= G(0) or (P(0) and C(0));
    C(2) <= G(1) or (P(1) and C(1));
    C(3) <= G(2) or (P(2) and C(2));

    -- Full Adders with explicit named port mapping
    FA0: FA port map (
        A     => A(0),
        B     => B(0),
        C_in  => C(0),
        S     => Sum(0),
        C_out => open
    );

    FA1: FA port map (
        A     => A(1),
        B     => B(1),
        C_in  => C(1),
        S     => Sum(1),
        C_out => open
    );

    FA2: FA port map (
        A     => A(2),
        B     => B(2),
        C_in  => C(2),
        S     => Sum(2),
        C_out => open
    );

    Cout <= C(3);

end Behavioral;
