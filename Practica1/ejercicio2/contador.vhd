library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        clk: in std_logic;
        ssg: out std_logic_vector(6 downto 0);
        bandera: out std_logic
    );
end entity;

architecture a of contador is
    signal clkl: std_logic;
    signal conteo: integer range 0 to 9;
begin
    u1: entity work.divf(a) port map(clk, clkl);
    u2: entity work.cont(a) port map(clkl, conteo, bandera);
    u3: entity work.ss7(a) port map(conteo, ssg);
end architecture;
