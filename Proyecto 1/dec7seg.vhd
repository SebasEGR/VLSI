library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'dec7seg'
entity dec7seg is
    port (
        entrada: in integer;                        -- Entrada: un valor entero (0-9) para mostrar en el display de 7 segmentos
        salida: out std_logic_vector(6 downto 0)    -- Salida: el patrón de 7 segmentos correspondiente a 'entrada'
    );
end entity dec7seg;

-- Definición de la arquitectura 'arqdec' de la entidad 'dec7seg'
architecture arqdec of dec7seg is
begin

    -- Usando 'with-when' para seleccionar el patrón adecuado para la entrada
    with entrada select
        salida <=
            "1000000" when 0,  -- El valor 0 en el display de 7 segmentos se representa con '1000000'
            "1111001" when 1,  -- El valor 1 en el display de 7 segmentos se representa con '1111001'
            "0100100" when 2,  -- El valor 2 en el display de 7 segmentos se representa con '0100100'
            "0110000" when 3,  -- El valor 3 en el display de 7 segmentos se representa con '0110000'
            "0011001" when 4,  -- El valor 4 en el display de 7 segmentos se representa con '0011001'
            "0010010" when 5,  -- El valor 5 en el display de 7 segmentos se representa con '0010010'
            "0000010" when 6,  -- El valor 6 en el display de 7 segmentos se representa con '0000010'
            "1111000" when 7,  -- El valor 7 en el display de 7 segmentos se representa con '1111000'
            "0000000" when 8,  -- El valor 8 en el display de 7 segmentos se representa con '0000000'
            "0011000" when 9,  -- El valor 9 en el display de 7 segmentos se representa con '0011000'
            "1111111" when others;  -- En caso de que 'entrada' no sea un valor de 0 a 9, la salida se apaga ('1111111')

end architecture arqdec;
