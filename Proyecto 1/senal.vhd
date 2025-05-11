library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Definición de la entidad 'senal'
entity senal is
    port (
        clk: in std_logic;         -- Entrada de reloj
        duty: in integer;          -- Entrada para el valor de ciclo de trabajo (duty cycle)
        limite: in integer;        -- Entrada para el límite del ciclo
        snl: out std_logic         -- Salida de la señal controlada
    );
end entity;

-- Definición de la arquitectura 'arqsenal' de la entidad 'senal'
architecture arqsenal of senal is
    constant lim: integer := limite;  -- Definición de constante que toma el valor de 'limite'
    signal conteo: integer := 0;      -- Signal para contar las iteraciones, inicialmente en 0
begin

    -- Proceso sensible al reloj (clk)
    process(clk)
    begin
        -- Verifica el flanco ascendente del reloj
        if(rising_edge(clk)) then
            
            -- Si el conteo es menor o igual que el ciclo de trabajo (duty), la salida 'snl' es 1
            if(conteo <= duty) then
                snl <= '1';  -- Enciende la salida
            else
                snl <= '0';  -- Apaga la salida
            end if;
            
            -- Si el conteo llega al límite, se reinicia a 0, sino, se incrementa
            if(conteo = limite) then
                conteo <= 0;  -- Reinicia el contador al llegar al límite
            else
                conteo <= conteo + 1;  -- Incrementa el contador
            end if;
            
        end if;
    end process;

end architecture;
