library ieee;
use ieee.std_logic_1164.all;

entity senal is
port(
    clk: in std_logic;
    snl: out std_logic
);
end entity;

architecture arqsenal of senal is
    signal conteo: integer range 0 to 25000000 := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if conteo <= 500 then
                snl <= '1';
            else
                snl <= '0';
            end if;

            if conteo = 25000000 then
                conteo <= 0;
            else
                conteo <= conteo + 1;
            end if;
        end if;
    end process;
end architecture;