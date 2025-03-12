library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
port(
    echo, clkl, rst: in std_logic;
    salida, salida2: out std_logic := '0';
    ss0, ss1, ss2: out std_logic_vector(3 downto 0)
);
end entity;

architecture arqcontador of contador is
    signal conteo: integer range 0 to 23529 := 0;
    signal distancia: integer := 0;
begin
    process(echo, clkl, rst)
    begin
        if rst = '1' then
            conteo <= 0;
            salida <= '0';
            salida2 <= '0';
            ss0 <= "0000";
            ss1 <= "0000";
            ss2 <= "0000";
        elsif rising_edge(clkl) then
            if echo = '1' then
                conteo <= conteo + 1;
            else
                distancia <= conteo / 59; -- Conversión de conteo a cm
                if distancia >= 2 and distancia <= 400 then
                    salida2 <= '1'; -- Enciende mientras esté en el rango de 2 a 400 cm
                else
                    salida2 <= '0';
                end if;
                if distancia = 5 or distancia = 20 then
                    salida <= '1';
                else
                    salida <= '0';
                end if;
                ss0 <= std_logic_vector(to_unsigned(distancia mod 10, 4));
                ss1 <= std_logic_vector(to_unsigned((distancia / 10) mod 10, 4));
                ss2 <= std_logic_vector(to_unsigned((distancia / 100) mod 10, 4));
            end if;
        end if;
    end process;
end architecture;
