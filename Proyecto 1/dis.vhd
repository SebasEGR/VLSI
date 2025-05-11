library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity distancia is
    port (
        clk: in std_logic;
        dis: in integer;  -- Entrada de la distancia
        valor_distancia: out integer  -- Salida del valor entre 0 y 9
    );
end entity;

architecture arqdis of distancia is
    signal contador: integer range 0 to 9 := 0;  -- Contador de 0 a 9
begin

    process (clk, dis)
    begin
        if rising_edge(clk) then
            -- Mapeo de la distancia dis a un valor entre 0 y 9
            if dis >= 0 and dis <= 99 then
                contador <= dis / 10;  -- Esto convierte dis de 0-99 a 0-9
            end if;

            -- Actualizar salida con el valor del contador
            valor_distancia <= contador;  -- Asignación del valor de contador a valor_distancia
        end if;
    end process;

end architecture;
