library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'divf'
entity divf is
    -- Declaración de un parámetro genérico llamado 'num' con valor predeterminado de 25,000,000
    generic (num: integer := 25000000); 
    port (
        clk: in std_logic;         -- Entrada del reloj (clk)
        clkl: buffer std_logic := '0'  -- Salida del reloj dividido (clkl), tipo buffer para permitir lectura y escritura
    ); 
end entity;

-- Definición de la arquitectura 'arqdivf' de la entidad 'divf'
architecture arqdivf of divf is
    -- Declaración de una señal 'conteo' que llevará el conteo del tiempo en un rango de 0 a 'num'
    signal conteo: integer range 0 to num; 
begin

    -- Proceso sensible al flanco ascendente del reloj 'clk'
    process(clk) 
    begin
    
        -- Cuando ocurre un flanco ascendente del reloj 'clk'
        if(rising_edge(clk)) then
        
            -- Si 'conteo' llega a 'num', reinicia el contador y cambia el valor de 'clkl' (complementando su valor)
            if(conteo = num) then 
                conteo <= 0;  -- Reinicia el contador a 0
                clkl <= not clkl;  -- Cambia el estado de 'clkl' (si estaba en '0', pasa a '1' y viceversa)
            else
                -- Si 'conteo' no ha llegado a 'num', incrementa 'conteo' en 1
                conteo <= conteo + 1; 
            end if;
            
        end if;
        
    end process;

end architecture;
